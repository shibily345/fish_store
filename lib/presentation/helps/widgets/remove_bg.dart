import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remove_background/remove_background.dart';

class ImgRemoveBg {
  ui.Image? image;
  ByteData? pngBytes;

//function for removing background
  Future<Uint8List> removeBg(context, XFile xFile) async {
    image = await decodeImageFromList(await xFile.readAsBytes());
    pngBytes = await cutImage(context: context, image: image!);
    return Uint8List.view(pngBytes!.buffer);
  }
}
