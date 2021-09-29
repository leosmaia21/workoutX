import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

void goWrapper(BuildContext context) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => const Wrapper()), (_) => false);
}
