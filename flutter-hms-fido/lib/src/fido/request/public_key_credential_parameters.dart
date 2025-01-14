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

import 'package:flutter/foundation.dart';
import '../constant/fido_constants.dart';

class PublicKeyCredentialParameters {
  PublicKeyCredentialType? type;
  Algorithm? algorithm;

  PublicKeyCredentialParameters({this.type, this.algorithm});

  Map<String, dynamic> toMap() {
    return {
      "type": describeEnum(PublicKeyCredentialType.PUBLIC_KEY),
      "algorithm": algorithm != null ? describeEnum(algorithm!) : null
    };
  }

  PublicKeyCredentialType? get getType => type;

  Algorithm? get getAlgorithm => algorithm;
}
