import 'package:flutter/material.dart';

showAlertDialog(
    {BuildContext context,
    // ignore: non_constant_identifier_names
    String LButtonName,
    // ignore: non_constant_identifier_names
    String RButtonName,
    String title,
    String subtitle,
    // ignore: non_constant_identifier_names
    Function LbuttonOnClock,
    // ignore: non_constant_identifier_names
    Function RbuttonOnClock}) {
  Widget cancelButton = FlatButton(
    child: Text(LButtonName),
    onPressed: LbuttonOnClock,
  );
  Widget continueButton = FlatButton(
    child: Text(RButtonName),
    onPressed: RbuttonOnClock,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(subtitle),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
