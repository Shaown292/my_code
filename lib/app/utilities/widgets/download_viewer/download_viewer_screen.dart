import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';


class DownloadViewer extends StatelessWidget {
  final String? filePath;
  const DownloadViewer({super.key, this.filePath});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDF.network(
        filePath ?? '',
      ),
    );
  }
}