import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stream_builder_example/commons.dart';

class TraditionalStreamExample extends StatefulWidget {
  const TraditionalStreamExample({Key? key}) : super(key: key);

  @override
  _TraditionalStreamExampleState createState() =>
      _TraditionalStreamExampleState();
}

class _TraditionalStreamExampleState extends State<TraditionalStreamExample> {
  bool isLoading = false, dataAvailable = false;
  String errorStatement = "";
  late String currentData;

  @override
  void initState() {
    super.initState();
    // Calling PostCallFrameCallback because BuildContext
    // is needed in the getDataStream() function
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      isLoading = true;
      setState(() {});
      StreamSubscription subs = getDataStream(context).listen(null);

      subs.onData(onDataReceived);
      subs.onError(onErrorReceived);
      subs.onDone(() {
        subs.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Traditional Stream Example")),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : dataAvailable
              ? getImageView(currentData)
              : Center(child: Text(errorStatement)),
    );
  }

  void onDataReceived(data) {
    if (data == null || data.toString().isEmpty) {
      errorStatement = "No Data Received";
      dataAvailable = false;
      isLoading = false;
      setState(() {});
      return;
    }
    isLoading = false;
    dataAvailable = true;
    currentData = data;
    setState(() {});
  }

  void onErrorReceived(e) {
    isLoading = false;
    dataAvailable = false;
    errorStatement = e;
    setState(() {});
  }
}
