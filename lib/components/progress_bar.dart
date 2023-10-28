import 'package:flutter/material.dart';

Widget progressBar() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 14),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
    ),
  );
}
