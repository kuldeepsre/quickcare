import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class EmergencySosCard extends StatefulWidget {
  final langProvider;
  const EmergencySosCard({super.key, required this.langProvider});

  @override
  State<EmergencySosCard> createState() => _EmergencySosCardState();
}

class _EmergencySosCardState extends State<EmergencySosCard> with SingleTickerProviderStateMixin {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = "";
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    var micStatus = await Permission.microphone.status;
    if (micStatus.isDenied) {
      micStatus = await Permission.microphone.request();
    }

    if (micStatus.isPermanentlyDenied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Microphone blocked, open Settings to allow"),
            action: SnackBarAction(label: "Settings", onPressed: () => openAppSettings()),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    if (micStatus != PermissionStatus.granted) {
      debugPrint("Mic not granted: $micStatus");
      return;
    }

    try {
      _speechEnabled = await _speech.initialize(
        onStatus: (status) {
          debugPrint('Speech status: $status');
          if (status == 'done' || status == 'notListening') {
            if (mounted) setState(() => _isListening = false);
          }
        },
        onError: (error) {
          debugPrint('Speech error: $error');
          if (mounted) setState(() => _isListening = false);
        },
      );
      debugPrint(">>> Speech Initialized: $_speechEnabled");
    } catch (e) {
      debugPrint(">>> Initialize failed: $e");
      _speechEnabled = false;
    }

    if (mounted) setState(() {});
  }

  Future<void> _listen() async {
    if (!_speechEnabled) {
      await _initSpeech();
      if (!_speechEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Google Speech not available. Install Google App"), backgroundColor: Colors.red),
          );
        }
        return;
      }
    }

    if (_speech.isListening) {
      await _speech.stop();
      if (mounted) setState(() => _isListening = false);
      return;
    }

    try {
      setState(() {
        _lastWords = "";
        _isListening = true;
      });

      await _speech.listen(
        onResult: (result) {
          if (!mounted) return;
          setState(() => _lastWords = result.recognizedWords);
          debugPrint("Heard: $_lastWords");
          String text = _lastWords.toLowerCase();
          if (text.contains("sos") || text.contains("help") || text.contains("ambulance") || text.contains("emergency")) {
            _triggerSosAction();
          }
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 4),
        partialResults: true,
        localeId: "en_IN",
        cancelOnError: false,
        listenMode: stt.ListenMode.confirmation,
      );
    } catch (e) {
      debugPrint("Listen error: $e");
      if (mounted) setState(() => _isListening = false);
    }
  }

  void _triggerSosAction() {
    _speech.stop();
    if (mounted) setState(() => _isListening = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("SOS Detected: '$_lastWords' - Calling Ambulance..."), backgroundColor: Colors.red),
      );
    }
    // TODO: Call your ambulance API here
    debugPrint("VOICE SOS TRIGGERED: $_lastWords");
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade100, width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.red.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.langProvider.translate('emergencyHelp'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 2),
                  Text(widget.langProvider.translate('immediateSupport'), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: Colors.red.shade50.withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                child: Icon(_isListening ? Icons.mic : Icons.warning_amber_rounded, color: Colors.red, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Glowing SOS Button
          Center(
            child: GestureDetector(
              onTap: _triggerSosAction,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Colors.red.shade600, Colors.red.shade800], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(_isListening ? 0.6 : 0.4),
                          blurRadius: _isListening ? 25 * _pulseController.value : 15,
                          spreadRadius: _isListening ? 5 * _pulseController.value : 2,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(widget.langProvider.translate('sosAmbulance'), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2)),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Show what you said
          if (_lastWords.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
              child: Text("You said: $_lastWords", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            ),

          // Google Voice Button
          GestureDetector(
            onTap: _listen,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: _isListening ? Colors.red : Colors.red.shade50,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_isListening ? Icons.hearing : Icons.mic_none_rounded, color: _isListening ? Colors.white : Colors.red, size: 16),
                  const SizedBox(width: 6),
                  Text(_isListening ? "Listening... Say SOS" : widget.langProvider.translate('saySos'), style: TextStyle(color: _isListening ? Colors.white : Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}