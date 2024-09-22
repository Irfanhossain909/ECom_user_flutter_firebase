import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

showSingleTextInputDialog({
  required BuildContext context,
  required String title,
  TextInputType textInputType = TextInputType.text,
  String positiveButtonText = 'Save',
  String nagetiveButtonText = 'Cancel',
  required Function(String) onSave,
}) {
  final controller = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                keyboardType: textInputType,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter $title'),
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  if (controller.text.isEmpty) return;
                  onSave(controller.text);
                  Navigator.pop(context);
                },
                child: Text(positiveButtonText),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(nagetiveButtonText),
              ),
            ],
          ));
}
