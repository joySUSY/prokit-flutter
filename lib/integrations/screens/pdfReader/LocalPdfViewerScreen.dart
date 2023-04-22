import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LocalPdfViewerScreen extends StatefulWidget {
  static String tag = '/local_pdf_viewer';

  final bool isDirect;

  LocalPdfViewerScreen({this.isDirect = false});

  @override
  _LocalPdfViewerScreenState createState() => _LocalPdfViewerScreenState();
}

class _LocalPdfViewerScreenState extends State<LocalPdfViewerScreen> {
  PdfViewerController pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    changeStatusColor(appStore.scaffoldBackground!);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Local PDF Viewer', isDashboard: widget.isDirect),
      body: SfPdfViewer.asset(
        'assets/pdf/Romeo_and_Juliet.pdf',
        controller: pdfViewerController,
      ),
    );
  }
}
