import 'package:flutter/material.dart';

Future<void> showDialogIndicator(BuildContext context, String message){
  return showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10,),
              Text(message)
            ],
          ),
        );
      }
  );
}