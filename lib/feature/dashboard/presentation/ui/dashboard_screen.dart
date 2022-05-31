import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tranqueiros/core/consts.dart';
import 'package:tranqueiros/feature/dashboard/data/placar_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final double _imgSize = 70;

  TimeModel time1 = TimeModel(nome1: 'Marina', nome2: 'KIK');
  TimeModel time2 = TimeModel(nome1: 'Bia', nome2: 'Miguel');
  List<PlacarModel> _placar = [];

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  File? image1;
  File? image2;
  File? image3;
  File? image4;

  final cropKey = GlobalKey<CropState>();
  File? _sample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: verde,
      appBar: AppBar(
          backgroundColor: verdeEscuro,
          elevation: 4,
          centerTitle: true,
          title: Text(widget.title, style: GoogleFonts.montserrat()),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  _placar = [];
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(
                  Icons.delete_outline,
                ),
              ),
            ),
          ]),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: const EdgeInsets.only(top: 16),
          child: Center(
            child: Column(
              children: <Widget>[
                _buildTopImages(),
                _buildPlacarTotal(),
                Expanded(child: _buildListaPontos()),
                _buildEntradaPontos(),
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
        child: ButtonTheme(
          buttonColor: vinho,
          minWidth: double.infinity,
          child: RaisedButton.icon(
            label: const Text(
              'Adicionar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildEntradaPontos() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: verdeEscuro,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: _controller1,
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 16),
                  hintText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: verdeEscuro,
                borderRadius: BorderRadius.circular(32),
              ),
              child: TextFormField(
                controller: _controller2,
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 16),
                  hintText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListaPontos() {
    return SingleChildScrollView(
      child: ListView.separated(
        separatorBuilder: (context, position) {
          return Container(
            height: 0.5,
            width: double.infinity,
            color: verdeEscuro,
          );
        },
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: _placar.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  _placar[index].pontuacaoTime1.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  _placar[index].pontuacaoTime2.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlacarTotal() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: vinho,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(sum1(),
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
              Text(sum2(),
                  style: const TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTopImages() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              buildFoto(
                image1,
                () async {
                  final aux = await _showPicker(context).then((value) {
                    if (value != null) {
                      if (_sample != null) {
                        return showCupertinoModalBottomSheet<File?>(
                          enableDrag: false,
                          context: context,
                          builder: (_) => _buildCroppingImage(),
                        );
                      }
                    }
                  });
                  if (aux != null) {
                    image1 = aux as File?;
                    setState(() {});
                  }
                },
              ),
              const SizedBox(width: 4),
              buildFoto(
                image2,
                () async {
                  image2 = await _showPicker(context);
                  setState(() {});
                },
              ),
            ],
          ),
          const Text('VS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
          Row(
            children: [
              buildFoto(
                image3,
                () async {
                  image3 = await _showPicker(context);
                  setState(() {});
                },
              ),
              const SizedBox(width: 4),
              buildFoto(
                image4,
                () async {
                  image4 = await _showPicker(context);
                  setState(() {});
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildFoto(File? image, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(_imgSize),
              child: SizedBox(
                  width: _imgSize,
                  height: _imgSize,
                  child: Image.file(image, fit: BoxFit.cover)),
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
                    }),
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
        });
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
            onTap: () => Navigator.of(context).pop(_cropImage()),
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

  String sum1() {
    var some = 0;
    for (final element in _placar) {
      some += element.pontuacaoTime1!;
    }

    return some.toString();
  }

  String sum2() {
    var some = 0;
    for (final element in _placar) {
      some += element.pontuacaoTime2!;
    }

    return some.toString();
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

  void onPressed() {
    final value1 = int.tryParse(_controller1.text) ?? 0;
    final value2 = int.tryParse(_controller2.text) ?? 0;

    setState(() {
      _placar.add(PlacarModel(
        pontuacaoTime1: value1,
        pontuacaoTime2: value2,
        time1: time1,
        time2: time2,
      ));
      _controller1.text = '';
      _controller2.text = '';
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}
