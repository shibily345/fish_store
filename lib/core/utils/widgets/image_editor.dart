// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_editor/image_editor.dart';
// import 'dart:typed_data';

// class ImageEditorPage extends StatefulWidget {
//   final String imagePath;

//   ImageEditorPage({required this.imagePath});

//   @override
//   _ImageEditorPageState createState() => _ImageEditorPageState();
// }

// class _ImageEditorPageState extends State<ImageEditorPage> {
//   late Uint8List _imageBytes;

//   @override
//   void initState() {
//     super.initState();
//     _loadImage();
//   }

//   Future<void> _loadImage() async {
//     final image = File(widget.imagePath);
//     final imageData = await image.readAsBytes();
//     setState(() {
//       _imageBytes = Uint8List.fromList(imageData);
//     });
//   }

//   Future<void> _cropImage() async {
//     final editor = ImageEditorOption();
//     final croppedImage = await editor.(
//       image: _imageBytes,
//       area: Rect.fromPoints(50, 50, 200, 200), // Define the cropping area
//     );

//     // Now you have the cropped image in the croppedImage variable
//     // You can use it or save it as needed
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Editor'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.done),
//             onPressed: () {
//               _cropImage();
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: _imageBytes != null
//             ? Image.memory(_imageBytes) // Display the loaded image
//             : CircularProgressIndicator(), // Loading indicator while image is being loaded
//       ),
//     );
//   }
// }
