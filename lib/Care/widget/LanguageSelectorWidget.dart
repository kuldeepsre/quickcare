import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/notification_provider.dart';
import 'package:provider/provider.dart';


class LanguageSelectorWidget extends StatelessWidget {
  final String currentLanguage;
  final ValueChanged<String> onLanguageChanged;
  final VoidCallback? onNotificationTap;

  const LanguageSelectorWidget({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
    this.onNotificationTap,
  });

  static const List<String> languages = ['English', 'हिन्दी', 'भोजपुरी'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:
                languages.map((lang) {
                  final isSelected = currentLanguage == lang;

                  return GestureDetector(
                    onTap: () => onLanguageChanged(lang),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? const Color(0xFF007A55)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        lang,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color:
                              isSelected ? Colors.white : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
        const SizedBox(width: 6),
        Consumer<NotificationProvider>(
          builder: (context, provider, child) {
            final int count = provider.unreadCount;

            return IconButton(
              tooltip: 'Notifications',
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.notifications_rounded,
                    size: 28,
                  ),
                  if (count > 0)
                    Positioned(
                      right: -7,
                      top: -5,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(
                          minWidth: 19,
                          minHeight: 19,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          count > 99 ? '99+' : '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),


      ],
    );
  }
}
