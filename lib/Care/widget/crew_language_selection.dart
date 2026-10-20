import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageCrewSelectorWidget extends StatelessWidget {
  final String currentLanguage;
  final ValueChanged<String> onLanguageChanged;
  final VoidCallback? onNotificationTap;

  const LanguageCrewSelectorWidget({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
    this.onNotificationTap,
  });

  static const Map<String, String> languages = {
    'English': 'English',
    'हिन्दी': 'Hindi',
    'भोजपुरी': 'Bhojpuri',
  };

  String get selectedLanguage {
    final value = currentLanguage.trim().toLowerCase();

    if (value == 'hindi' || value == 'हिन्दी') {
      return 'हिन्दी';
    }

    if (value == 'bhojpuri' || value == 'भोजपुरी') {
      return 'भोजपुरी';
    }

    return 'English';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedLanguage,
              isDense: true,
              borderRadius: BorderRadius.circular(12),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
              ),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
              items: languages.keys.map((lang) {
                return DropdownMenuItem<String>(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (String? lang) {
                if (lang != null) {
                  onLanguageChanged(lang);
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 6),


      ],
    );
  }
}