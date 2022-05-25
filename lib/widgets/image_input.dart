// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final String title;
  final Function onSelectImage;
  // ignore: use_key_in_widget_constructors
  const ImageInput(this.onSelectImage, this.title);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _storedImage;
  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    // ignore: avoid_print
    print('**************' + fileName);
    // imageFile.=File('${appDir.path}/${fileName}');
    File pathLast = File(imageFile.path);
    final savedImage = await pathLast.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
            radius: 60,
            backgroundImage: _storedImage != null
                ? FileImage(
                    File(_storedImage!.path),
                  )
                :
                //  const  NetworkImage('https://via.placeholder.com/150') as ImageProvider)

                Image.asset('assets/images/propic.png').image),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera_alt_outlined),
            label: Text(widget.title),
            textColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
