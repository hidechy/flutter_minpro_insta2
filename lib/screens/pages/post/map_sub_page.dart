import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../models/location.dart';
import '../../../viewmodel/post_viewmodel.dart';

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

  // GoogleMapController? _mapController;

  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: _onPlaceSelected,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
//        onMapCreated: onMapCreated,
        onTap: onMapTapped,
        markers: Set<Marker>.of(_markers.values),
      ),
    );
  }

  // ///
  // void onMapCreated(GoogleMapController controller) {
  //   //    _mapController = controller;
  // }

  ///
  void onMapTapped(LatLng latLng) {
    debugPrint('selected place: $latLng');

    _latLng = latLng;
    _createMarker();
  }

  ///
  void _createMarker() {
    const markerId = MarkerId('selected');
    final marker = Marker(markerId: markerId, position: _latLng);

    setState(() {
      _markers[markerId] = marker;
    });
  }

  ///
  Future<void> _onPlaceSelected() async {
    final postViewModel = context.read<PostViewModel>();

    await postViewModel.updateLocation(latitude: _latLng.latitude, longitude: _latLng.longitude);

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
