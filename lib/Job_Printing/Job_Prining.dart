import 'dart:typed_data';
import 'package:alumni_management_admin/Models/Job_Post_Model.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateJobPostPdf(PdfPageFormat pageFormat,List<JobPostModel> jobsList ,bool isPdf) async {

  final event = JobPosttModelforPdf(
      title: "Products",
      Jobs: jobsList
  );

  return await event.buildPdf(pageFormat,isPdf);
}

class JobPosttModelforPdf{

  JobPosttModelforPdf({required this.title, required this.Jobs});
  String? title;
  List<JobPostModel> Jobs = [];

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat,bool isPdf) async {

    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        build: (context) => [
          _contentTable(context),
        ],
      ),
    );
    if(!isPdf){
      Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save(),
      );
    }
    return doc.save();
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'SL.NO',
      "Post Name",
      "Posted By",
      'Date',
      'Time',
      'Location',
      'Description'
    ];

    return pw.
    TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        //color: PdfColors.teal
      ),
      headerHeight: 35,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.center,
        6: pw.Alignment.center,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.amber,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellPadding: pw.EdgeInsets.zero,
      headerPadding: pw.EdgeInsets.zero,
      cellStyle: const pw.TextStyle(
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.black,
            width: .5,
          ),
        ),
      ),
      headers: List<pw.Widget>.generate(
        tableHeaders.length,
            (col) => pw.Container(
          // width: 60,
            height:40,
            decoration:pw.BoxDecoration(
                border: pw.Border.all(color:PdfColors.black)
            ),
            child:  pw.Center(child:pw.Text(tableHeaders[col],style: pw.TextStyle(fontWeight: pw.FontWeight.bold,color: PdfColor.fromHex("E7B41F"))),)
        ),
      ),
      data: List<List<pw.Widget>>.generate(
        Jobs.length,
            (row) => List<pw.Widget>.generate(
          tableHeaders.length,
              (col) => pw.Container(
            // width: 60,
              height:40,
              decoration:pw.BoxDecoration(
                  border: pw.Border.all(color:PdfColors.black)
              ),
              child:  pw.Center(child:pw.Text(Jobs[row].getIndex(col,row),style: pw.TextStyle()),)
          ),
        ),
      ),
    );
  }
}