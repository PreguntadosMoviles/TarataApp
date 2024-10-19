import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaTarata extends StatefulWidget {
  @override
  _MapaTarataState createState() => _MapaTarataState();
}

class _MapaTarataState extends State<MapaTarata> {
  GoogleMapController? _controller;

  final LatLng _center = const LatLng(-17.6078, -70.0735);  // Coordenadas de Tarata
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = const LatLng(-17.6078, -70.0735);

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('tarata_marker'),
          position: _center,
          infoWindow: InfoWindow(
            title: 'Tarata',
            snippet: 'Ubicación principal',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta de Acceso a Tarata'),
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: _markers,
              onCameraMove: (position) {
                _lastMapPosition = position.target;
              },
            ),
          ),
          Container(
            color: Colors.grey[900],
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLocationButton('Plaza', Icons.place, LatLng(-17.6083, -70.0732)),
                _buildLocationButton('Mercado', Icons.shopping_cart, LatLng(-17.6075, -70.0739)),
                _buildLocationButton('Iglesia Tarucachi', Icons.church, LatLng(-17.6068, -70.0740)),
                _buildLocationButton('Municipalidad', Icons.account_balance, LatLng(-17.6078, -70.0735)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButton(String label, IconData icon, LatLng location) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: () {
            _controller?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: location, zoom: 16.0),
              ),
            );
            setState(() {
              _markers.add(Marker(
                markerId: MarkerId(label),
                position: location,
                infoWindow: InfoWindow(title: label),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
              ));
            });
          },
        ),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
