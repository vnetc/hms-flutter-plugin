/*
    Copyright 2021-2022. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0
        
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import 'package:flutter/material.dart';
import 'package:huawei_ml_language/huawei_ml_language.dart';

import '../utils/demo_utils.dart';

class RttDemo extends StatefulWidget {
  const RttDemo({Key? key}) : super(key: key);

  @override
  _RttDemoState createState() => _RttDemoState();
}

class _RttDemoState extends State<RttDemo> {
  late MLSpeechRealTimeTranscription transcription;

  String res = 'initial result';

  @override
  void initState() {
    transcription = MLSpeechRealTimeTranscription();
    transcription.setRealTimeTranscriptionListener(
      MLSpeechRealTimeTranscriptionListener(
        onError: onError,
        onResult: onResult,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RTT Demo')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(res),
          ),
          recognitionButton(start, text: 'Start Recognition'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: start,
      ),
    );
  }

  // Rtt methods
  void start() {
    final config = MLSpeechRealTimeTranscriptionConfig(
      language: MLSpeechRealTimeTranscriptionConfig.LAN_EN_US,
      punctuationEnabled: true,
      wordTimeOffsetEnabled: true,
    );
    transcription.startRecognizing(config);
  }

  // Rtt listener methods

  void onError(int error, String errorMessage) {
    setState(() => res = 'Error: $error: $errorMessage');
  }

  void onResult(MLSpeechRealTimeTranscriptionResult result) {
    setState(() => res = result.result!);
  }
}
