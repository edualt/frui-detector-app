import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class ImageClassificationPage extends StatefulWidget {
  const ImageClassificationPage({super.key});

  @override
  State<ImageClassificationPage> createState() =>
      _ImageClassificationPageState();
}

class _ImageClassificationPageState extends State<ImageClassificationPage> {
  File? _image;
  late List<dynamic> _output = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _classifyImage(File image) async {
    List<int> imageBytes = await image.readAsBytes();

    var request = http.MultipartRequest(
      'POST',
      // Uri.parse('http://44.216.65.25:5000/predict'),
      Uri.parse('http://192.168.1.26:5000/predict'),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.jpg',
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      setState(() {
        _loading = false;
        _output = [json.decode(jsonResponse)['prediction']];
      });
    } else {
      setState(() {
        _loading = false;
        _output = [];
        print('Error en la solicitud: ${response.reasonPhrase}');
      });
    }
  }

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar Fuente de Imagen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Galería'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Cámara'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _loading = true;
        _classifyImage(_image!);
      } else {
        print('No se seleccionó ninguna imagen.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'NNFruit',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Expanded(
              child: Image.file(
                _image!,
                height: 300,
                width: 300,
              ),
            )
                : Column(
              children: [
                Image.asset("assets/image.png", height: 200),
                const Text(
                  'No se seleccionó ninguna imagen.',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator(color: Colors.green,)
                : ElevatedButton(
                onPressed: _getImage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: const Text('Empezar a detectar')
            ),
            const SizedBox(height: 20),
            _output.isNotEmpty
                ? Center(
                  child: Column(
                                children: _output.map((output) {
                  return Text(
                    '${_output[0]}',
                    style: const TextStyle(fontSize: 18),
                  );
                                }).toList(),
                              ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}