import 'dart:typed_data';
import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import './core/HoleCirclePattern.dart';
import 'package:date_format/date_format.dart';


class ShowPdf extends StatefulWidget {
  final HoleCirclePattern params;
  ShowPdf(this.params);
  @override
  ShowPdfState createState() {
    return ShowPdfState();
  }
}

class ShowPdfState extends State<ShowPdf> with SingleTickerProviderStateMixin {
  PrintingInfo printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();

    setState(() {
      printingInfo = info;
    });
  }

  void _showPrintedToast(BuildContext context) {
    final scaffold = Scaffold.of(context);

    // ignore: deprecated_member_use
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Imprimido com successo'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    final scaffold = Scaffold.of(context);

    // ignore: deprecated_member_use
    scaffold.showSnackBar(
      const SnackBar(
        content: Text('Compartilhado com sucesso'),
      ),
    );
  }

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
    
  ) async {
    var nameFile = 'Coordenadas_${formatDate(new DateTime.now(), [dd, '-', mm, '-', yy, '_', HH, '-', nn, '-', ss])}';
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File(appDocPath + '/' + '$nameFile.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    final actions = <PdfPreviewAction>[
      PdfPreviewAction(
        icon: const Icon(Icons.save),
        onPressed: _saveAsFile,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Exportar para PDF'),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        build: generateDocument,
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    List array = widget.params.arrayXandY();
    String operation = widget.params.operationType;
      double patternDiam = widget.params.patternDiameter;
      double xCenterPattern = widget.params.patternCenterX;
      double yCenterPattern = widget.params.patternCenterY;
      double initialAngle = widget.params.startAngle;
      double incAngle = widget.params.incrementAngle;
      double centralAngle = widget.params.circleSpan;
      double toolDiam = widget.params.toolDiameter;
      int qtdHoles =  widget.params.numOfHoles;
      var date = new DateTime.now();
      var dateFormated = formatDate(date, [dd, '/', mm, '/', yyyy]);
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    doc.addPage(pw.MultiPage(
        pageFormat:
            PdfPageFormat.letter.copyWith(marginBottom: 1.0 * PdfPageFormat.cm),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          if (context.pageNumber == 1) {
            return null;
          }
          return pw.Container();
          /* return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      bottom:
                          pw.BorderSide(width: 0.7, color: PdfColors.grey))),
              child: pw.Text("Tabela de Coordenadas",
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey))); */
        },
        footer: (pw.Context context) {
          return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
              child: pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(color: PdfColors.grey)));
        },
        build: (pw.Context context) => <pw.Widget>[
              pw.Header(
                  level: 1,
                  title: 'Coordenadas',
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Text('Coordenadas de $operation', textScaleFactor: 1.5),
                        pw.Text('$dateFormated')
                      ])),
              
              
              pw.Header(level: 2, text: 'Parametros:'),
              pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: <pw.Widget>[
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: <pw.Widget>[
                            pw.Text('Tipo da operacao: $operation'),
                            pw.Text('Diametro do Conjunto: $patternDiam'),
                            pw.Text('Diametro da Ferramenta: $toolDiam'),
                            pw.Text('Quantidade de furos: $qtdHoles'),
                            
                          ]),
                        pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: <pw.Widget>[
                          pw.Text('Centro (x, y): ($xCenterPattern, $yCenterPattern)'),
                          pw.Text('Angulo inicial: $initialAngle'),
                          pw.Text('Angulo central: $centralAngle'),
                          pw.Text('Angulo de incremento: $incAngle'),
                        ]),
                      ]),
                            
              //pw.Bullet(text:'Angulo de incremento: $incAngle;'),

              pw.Header(
                  level: 2, text: 'Tabela de Coordenadas'),
              
              pw.Table.fromTextArray(context: context, data: [
                <String>['N', 'X', 'Y'],
                ...array
              ]),
              pw.Padding(padding: const pw.EdgeInsets.all(10)),
              
            ]));

    return await doc.save();
  }
}
