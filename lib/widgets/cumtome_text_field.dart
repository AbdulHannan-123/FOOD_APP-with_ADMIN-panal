import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CostumTextField extends StatelessWidget {

  final TextEditingController? controller;
  final String labtext;
  final TextInputType? keyboradType;

  CostumTextField({
    this.controller,
    this.keyboradType,
    required this.labtext
     });

  @override
  Widget build(BuildContext context) {
  return TextField(
    keyboardType: keyboradType,
    controller: controller,
    decoration: InputDecoration(
      labelText: labtext

    ),
  );    
  }
}