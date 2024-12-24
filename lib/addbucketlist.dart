import 'package:flutter/material.dart';

class AddbucketlistScreen extends StatefulWidget {
  const AddbucketlistScreen({super.key});

  @override
  State<AddbucketlistScreen> createState() => _AddbucketlistScreenState();
}

class _AddbucketlistScreenState extends State<AddbucketlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bucket list screen"),
      ),

    );
  }
}
