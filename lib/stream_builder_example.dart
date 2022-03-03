import 'package:flutter/material.dart';
import 'package:stream_builder_example/commons.dart';

class StreamBuilderExample extends StatefulWidget {
  const StreamBuilderExample({Key? key}) : super(key: key);

  @override
  State<StreamBuilderExample> createState() => _StreamBuilderExampleState();
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stream Builder Demo"),
      ),
      body: StreamBuilder(
        stream: getDataStream(context),
        builder: (context, AsyncSnapshot a) {
          if (a.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (a.connectionState == ConnectionState.active ||
              a.connectionState == ConnectionState.done) {
            if (a.hasError) {
              return const Center(child: Text("Error Occured"));
            }
            if (a.hasData && a.toString().isEmpty) {
              return getImageView(a.data);
            }

            return const Center(child: Text("No Data Received"));
          }
          return Center(child: Text(a.connectionState.toString()));
        },
      ),
    );
  }
}
