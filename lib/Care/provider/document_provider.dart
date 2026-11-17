import 'package:flutter/cupertino.dart';
import 'package:patientapp/Care/model/DocumentItem.dart';

class DocumentProvider extends ChangeNotifier {
  // Private list
  final List<DocumentItem> _documents = [
    DocumentItem(
      title: 'Registration certificate.pdf',
      subtitle: 'Uploaded today · Secure file',

    ),
    DocumentItem(
      title: 'Service licence.pdf',
      subtitle: 'Uploaded today · Secure file',

    ),
  ];

  // Public getter - read only
  List<DocumentItem> get documents => List.unmodifiable(_documents);

  int get count => _documents.length;

  bool get isEmpty => _documents.isEmpty;

  // Add new document
  void addDocument(DocumentItem document) {
    _documents.add(document);
    notifyListeners();
  }

  // Add multiple documents at once
  void addAllDocuments(List<DocumentItem> docs) {
    _documents.addAll(docs);
    notifyListeners();
  }

  // Remove by index
  void removeDocument(int index) {
    if (index >= 0 && index < _documents.length) {
      _documents.removeAt(index);
      notifyListeners();
    }
  }

  // Remove by title
  void removeByTitle(String title) {
    _documents.removeWhere((doc) => doc.title == title);
    notifyListeners();
  }

  // Clear all
  void clearAll() {
    _documents.clear();
    notifyListeners();
  }

  // Replace / Update
  void updateDocument(int index, DocumentItem newDoc) {
    if (index >= 0 && index < _documents.length) {
      _documents[index] = newDoc;
      notifyListeners();
    }
  }
}