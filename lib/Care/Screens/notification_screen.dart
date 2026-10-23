import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/Care/provider/notification_provider.dart';
import 'package:provider/provider.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider=context.watch<LanguageProvider>();
    return Scaffold(
      appBar: AppBar(
        title:  Text(langProvider.translate('Notifications')),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              return PopupMenuButton<String>(
                onSelected: (value) async {
                  try {
                    if (value == 'read') {
                      await provider.markAllAsRead();
                    } else if (value == 'clear') {
                      await provider.clearAll();
                    }
                  } catch (_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Unable to update notifications'),
                        ),
                      );
                    }
                  }
                },
                itemBuilder: (context) =>  [
                  PopupMenuItem(
                    value: 'read',
                    child: Text(langProvider.translate('MarkAllRead')),
                  ),
                  PopupMenuItem(
                    value: 'clear',
                    child: Text(langProvider.translate('ClearAll')),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.notifications.isEmpty) {
            return  Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text(langProvider.translate('NoNotifications')),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: provider.notifications.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];

              return Dismissible(
                key: ValueKey(notification.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (_) async {
                  try {
                    await provider.deleteNotification(notification.id);
                  } catch (_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text(langProvider.translate('UnableDelete')),
                        ),
                      );
                    }
                  }
                },
                child: ListTile(
                  tileColor: notification.isRead
                      ? null
                      : Colors.teal.withOpacity(0.07),
                  leading: CircleAvatar(
                    backgroundColor: notification.isRead
                        ? Colors.grey.shade200
                        : Colors.teal.shade100,
                    child: Icon(
                      notification.isRead
                          ? Icons.notifications_none
                          : Icons.notifications_active,
                      color: notification.isRead
                          ? Colors.grey
                          : Colors.teal,
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body),
                      const SizedBox(height: 5),
                      Text(
                        notification.createdAt.toLocal().toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  trailing: notification.isRead
                      ? const Icon(
                    Icons.check_circle_outline,
                    color: Colors.grey,
                  )
                      : const Icon(
                    Icons.circle,
                    color: Colors.teal,
                    size: 10,
                  ),
                  onTap: () async {
                    try {
                      await provider.markAsRead(notification.id);
                    } catch (_) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(
                            content: Text(langProvider.translate('UnableMark')),
                          ),
                        );
                      }
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}