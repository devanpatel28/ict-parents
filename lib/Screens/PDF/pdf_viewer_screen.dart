import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../Helper/Colors.dart';
import '../../Helper/Style.dart';
import '../Loading/adaptive_loading_screen.dart';

class PDFViewerScreen extends StatelessWidget {
  final String documentPath;

  const PDFViewerScreen({super.key, required this.documentPath});

  Future<String?> _loadPDF(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File(dir.path);
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Document",
          style: appbarStyle(context),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: backgroundColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: documentPath.startsWith('http')
          ? FutureBuilder<String?>(
        future: _loadPDF(documentPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AdaptiveLoadingScreen();
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Error loading PDF"));
          }
          return PDFView(
            filePath: snapshot.data!,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: $error")),
              );
            },
            onRender: (pages) {
              // Optional: Handle render completion
            },
          );
        },
      )
          : PDFView(
        filePath: documentPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $error")),
          );
        },
        onRender: (pages) {
          // Optional: Handle render completion
        },
      ),
    );
  }
}