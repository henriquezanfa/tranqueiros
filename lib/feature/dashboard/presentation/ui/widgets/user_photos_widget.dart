import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

const double _imgSize = 70;

/// Widget with the players photos.
class UserPhotosWidget extends StatefulWidget {
  /// Widget with the players photos constructor.
  const UserPhotosWidget({super.key});

  @override
  State<UserPhotosWidget> createState() => _UserPhotosWidgetState();
}

class _UserPhotosWidgetState extends State<UserPhotosWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: DuoPlayersWidget()),
          VersusWidget(),
          Expanded(child: DuoPlayersWidget()),
        ],
      ),
    );
  }
}

/// The widget with 'VS' text;
class VersusWidget extends StatelessWidget {
  /// The widget with 'VS' text constructor
  const VersusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'VS',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}

/// The widget with each players duo.
class DuoPlayersWidget extends StatelessWidget {
  /// The widget with each players duo constructor.
  const DuoPlayersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PhotoWidget(),
        PhotoWidget(),
      ],
    );
  }
}

/// The player photo.
class PhotoWidget extends StatefulWidget {
  /// The player constructor.
  const PhotoWidget({
    super.key,
  });

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
        onTap: () {
          _showPicker(context).then((value) async {
            if (value != null) {
              final croppedFile = await _cropImage(File(value.path));

              setState(() {
                _image = File(croppedFile!.path);
              });
            }
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_imgSize),
          child: Container(
            color: theme.colorScheme.inversePrimary,
            width: _imgSize,
            height: _imgSize,
            child: _image != null
                ? Image.file(_image!, fit: BoxFit.cover)
                : const Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.black38,
                  ),
          ),
        ));
  }

  Future<File?> _showPicker(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () async {
                  final image = await _pickFile(ImageSource.gallery);
                  if (mounted) Navigator.of(context).pop(image);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Câmera'),
                onTap: () async {
                  final image = await _getFromCamera();
                  final croppedFile = await _cropImage(File(image!.path));

                  if (mounted) Navigator.of(context).pop(croppedFile);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remover foto'),
                onTap: () async {
                  Navigator.of(context).pop(null);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<CroppedFile?> _cropImage(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    return croppedFile;
  }

  Future<XFile?> _getFromCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    return image;
  }

  Future<List<File>?> openFileExplorer(ImageSource imageSource) async {
    try {
      final imagePicker = ImagePicker();
      final xImages = [
        await imagePicker.pickImage(
          source: imageSource,
          imageQuality: 1,
        ),
      ];

      if (xImages.isNotEmpty) {
        final images = xImages.map((e) => File(e!.path)).toList();
        return images;
      } else {
        debugPrint('O usuário não selecionou nenhuma imagem');
      }
    } on PlatformException catch (e) {
      debugPrint('Unsupported operation $e');
      return null;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    }
    return null;
  }

  Future<File?> _pickFile(ImageSource? imageSource) async {
    try {
      if (imageSource != null) {
        return await openFileExplorer(imageSource).then((value) {
          if (!mounted || value == null) return null;
          return value[0];
        });
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return null;
  }
}
