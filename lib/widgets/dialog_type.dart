import 'package:flutter/material.dart';

enum DialogType { success, warning, error }

void showTypeDialog(BuildContext context, String message, DialogType type) {
  String title;
  IconData icon;
  Color iconColor;

  switch (type) {
    case DialogType.success:
      title = 'Success';
      icon = Icons.check_circle;
      iconColor = Colors.green;
      break;
    case DialogType.warning:
      title = 'Warning';
      icon = Icons.warning;
      iconColor = Colors.orange;
      break;
    case DialogType.error:
      title = 'Error';
      icon = Icons.error;
      iconColor = Colors.red;
      break;
  }

  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 24.0),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}
