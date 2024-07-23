import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gmaps/const.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(31.5204, 74.3587), zoom: 14.4746);

  final List<Marker> _markers = <Marker>[];
  final List<Polyline> _polylines = <Polyline>[]; // List to store polylines
  final String _googleApiKey = googleApiKey;


  bool _isLoading = true; // State variable for loading
  double _distance = 0.0; // Variable to store the distance

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getCurrentLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // When app is resumed, attempt to fetch location again
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    setState(() {
      _isLoading = true; // Show loading indicator while fetching location
    });

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // If location services are not enabled, open location settings.
      _showSnackbar('Location services are disabled. Please enable them.');
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // If permissions are denied, show a Snackbar
        _showSnackbar('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // If permissions are denied forever, show a Snackbar and open app settings
      _showSnackbar(
          'Location permissions are permanently denied. Please enable them in settings.');
      await Geolocator.openAppSettings();
      return;
    }

    // If permissions are granted, access the current position.
    Position position = await Geolocator.getCurrentPosition();
    _updateCurrentLocation(position);
    setState(() {
      _isLoading = false; // Stop loading once location is fetched
    });
  }

  Future<void> _getPolyline(Position position) async {
    const destination = LatLng(32.6407, 74.1667); // University of Gujrat coordinates

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${position.latitude},${position.longitude}&destination=${destination.latitude},${destination.longitude}&key=$_googleApiKey';

    print('Requesting directions with URL: $url');

    try {
      final response = await http.get(Uri.parse(url));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] != 'OK') {
          _showSnackbar('Error: ${data['status']}');
          return;
        }

        if ((data['routes'] as List).isNotEmpty) {
          final points = data['routes'][0]['overview_polyline']['points'];

          final PolylinePoints polylinePoints = PolylinePoints();
          final List<PointLatLng> result = polylinePoints.decodePolyline(points);

          setState(() {
            _polylines.clear();
            _polylines.add(Polyline(
              polylineId: const PolylineId('route'),
              points:
                  result.map((point) => LatLng(point.latitude, point.longitude)).toList(),
              color: Colors.blue,
              width: 5,
            ));
          });
        } else {
          _showSnackbar('No routes found.');
        }
      } else {
        _showSnackbar('Failed to fetch directions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackbar('Error fetching directions: $e');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _updateCurrentLocation(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.0,
      ),
    ));

    const destination = LatLng(32.6407, 74.1667); // University of Gujrat coordinates

    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: 'Current Location'),
      ));

      _markers.add(const Marker(
        markerId: MarkerId('universityOfGujrat'),
        position: destination,
        infoWindow: InfoWindow(title: 'University of Gujrat'),
      ));
    });

    // Calculate the distance
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      destination.latitude,
      destination.longitude,
    );

    setState(() {
      _distance = distanceInMeters / 1000; // Convert meters to kilometers
    });

    // Fetch and draw the polyline
    _getPolyline(position);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: true,
              initialCameraPosition: _kGooglePlex,
              markers: Set<Marker>.of(_markers),
              polylines: Set<Polyline>.of(_polylines), // Add polylines to the map
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        'Fetching your location, please wait...',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            if (!_isLoading)
              Positioned(
                bottom: 30,
                left: 30,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.white.withOpacity(0.9),
                  child: Text(
                    'Distance : ${_distance.toStringAsFixed(2)} km',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
