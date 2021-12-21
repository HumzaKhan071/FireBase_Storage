import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_last_class/storagehelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Storage storage = Storage();

  var results;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                results = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ["pdf", "jpg", "png", "jpeg"]);

                setState(() {
                  results = results;
                });

                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No Files Selected"),
                  ));

                  return null;
                }

                final filepath = results.files.single.path;
                final filename = results.files.single.name;

                storage.uploadFile(filepath, filename);
              },
              child: Text("Upload File")),
          if (results != null)
            Container(
              child: Image.file(File(results.files.single.path)),
            )
        ],
      ),
    );
  }
}
