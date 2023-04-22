import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main/utils/AppWidget.dart';
import 'package:prokit_flutter/widgets/materialWidgets/mwDialogAlertPanelWidgets/MWExpansionPannelWidgets/component/MWExpansionPanel4ComponentWidget.dart';

class MWExpansionPanelScreen3 extends StatefulWidget {
  const MWExpansionPanelScreen3({Key? key}) : super(key: key);

  @override
  _MWExpansionPanelScreen3State createState() => _MWExpansionPanelScreen3State();
}

class _MWExpansionPanelScreen3State extends State<MWExpansionPanelScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, 'Expansion Panel 3 '),
        body: ListView.builder(
            padding: EdgeInsets.only(bottom: 30, top: 26),
            physics: BouncingScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) {
              return MWExpansionPanel4ComponentWidget(index: index).paddingSymmetric(horizontal: 16);
            }));
  }
}
