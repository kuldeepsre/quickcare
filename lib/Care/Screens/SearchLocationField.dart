import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/location_provider.dart';
import 'package:patientapp/Care/widget/real_map_picker.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:provider/provider.dart';

class SearchLocationField extends StatefulWidget {
  const SearchLocationField({super.key});
  @override
  State<SearchLocationField> createState() => _SearchLocationFieldState();
}

class _SearchLocationFieldState extends State<SearchLocationField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final address = context.read<LocationProvider>().address;
      if (address.isNotEmpty) {
        _controller.text = address;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. TextField - NOT inside Consumer
        Consumer<LocationProvider>(
          builder: (_, loc, __) {
            return TextFormField(
              key: ValueKey(loc.address),
              initialValue: loc.address,
          /*    controller: _controller,*/
              focusNode: _focusNode,
              onChanged: (val) {
                if (val.trim().isEmpty) {
                  context.read<LocationProvider>().clearSearch();
                } else {
                  context.read<LocationProvider>().searchPlaces(val);
                }

                setState(() {}); // only to show/hide clear button
              },
              decoration: InputDecoration(
                hintText: 'Search location, e.g. Delhi, Mumbai',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_controller.text.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          _controller.clear();
                          context.read<LocationProvider>().clearSearch();
                          setState(() {});
                        },
                      ),
                    // Loading - separate Consumer
                    Consumer<LocationProvider>(
                      builder: (_, loc, __) => loc.isLoading
                          ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2)),
                      )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            );
          }
        ),
    /*    Consumer<LocationProvider>(
          builder: (_, loc, __) {
            return TextFormField(
              // key forces rebuild when address changes
              key: ValueKey(loc.address),
              initialValue: loc.address,
              readOnly: false, // set true if you don't want user to edit manually
              maxLines: 2,
              minLines: 1,
              onChanged: (val) {
                if (val.trim().isEmpty) {
                  context.read<LocationProvider>().clearSearch();
                } else {
                  context.read<LocationProvider>().searchPlaces(val);
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on, size: 18, color: Colors.teal),
                hintText: 'Your location',
                isDense: true,
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            );
          },
        ),*/
        // 2. Search Results - Separate Consumer + fixed max height
        Consumer<LocationProvider>(
          builder: (context, loc, _) {
            if (loc.searchResults.isEmpty) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.only(top: 8),
              constraints: const BoxConstraints(maxHeight: 180), // <-- FIX
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: loc.searchResults.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final item = loc.searchResults[i];
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.location_on_outlined, size: 20, color: Colors.teal),
                    title: Text(item['structured_formatting']['main_text'] ?? item['description'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), maxLines: 1),
                    subtitle: Text(item['description'], style: const TextStyle(fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
                    onTap: () {
                      _controller.text = item['structured_formatting']['main_text'] ?? item['description'];
                      _focusNode.unfocus();
                      loc.selectPlace(item);
                      setState(() {});
                    },
                  );
                },
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        // 3. Map - FIXED HEIGHT - DO NOT REBUILD ON TYPING
        Container(
          height: 220, // <-- FIX: Must have fixed height
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          clipBehavior: Clip.antiAlias,
          child: const RealMapPicker(),
        ),

        // 4. Address text - Separate Consumer
        const SizedBox(height: 8),
        Consumer<LocationProvider>(
          builder: (_, loc, __) => loc.address.isEmpty
              ? const SizedBox.shrink()
              : Text('📍 ${loc.address}', style: TextStyle(fontSize: 11, color: Colors.grey.shade600), maxLines: 2),
        ),
      ],
    );
  }
}