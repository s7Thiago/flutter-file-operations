import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

main() => runApp(MaterialApp(
      title: 'I/O',
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _fieldDataCoontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('I/O'),
      ),
      body: Container(
        margin: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            TextField(
              controller: _fieldDataCoontroller,
              decoration: InputDecoration(labelText: 'Type Something'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    saveData(_fieldDataCoontroller.text);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            FutureBuilder(
              future: readData(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData)
                  return Text(
                    snapshot.data,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  );
                else
                  return Text('No file saved');
              },
            )
          ],
        ),
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/data.txt');
  }

  // Write
  Future<File> saveData(String message) async {
    final file = await _localFile;

    return file.writeAsString(message);
  }

  // Read
  Future<String> readData() async {
    try {
      final file = await _localFile;

      return await file.readAsString();
    } catch (e) {
      return 'File not saved still.';
    }
  }
}
