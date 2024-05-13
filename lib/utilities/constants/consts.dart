import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String tokenString = "TOKEN";

const gradient = LinearGradient(colors: [
  Color(0xff3b0951),
  Color(0xff130023),
]);

var colors = Get.theme.colorScheme;

const border = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xc0ffffff)),
    borderRadius: BorderRadius.all(Radius.circular(16)));
