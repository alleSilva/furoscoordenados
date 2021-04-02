import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:ui';
import 'dart:math';
import '../core/HoleCirclePattern.dart';
import '../showpdf.dart';


class ShapePainter extends CustomPainter {
  final HoleCirclePattern params;
  var index;
  ShapePainter(this.params, this.index);

  @override
  void paint(Canvas canvas, Size size) {
    double r = 70.0;
    double finalR;
    if (params.operationType == 'Usinagem Externa') finalR = r + 5;
    if (params.operationType == 'Usinagem Interna') finalR = r - 5;
    if (params.operationType == 'Furação') finalR = r;

    if (params.circleSpan == 360) {
      params.incrementAngle = params.circleSpan / params.numOfHoles;
    } else {
      params.incrementAngle = params.circleSpan / (params.numOfHoles - 1);
    }

    final pointMode = PointMode.points;

    final points = [
      Offset(r, r), //origem
      Offset(
          r +
              finalR *
                  cos(-index * (params.incrementAngle) * pi / 180 -
                      params.startAngle * pi / 180),
          r +
              finalR *
                  sin(-index * (params.incrementAngle) * pi / 180.0 -
                      params.startAngle * pi / 180))
    ];
    final paint3 = Paint() //ponto centro circ maior
      ..color = Colors.black
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint3);

    var paint = Paint() //circulo maior
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Offset center = Offset(r, r);
    canvas.drawCircle(center, r, paint);

    var paint2 = Paint()
      ..color = Colors.blueGrey[600]
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < params.numOfHoles; i++) {
      Offset center2 = Offset(
          r +
              finalR *
                  cos(i * (-params.incrementAngle) * pi / 180 -
                      params.startAngle * pi / 180),
          r +
              finalR *
                  sin(i * (-params.incrementAngle) * pi / 180.0 -
                      params.startAngle * pi / 180));
      canvas.drawCircle(center2, 4.0, paint2);
    }

    var paintC = Paint() //current hole
      ..color = Colors.grey[700]
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(points[1], 4, paintC);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Slides extends StatefulWidget {
  final HoleCirclePattern slides;
  Slides(this.slides);
  @override
  _SlidesState createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int index = 0;

  void _next() {
    setState(() {
      index++;
    });
    if (index == widget.slides.coordXandY().length) {
      index--;
    }
  }

  void _back() {
    setState(() {
      index--;
    });
    if (index == -1) {
      index = 0;
    }
  }

  void _refresh() {
    setState(() {
      index = 0;
    });
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
           title: Text('Furos Coordenados')),
        body: Container(

            //decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //  colors: [Colors.grey, Colors.white])
            //),

            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child: CustomPaint(
                        painter: ShapePainter(widget.slides, index),
                        child: Center(),
                      ),
                    ),
                    Container(
                      height: 150,
                        margin: EdgeInsets.only(top:25.0, right: 15.0),
                        padding: EdgeInsets.only(left:10.0),
                        
                        child: Expanded(
                          
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                        'Origem: ${widget.slides.patternCenterX}, ${widget.slides.patternCenterY}')),
                                Container(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                        'Diam. Total: ${widget.slides.patternDiameter}')),
                                Container(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                        'Diam. Ferramenta: ${widget.slides.toolDiameter}')),
                                Container(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                        'N°de furos: ${widget.slides.numOfHoles}')),
                                Container(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                        'Angulo inicial: ${widget.slides.startAngle}°')),
                                Container(
                                    padding: EdgeInsets.all(0),
                                    child: Text(
                                        'Comp. Arco: ${widget.slides.circleSpan}°')),
                              ]),
                        ))
                  ]), //row
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 10),
                  child: (Column(children: <Widget>[
                    Card(
                        elevation: 5,
                        child: Container(
                          width: 270,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueGrey[800]),
                          margin: EdgeInsets.all(0),
                          child: Align(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(bottom: 0),
                                    child: Text(
                                      'FURO ${index + 1}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    )),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        widget.slides.arrayCoordX()[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22))),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        widget.slides.arrayCoordY()[index],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22)))
                              ])),
                        )) //container
                    ,
                    Container(
                        margin: EdgeInsets.only(top: 20, bottom: 50),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: RaisedButton(
                                      child: Icon(MaterialIcons.navigate_before,
                                          color: Colors.blueGrey[800]),
                                      onPressed: _back)),
                              Container(
                                  margin: EdgeInsets.only(right: 0),
                                  child: RaisedButton(
                                      child: Icon(MaterialIcons.refresh,
                                          color: Colors.blueGrey[800]),
                                      onPressed: _refresh)),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: RaisedButton(
                                      child: Icon(MaterialIcons.navigate_next,
                                          color: Colors.blueGrey[800]),
                                      onPressed: _next))
                            ]))
                  ]))),
              
            ])),
            bottomNavigationBar: BottomAppBar(
              color: Colors.blueGrey,
              shape: const CircularNotchedRectangle(),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
          IconButton(
            icon: Icon(Icons.text_snippet,color:Colors.white),
            onPressed: () {},
          ),
                  IconButton(
            icon: Icon(Icons.picture_as_pdf,color:Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowPdf(widget.slides),
              ));
            },
          ),
        ],),
                height: 50,
                ),
            ),

          );
  }

}
