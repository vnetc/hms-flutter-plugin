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
import 'package:huawei_ml_text/huawei_ml_text.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class TextExample extends StatefulWidget {
  const TextExample({Key? key}) : super(key: key);

  @override
  _TextExampleState createState() => _TextExampleState();
}

class _TextExampleState extends State<TextExample> with DemoMixin {
  final _key = GlobalKey<ScaffoldState>();

  late MLTextAnalyzer _analyzer;
  String? _res;

  @override
  void initState() {
    _analyzer = MLTextAnalyzer();
    _set();
    super.initState();
  }

  _set() async {
    MLTextApplication().setApiKey(homeApiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: demoAppBar(textAppbarText),
      body: Column(
        children: [
          resultBoxWidget(context, resultBoxText, _res),
          containerElevatedButton(
            context,
            ElevatedButton(
              style: buttonStyle,
              onPressed: () => pickerDialog(_key, context, analyze),
              child: Text(startRecognitionText),
            ),
          )
        ],
      ),
    );
  }

  @override
  void analyze(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }

    final setting = MLTextAnalyzerSetting.remote(path: path);
    try {
      final text = await _analyzer.asyncAnalyseFrame(setting);
      setState(() => _res = text.stringValue);
    } on Exception catch (e) {
      exceptionDialog(context, e.toString());
    }
  }

  @override
  void destroy() async {
    try {
      _analyzer.destroy();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void isAvailable() async {
    try {
      final res = await _analyzer.isAvailable();
      debugPrint(res.toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void stop() async {
    try {
      _analyzer.stop();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
