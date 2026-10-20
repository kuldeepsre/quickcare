import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:provider/provider.dart';

class DeleteMessageDialog {
  DeleteMessageDialog._();

  static Future<bool> show(BuildContext context) async {
    // Access the LanguageProvider via context
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  langProvider.translate('deleteMsgTitle'), // Translated title
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            langProvider.translate('deleteMsgContent'), // Translated content
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(langProvider.translate('cancel')), // Translated cancel
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(langProvider.translate('delete')), // Translated delete
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
