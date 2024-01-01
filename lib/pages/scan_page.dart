import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcard_project/items/drag_target_item.dart';
import 'package:vcard_project/items/line_item.dart';
import 'package:vcard_project/utils/constants.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = 'scan';

  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanOver = false;
  List<String> lines = [];

  String name = '',
      mobile = '',
      email = '',
      address = '',
      company = '',
      designation = '',
      website = '',
      image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
        actions: [
          IconButton(
            onPressed: image.isEmpty? null : () {},
            icon: const Icon(Icons.arrow_forward),
          )
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Capture'),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo_album),
                label: const Text('Gallery'),
              )
            ],
          ),
          if (isScanOver)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DragTargetItem(
                      property: ContactProperties.name,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.mobile,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.email,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.address,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.company,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.designation,
                      onDrop: getPropertyValue,
                    ),
                    DragTargetItem(
                      property: ContactProperties.website,
                      onDrop: getPropertyValue,
                    )
                  ],
                ),
              ),
            ),
          if (isScanOver)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(hint),
            ),
          Wrap(
            children: lines.map((line) => LineItem(line: line)).toList(),
          )
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final xFile = await ImagePicker().pickImage(
      source: camera,
    );
    if (xFile != null) {
      setState(() {
        image = xFile.path;
      });
      print(xFile.path);
      EasyLoading.show(status: 'Please wait');
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final recognizedText = await textRecognizer
          .processImage(InputImage.fromFile(File(xFile.path)));
      EasyLoading.dismiss();

      final tempList = <String>[];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }

      setState(() {
        lines = tempList;
        isScanOver = true;
      });
      print(tempList);
    }
  }

  getPropertyValue(String property, String value) {
    switch (property) {
      case ContactProperties.name:
        name = value;
        break;
      case ContactProperties.mobile:
        mobile = value;
        break;
      case ContactProperties.email:
        email = value;
        break;
      case ContactProperties.address:
        address = value;
        break;
      case ContactProperties.company:
        company = value;
        break;
      case ContactProperties.designation:
        designation = value;
        break;
      case ContactProperties.website:
        website = value;
        break;
    }
  }
}
