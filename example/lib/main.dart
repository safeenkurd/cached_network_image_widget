import 'package:flutter/material.dart';
import 'package:cached_network_image_widget/cached_network_image_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cached Network Image Widget Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CachedNetworkImageWidget(
                'https://picsum.photos/300/200',
                height: 200,
                width: 300,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              SizedBox(height: 20),
              CachedNetworkSvgWidget(
                'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg',
                height: 100,
                width: 100,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
