import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_titles.dart';

class DirreccionesPage extends StatelessWidget {
   
  const DirreccionesPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return const ScanTiles(tipo: 'http');
  }
}