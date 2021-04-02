import 'package:flutter/material.dart';
import 'dart:ui';
import './slides.dart';
import '../core/HoleCirclePattern.dart';

class MainPageForm extends StatelessWidget {
  final items = ['Furação', 'Usinagem Externa', 'Usinagem Interna'];

  final _compArcController = TextEditingController(text: "360");
  final _xCenterController = TextEditingController(text: "0");
  final _yCenterController = TextEditingController(text: "0");
  final _damConjController = TextEditingController(text: "100");
  final _damFurosController = TextEditingController(text: "5");
  final _nFurosController = TextEditingController(text: "20");
  final _iniAngController = TextEditingController(text: "0");
  final _typeOpController = TextEditingController(text: 'Furação');

  final FocusNode _compArcFocus = FocusNode();
  final FocusNode _xCenterFocus = FocusNode();
  final FocusNode _yCenterFocus = FocusNode();
  final FocusNode _damConjFocus = FocusNode();
  final FocusNode _damFurosFocus = FocusNode();
  final FocusNode _nFurosFocus = FocusNode();
  final FocusNode _iniAngFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Furos Coordenados'),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Tipo da operação'),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            width: 150,
                            child: TextField(
                                enabled: false, controller: _typeOpController)),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            _typeOpController.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return items
                                .map<PopupMenuItem<String>>((String value) {
                              return PopupMenuItem(
                                  child: Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ]),
                ],
              ),
            ),
            
            Row(children:<Widget>[Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Row(children: <Widget>[
                        Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 50,
                                height: 50,
                                child: Image.asset(
                                  'assets/XC.png',
                                ))),
                        Text("Centro:")
                      ])),
                      Container(
                          margin: EdgeInsets.only(right: 0, left: 20),
                          width: 90,
                          child: TextFormField(
                              controller: _xCenterController,
                              decoration: InputDecoration(
                                suffix: Text('mm'),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              focusNode: _xCenterFocus,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _xCenterFocus, _yCenterFocus);
                              })),
                    ])),
                    
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                     
                      Container(
                          margin: EdgeInsets.only(right: 0),
                          width: 90,
                          child: TextFormField(
                              controller: _yCenterController,
                              decoration: InputDecoration(
                                suffix: Text('mm'),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              focusNode: _yCenterFocus,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _yCenterFocus, _damConjFocus);
                              })),
                    ]))]),
                    Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Row(children: <Widget>[
                        Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 50,
                                height: 50,
                                child: Image.asset('assets/CA.png',
                                    height: 30, width: 30))),
                        Text("Angulo Total:")
                      ])),
                      Container(
                          margin: EdgeInsets.only(right: 0),
                          width: 100,
                          child: TextFormField(
                              controller: _compArcController,
                              decoration: InputDecoration(
                                suffix: Text('°'),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              focusNode: _compArcFocus,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _compArcFocus, _xCenterFocus);
                              })),
                    ])),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Row(children: <Widget>[
                        Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 50,
                                height: 50,
                                child: Image.asset('assets/D.png'))),
                        Text("Diametro Total:")
                      ])),
                      Container(
                          margin: EdgeInsets.only(right: 0),
                          width: 100,
                          child: TextFormField(
                              controller: _damConjController,
                              decoration: InputDecoration(
                                suffix: Text('mm'),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              focusNode: _damConjFocus,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _damConjFocus, _damFurosFocus);
                              })),
                    ])),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Row(children: <Widget>[
                        Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 50,
                                height: 50,
                                child: Image.asset('assets/df.png'))),
                        Text("Diam. da Ferramenta:")
                      ])),
                      Container(
                          margin: EdgeInsets.only(right: 0),
                          width: 100,
                          child: TextFormField(
                              controller: _damFurosController,
                              decoration: InputDecoration(
                                suffix: Text('mm'),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              focusNode: _damFurosFocus,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _damFurosFocus, _nFurosFocus);
                              })),
                    ])),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Row(children: <Widget>[
                        Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 50,
                                height: 50,
                                child: Image.asset('assets/NF.png'))),
                        Text("Quantidade de Furos:")
                      ])),
                      Container(
                          margin: EdgeInsets.only(right: 0),
                          width: 100,
                          child: TextFormField(
                              controller: _nFurosController,
                              decoration: InputDecoration(
                                suffix: Text('un'),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              focusNode: _nFurosFocus,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(
                                    context, _nFurosFocus, _iniAngFocus);
                              })),
                    ])),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: Row(children: <Widget>[
                        Tab(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 50,
                                height: 50,
                                child: Image.asset('assets/a.png'))),
                        Text("Angulo Inicial:")
                      ])),
                      Container(
                          margin: EdgeInsets.only(right: 0),
                          width: 100,
                          child: TextFormField(
                              controller: _iniAngController,
                              decoration: InputDecoration(
                                suffix: Text("°"),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              focusNode: _iniAngFocus,
                              onFieldSubmitted: (value) {
                                _iniAngFocus.unfocus();
                              })),
                    ])),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 50,
                child: RaisedButton(
                  child: Text('Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  onPressed: () {
                    final compArc = double.parse(_compArcController.text);
                    final xCenter = double.parse(_xCenterController.text);
                    final yCenter = double.parse(_yCenterController.text);
                    final damConj = double.parse(_damConjController.text);
                    final nFuros = int.parse(_nFurosController.text);
                    final iniAng = double.parse(_iniAngController.text);
                    final toolDiam = double.parse(_damFurosController.text);
                    final typeOp = _typeOpController.text;
                    final pattern = HoleCirclePattern(
                      circleSpan: compArc,
                      patternCenterX: xCenter,
                      patternCenterY: yCenter,
                      patternDiameter: damConj,
                      toolDiameter: toolDiam,
                      numOfHoles: nFuros,
                      startAngle: iniAng,
                      operationType: typeOp,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Slides(pattern)),
                    );
                  },
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ], //principal
        )));
  }
}
