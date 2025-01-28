import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void langDialog(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.tr("select_language")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  context.setLocale(Locale('ar'));
                  Navigator.pop(context);
                },
                child: const Text("Arabic"),
              ),
              TextButton(
                onPressed: () {
                  context.setLocale(Locale('en'));
                  Navigator.pop(context);
                },
                child: const Text("English"),
              )
            ],
          ),
        );
      });
}
