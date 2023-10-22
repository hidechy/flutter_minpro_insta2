import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../generated/l10n.dart';
import '../../../models/location.dart';

class MapSubPage extends StatefulWidget {
  const MapSubPage({super.key, required this.location});

  final LocationModel location;

  @override
  // ignore: library_private_types_in_public_api
  _MapSubPageState createState() => _MapSubPageState();
}

class _MapSubPageState extends State<MapSubPage> {
  late LatLng _latLng;
  late CameraPosition _cameraPosition;

  ///
  @override
  void initState() {
    _latLng = LatLng(widget.location.latitude, widget.location.longitude);

    _cameraPosition = CameraPosition(target: _latLng, zoom: 15);

    super.initState();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectPlace),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: null,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: onMapCreated,
      ),
    );
  }

  ///
  void onMapCreated(GoogleMapController controller) {}
}
