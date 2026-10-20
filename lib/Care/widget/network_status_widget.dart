import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../utils/network_service.dart';

import 'dart:async';
import 'package:flutter/material.dart';



import 'dart:async';
import 'package:flutter/material.dart';

import '../provider/LanguageProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class NetworkStatusWidget extends StatefulWidget {
  const NetworkStatusWidget({super.key});

  @override
  State<NetworkStatusWidget> createState() => _NetworkStatusWidgetState();
}

class _NetworkStatusWidgetState extends State<NetworkStatusWidget> {
  StreamSubscription<bool>? _subscription;
  bool _dialogVisible = false;

  @override
  void initState() {
    super.initState();

    // Subscribe before checking the initial status.
    _subscription = NetworkService.instance.connectionStream.listen(
          (connected) {
        if (connected) {
          _closeDialog();
        } else {
          _showDialog(context);
        }
      },
    );

    NetworkService.instance.startListening();
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final connected = await NetworkService.instance.checkConnection();

    if (!mounted) return;

    if (connected) {
      _closeDialog();
    } else {
      _showDialog(context);
    }
  }

  void _showDialog(BuildContext context) {
    if (!mounted || _dialogVisible) return;

    _dialogVisible = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_dialogVisible || NetworkService.instance.isConnected) {
        _dialogVisible = false;
        return;
      }

      final navigatorContext = appNavigatorKey.currentContext;

      if (navigatorContext == null) {
        _dialogVisible = false;
        return;
      }

      // Access the LanguageProvider using context to support multi-language translation
      final langProvider = Provider.of<LanguageProvider>(navigatorContext, listen: false);

      showDialog<void>(
        context: navigatorContext,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (dialogContext) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.wifi_off_rounded,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    langProvider.translate('noInternetTitle'), // Translated title
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    langProvider.translate('noInternetMessage'), // Translated subtitle
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await NetworkService.instance.checkConnection();
                      },
                      child: Text(langProvider.translate('tryAgain')), // Translated button label
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).whenComplete(() {
        _dialogVisible = false;
      });
    });
  }

  void _closeDialog() {
    if (!_dialogVisible) return;

    final navigator = appNavigatorKey.currentState;

    if (navigator != null && navigator.canPop()) {
      navigator.pop();
    }

    _dialogVisible = false;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}