import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:patientapp/Care/provider/LanguageProvider.dart';
import 'package:patientapp/Care/provider/location_provider.dart';
import 'package:patientapp/Care/widget/real_map_picker.dart';
import 'package:patientapp/utils/AppColors.dart';
import 'package:patientapp/utils/constants.dart';
import 'package:provider/provider.dart';

class SearchLocationField extends StatefulWidget {
  final Function(LatLng position, String address)? onLocationSelected;

  const SearchLocationField({
    super.key,
    this.onLocationSelected,
  });

  @override
  State<SearchLocationField> createState() =>
      _SearchLocationFieldState();
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
      if (!mounted) return;

      final loc = context.read<LocationProvider>();

      _controller.text = loc.address;
    });
  }

  void _notifyLocationSelected(LocationProvider loc) {
    widget.onLocationSelected?.call(
      loc.position,
      loc.address,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<LocationProvider>(
          builder: (context, loc, _) {
            // Keep the text field synchronized with the provider
            if (!_focusNode.hasFocus &&
                _controller.text != loc.address) {
              _controller.text = loc.address;
            }

            return TextFormField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (value) {
                if (value.trim().isEmpty) {
                  context.read<LocationProvider>().clearSearch();
                } else {
                  context.read<LocationProvider>().searchPlaces(value);
                }

                setState(() {});
              },
              decoration: InputDecoration(
                hintText: langProvider.translate('Search'),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.teal,
                ),
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
                    if (loc.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                  ],
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
            );
          },
        ),

        // Search results
        Consumer<LocationProvider>(
          builder: (context, loc, _) {
            if (loc.searchResults.isEmpty) {
              return const SizedBox.shrink();
            }

            return Container(
              margin: const EdgeInsets.only(top: 8),
              constraints: const BoxConstraints(maxHeight: 180),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: loc.searchResults.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = loc.searchResults[index];

                  final title =
                      item['structured_formatting']?['main_text']
                          ?? item['description']
                          ?? '';

                  final description = item['description'] ?? '';

                  return ListTile(
                    dense: true,
                    leading: const Icon(
                      Icons.location_on_outlined,
                      size: 20,
                      color: Colors.teal,
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      description,
                      style: const TextStyle(fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () async {
                      _controller.text = title;
                      _focusNode.unfocus();

                      await loc.selectPlace(item);

                      if (!mounted) return;

                      _controller.text = loc.address;
                      _notifyLocationSelected(loc);

                      setState(() {});
                    },
                  );
                },
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        // Map picker
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          clipBehavior: Clip.antiAlias,
          child: const RealMapPicker(),
        ),

        const SizedBox(height: 8),

        // Selected address
        Consumer<LocationProvider>(
          builder: (_, loc, __) {
            Constants.locAddress=loc.address;

            if (loc.address.isEmpty) {
              return const SizedBox.shrink();
            }

            return Text(
              '📍 ${loc.address}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
              maxLines: 2,
            );
          },
        ),
      ],
    );
  }
}