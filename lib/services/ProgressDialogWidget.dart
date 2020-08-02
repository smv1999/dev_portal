import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ProgressDialogWidget {

  OverlayEntry _progressOverlayEntry;
  ProgressDialog pr;

  void show(BuildContext context){
    _progressOverlayEntry = _createdProgressEntry(context);
    Overlay.of(context).insert(_progressOverlayEntry);
  }

  void hide(){
    if(_progressOverlayEntry != null){
      _progressOverlayEntry.remove();
      _progressOverlayEntry = null;
    }
  }

  OverlayEntry _createdProgressEntry(BuildContext context) =>
      OverlayEntry(
          builder: (BuildContext context) =>
              Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white70.withOpacity(0.5),
                  ),
//                  Center(
//                    child: ProgressDialog(context,
//                        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true),
//                  )
                ],

              )
      );

  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

}
