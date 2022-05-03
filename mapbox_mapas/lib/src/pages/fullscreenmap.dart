import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({Key? key}) : super(key: key);

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {

  MapboxMapController? mapController;
  final center = const LatLng(6.091859, -75.636030);
  final oscuroStyle = 'mapbox://styles/menamiguel/cl2o518eb002714od4mo0r2jb';
  final streetsStyle = 'mapbox://styles/menamiguel/cl2o53mzn001i14mn8jhenrp2';
  String selectedStyle = 'mapbox://styles/menamiguel/cl2o53mzn001i14mn8jhenrp2';

  _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded(){
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl("networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController!.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController!.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        // Simbolos
        FloatingActionButton(
          child: const Icon(Icons.smart_toy_sharp),
          onPressed: () {
            mapController!.addSymbol(SymbolOptions(
              geometry: center,
              // iconSize: 10,
              iconImage: 'assetImage',
              textField: 'Montaña creada aquí',
              textOffset: const Offset(0, 3),
            ));
          }
        ),

        const SizedBox(height: 5,),

        // Zoom in
        FloatingActionButton(
          child: const Icon(Icons.zoom_in),
          onPressed: () {
            mapController!.animateCamera(CameraUpdate.zoomIn());
          }
        ),

        const SizedBox(height: 5,),

        // Zoom out
        FloatingActionButton(
          child: const Icon(Icons.zoom_out),
          onPressed: () {
            mapController!.animateCamera(CameraUpdate.zoomOut());
          }
        ),

        const SizedBox(height: 5,),

        // Cambiar estilo
        FloatingActionButton(
          child: const Icon(Icons.add_to_home_screen),
          onPressed: (){
            if(selectedStyle == oscuroStyle){
              selectedStyle = streetsStyle;
            }else{
              selectedStyle = oscuroStyle;
            }
            _onStyleLoaded();
            setState(() {});
          }
        )
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
    styleString: selectedStyle,
    accessToken: 'sk.eyJ1IjoibWVuYW1pZ3VlbCIsImEiOiJjbDJudm04c3gwOXlkM2JwajR3d3g1Z3k1In0.TzCeXx-WTg1PUlYfoN8SUw',
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(target: center,zoom: 14),
    // onStyleLoadedCallback: _onStyleLoadedCallback,
  );
  }
}