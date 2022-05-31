import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tranqueiros/core/consts.dart';

const double _imgSize = 70;

/// Widget with the players photos.
class UserPhotosWidget extends StatefulWidget {
  /// Widget with the players photos constructor.
  const UserPhotosWidget({Key? key}) : super(key: key);

  @override
  _UserPhotosWidgetState createState() => _UserPhotosWidgetState();
}

class _UserPhotosWidgetState extends State<UserPhotosWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          DuoPlayersWidget(),
          VersusWidget(),
          DuoPlayersWidget(),
        ],
      ),
    );
  }
}

/// The widget with 'VS' text;
class VersusWidget extends StatelessWidget {
  /// The widget with 'VS' text constructor
  const VersusWidget({Key? key}) : super(key: key);

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
  const DuoPlayersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        PhotoWidget(),
        SizedBox(width: 4),
        PhotoWidget(),
      ],
    );
  }
}

/// The player photo.
class PhotoWidget extends StatefulWidget {
  /// The player constructor.
  const PhotoWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  File? _image;
  File? _sample;

  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPicker(context).then((value) {
          if (value != null) {
            if (_sample != null) {
              showCupertinoModalBottomSheet<File?>(
                enableDrag: false,
                context: context,
                builder: (_) => _buildCroppingImage(),
              ).then((Object? value) {
                if (value != null) {
                  _image = value as File?;
                  setState(() {});
                }
              });
            }
          }
        });
      },
      child: _image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(_imgSize),
              child: SizedBox(
                width: _imgSize,
                height: _imgSize,
                child: Image.file(_image!, fit: BoxFit.cover),
              ),
            )
          : Stack(
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 85,
                  color: verdeEscuro,
                ),
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.add_a_photo,
                    size: 20,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
    );
  }

  Future<File?> _showPicker(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      isScrollControlled: false,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () async {
                  final image = await _pickFile(ImageSource.gallery);
                  _sample = image;
                  Navigator.of(context).pop(image);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Câmera'),
                onTap: () async {
                  final image = await _getFromCamera();
                  await _cropImage();

                  Navigator.of(context).pop(image);
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

  Future<File?> _cropImage() async {
    final scale = cropKey.currentState?.scale ?? 1;
    final area = cropKey.currentState?.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return null;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _sample!,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    return _sample = file;
  }

  Widget _buildCroppingImage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close_rounded)),
        title: Text(
          'Cortar'.toUpperCase(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              final image = await _cropImage();
              Navigator.of(context).pop(image);
            },
            child: const Icon(Icons.check),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Expanded(
          child: Crop.file(
            _sample!,
            key: cropKey,
            aspectRatio: 1.0 / 1.0,
          ),
        ),
      ),
    );
  }

  Future<XFile?> _getFromCamera() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.camera);

    return image;
  }

  Future<List<File>?> openFileExplorer(ImageSource imageSource) async {
    try {
      final imagePicker = ImagePicker();
      final xImages = [
        await imagePicker.pickImage(
          source: imageSource,
          imageQuality: 1,
        )
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
  }
}
