import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranqueiros/core/consts.dart';
import 'package:tranqueiros/feature/dashboard/data/placar_model.dart';

import '../../../../core/consts.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _imgSize = 70;

  TimeModel time1 = TimeModel(nome1: "Marina", nome2: "KIK");
  TimeModel time2 = TimeModel(nome1: "Bia", nome2: "Miguel");
  List<PlacarModel> _placar = [];

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  File image1;
  File image2;
  File image3;
  File image4;

  final cropKey = GlobalKey<CropState>();
  File _sample;

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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.delete_outline,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _placar = [];
                  });
                })
          ]),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.only(top: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
        padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
        child: ButtonTheme(
          buttonColor: vinho,
          minWidth: double.infinity,
          child: RaisedButton.icon(
            label: Text(
              "Adicionar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 16),
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildEntradaPontos() {
    return Container(
      padding: EdgeInsets.all(16),
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
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: true,
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 16),
                  hintText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
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
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: true,
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
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
        physics: BouncingScrollPhysics(),
        itemCount: _placar.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  _placar[index].pontuacaoTime1.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  _placar[index].pontuacaoTime2.toString(),
                  style: TextStyle(
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
      padding: EdgeInsets.all(16),
      child: Card(
        color: vinho,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(sum1(), style: TextStyle(fontSize: 18, color: Colors.white)),
              Text(sum2(), style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildTopImages() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              buildFoto(
                image1,
                () async {
                  image1 = await _showPicker(context);
                  _buildCroppingImage();
                  setState(() {});
                },
              ),
              SizedBox(width: 4),
              buildFoto(
                image2,
                () async {
                  image2 = await _showPicker(context);
                  setState(() {});
                },
              ),
            ],
          ),
          Text("VS",
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
              SizedBox(width: 4),
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

  GestureDetector buildFoto(File image, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(_imgSize),
              child: Container(
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
                Positioned(
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

  Future<File> _showPicker(context) async {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  _sample != null ? Expanded(
                    child: Crop.file(_sample, key: cropKey),
                  ) : Offstage(),
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Galeria'),
                      onTap: () async {
                        final image = await _getFromGallery();
                        Navigator.of(context).pop(image);
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Câmera'),
                    onTap: () async {
                      final image = await _getFromCamera();
                      Navigator.of(context).pop(image);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Remover foto'),
                    onTap: () async {
                      Navigator.of(context).pop(null);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {},
              ),
              // _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Future _cropImage(File _file) async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    // _lastCropped?.delete();
    // _lastCropped = file;

    debugPrint('$file');
  }



  Future<File> _getFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile image = await _picker.pickImage(source: ImageSource.camera);

    return _cropImage(File(image.path));
  }

  Future<File> _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);

    return _cropImage(File(image.path));
  }
  //
  // Future<File> _cropImage(File filePath) async {
  //   File croppedImage = await ImageCrop.sampleImage(
  //     file: filePath,
  //     // maxWidth: 1080,
  //     // maxHeight: 1080,
  //     // aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  //     // cropStyle: CropStyle.circle,
  //   );
  //
  //   return croppedImage;
  // }

  String sum1() {
    int some = 0;
    _placar.forEach((element) {
      some += element.pontuacaoTime1;
    });

    return some.toString();
  }

  String sum2() {
    int some = 0;
    _placar.forEach((element) {
      some += element.pontuacaoTime2;
    });

    return some.toString();
  }

  void onPressed() {
    int value1 = int.tryParse(_controller1.text) ?? 0;
    int value2 = int.tryParse(_controller2.text) ?? 0;

    setState(() {
      _placar.add(PlacarModel(
        pontuacaoTime1: value1,
        pontuacaoTime2: value2,
        time1: time1,
        time2: time2,
      ));
      _controller1.text = "";
      _controller2.text = "";
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}
