import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tranqueiros/core/consts.dart';
import 'package:tranqueiros/feature/dashboard/data/placar_model.dart';

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
  List<PlacarModel> _placar = List();

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

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
                    _placar = List();
                  });
                })
          ]),
      body: SingleChildScrollView(
        child: GestureDetector(
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
                  _buildListaPontos(),
                  _buildEntradaPontos(),
                  _buildButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildButton() {
    return Container(
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
                keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
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

  ListView _buildListaPontos() {
    return ListView.builder(
      shrinkWrap: true,
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
    );
  }

  Container _buildPlacarTotal() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
          color: vinho,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(sum1(),
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                Text(sum2(),
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
          )),
    );
  }

  Container _buildTopImages() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(children: [
            Container(
                width: _imgSize,
                height: _imgSize,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img/pessoa_1.jpg")))),
            SizedBox(width: 4),
            Container(
                width: _imgSize,
                height: _imgSize,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img/pessoa_2.jpeg")))),
          ]),
          Text("VS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              )),
          Row(
            children: [
              Container(
                  width: _imgSize,
                  height: _imgSize,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/img/pessoa_3.jpg")))),
              SizedBox(width: 4),
              Container(
                  width: _imgSize,
                  height: _imgSize,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/img/pessoa_4.jpg")))),
            ],
          )
        ],
      ),
    );
  }

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
    setState(() {
      _placar.add(PlacarModel(
        pontuacaoTime1: int.parse(_controller1.text),
        pontuacaoTime2: int.parse(_controller2.text),
        time1: time1,
        time2: time2,
      ));
      _controller1.text = "";
      _controller2.text = "";
    });
  }
}
