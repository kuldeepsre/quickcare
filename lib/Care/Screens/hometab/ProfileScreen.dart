import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/Screens/auth/PhoneLoginScreen.dart';
import 'package:patientapp/Care/widget/logout_dialog.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:patientapp/utils/AppRoute.dart';
import 'package:patientapp/utils/SessionManager.dart';
import 'package:provider/provider.dart';
import '../../provider/LanguageProvider.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import your providers and screens

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _pickedFile;
  Uint8List? _webImageBytes; // For Web
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 75,
        maxWidth: 1080,
      );

      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webImageBytes = bytes;
          if (!kIsWeb) {
            _pickedFile = File(pickedFile.path);
          }
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile photo updated'),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Pick error: $e');
    }
  }

  void _showImageSourceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.read<LanguageProvider>().translate('choosePhoto'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _sourceOption(
                      icon: Icons.camera_alt_rounded,
                      label: context.read<LanguageProvider>().translate(
                        'Camera',
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    _sourceOption(
                      icon: Icons.photo_library_rounded,
                      label: context.read<LanguageProvider>().translate(
                        'Gallery',
                      ),
                      onTap: () {
                        Navigator.pop(ctx);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    if (_webImageBytes != null)
                      _sourceOption(
                        icon: Icons.delete_rounded,
                        label: context.read<LanguageProvider>().translate(
                          'Remove',
                        ),
                        color:AppColors.red,
                        onTap: () {
                          Navigator.pop(ctx);
                          setState(() {
                            _webImageBytes = null;
                            _pickedFile = null;
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    final c = color ?? AppColors.primary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: c.withOpacity(0.1),
            child: Icon(icon, color: c, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final hasImage = _webImageBytes != null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child:
                hasImage
                    ? Image.memory(
                      _webImageBytes!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    )
                    : Container(
                      color:AppColors.primary.withOpacity(0.15),
                      child: const Center(
                        child: Text(
                          'P',
                          style: TextStyle(
                            fontSize: 40,
                            color:AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _showImageSourceSheet,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFF007A55),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();
    return Scaffold(
      backgroundColor:AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(langProvider.translate('patientProfile')),
        backgroundColor: AppColors.surfaceWhite,
        foregroundColor:  AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(height: 14),
                const Text(
                  'Priya Singh',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  '+91 98765 43210',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:  AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, size: 14, color:AppColors.primary,),
                      SizedBox(width: 4),
                      Text(
                        langProvider.translate('VerifiedPatient'),
                        style: TextStyle(
                          fontSize: 11,
                          color:AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _sectionTitle(langProvider.translate('account')),
          _menuTile(
            icon: Icons.edit_outlined,
            title: langProvider.translate('editProfile'),
            onTap: () {},
          ),
          _menuTile(
            icon: Icons.history,
            title: langProvider.translate('AppointmentHistory'),
            onTap: () {},
          ),
          _menuTile(
            icon: Icons.medical_services_outlined,
            title: langProvider.translate('myMedicalRecords'),
            onTap: () {},
          ),
          _menuTile(
            icon: Icons.language,
            title: langProvider.translate('language'),
            trailingText: langProvider.currentLanguage.toUpperCase(),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _sectionTitle('Support'),
          _menuTile(
            icon: Icons.help_outline,
            title: langProvider.translate('help'),
            onTap: () {},
          ),
          _menuTile(
            icon: Icons.privacy_tip_outlined,
            title: langProvider.translate('PrivacyPolicy'),
            onTap: () {}
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color:AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:AppColors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  Icon(Icons.logout, color:AppColors.red, size: 20),
              ),
              title: Text(
                langProvider.translate('logout'),
                style: const TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppColors.red,
              ),
              onTap:
                  () => LogoutDialog.show(
                    context,
                    onConfirm:
                        () async {
                          await SessionManager.clearSession();
                          AppRoute.toAndRemoveUntil(
                            context,
                            const PhoneLoginScreen(),
                          );
                        }
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.grey[600],
        letterSpacing: 0.8,
      ),
    ),
  );

  Widget _menuTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    String? trailingText,
  }) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: AppColors.surfaceWhite,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:   AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText,
              style: TextStyle(color: Colors.grey[500], fontSize: 13),
            ),
          const SizedBox(width: 6),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
        ],
      ),
      onTap: onTap,
    ),
  );
}
