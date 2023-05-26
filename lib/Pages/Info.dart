import 'dart:ui';
import 'package:flutter/material.dart';

var pixelRatio = window.devicePixelRatio;

//Size in physical pixels
var physicalScreenSize = window.physicalSize;
var physicalWidth = physicalScreenSize.width;
var physicalHeight = physicalScreenSize.height;

//Size in logical pixels
var logicalScreenSize = window.physicalSize / pixelRatio;
var logicalWidth = logicalScreenSize.width;
var logicalHeight = logicalScreenSize.height;

TextStyle drawer =TextStyle(
    fontSize: logicalWidth/17,
    fontWeight: FontWeight.bold,
    color: Colors.amber
  );
