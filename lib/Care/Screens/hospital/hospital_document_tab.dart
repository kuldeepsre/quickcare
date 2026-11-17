import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/document_provider.dart';
import 'package:patientapp/Care/widget/document_overview.dart';
import 'package:provider/provider.dart';

class HospitalDocumentTab extends StatefulWidget {
  const HospitalDocumentTab({super.key});

  @override
  State<HospitalDocumentTab> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<HospitalDocumentTab> {
  String? _selectedFileName;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
      );

      if (result != null) {
        setState(() {
          _selectedFileName = result.files.single.name;
        });
      }
    } catch (e) {
      debugShowCardError(e.toString());
    }
  }

  void debugShowCardError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error picking file: $error')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              const Text(
                'QUICKCARE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5F716A),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Documents',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF102A21),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Manage verification and compliance files for your hospital account',
                style: TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF667871),
                ),
              ),
              const SizedBox(height: 20),

              // Add Documents Dashed Card with File Picker State
              _buildAddDocumentsCard(),
              const SizedBox(height: 16),

              // Uploaded Files Container
              _buildUploadedFilesContainer(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddDocumentsCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFC6E7D2),
          style: BorderStyle.solid,
          width: 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.upload_rounded,
              color: Color(0xFF0B4F38),
              size: 22,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Add documents',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF102A21),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Upload licences, certificates, insurance, or identity documents.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF667871),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickFile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B4F38),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Choose files',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _selectedFileName != null
                ? 'Selected: $_selectedFileName'
                : 'No file chosen',
            style: TextStyle(
              fontSize: 12,
              fontWeight:
              _selectedFileName != null ? FontWeight.w600 : FontWeight.normal,
              color: _selectedFileName != null
                  ? const Color(0xFF0B4F38)
                  : const Color(0xFF8B9B94),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'PDF, JPG or PNG · Up to 10 MB each',
            style: TextStyle(
              fontSize: 11.5,
              color: Color(0xFF8B9B94),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadedFilesContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE6ECE9)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Uploaded files',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF102A21),
            ),
          ),
          const SizedBox(height: 4),
          Consumer<DocumentProvider>(
            builder: (context, provider, _) {
              return Text(
                '${provider.documents.length} documents in your workspace',
                style: const TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF667871),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // ListView.builder using Provider
          Consumer<DocumentProvider>(
            builder: (context, provider, _) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.documents.length,
                separatorBuilder: (context, index) =>
                const Divider(height: 24, color: Color(0xFFEDF2F0)),
                itemBuilder: (context, index) {
                  final doc = provider.documents[index];
                  return DocumentItemRow(
                    title: doc.title,
                    subtitle: doc.subtitle,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}