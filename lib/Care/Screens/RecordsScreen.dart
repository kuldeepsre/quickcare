import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patientapp/Care/provider/health_records_provider.dart';
import 'package:patientapp/Care/widget/_StatCard.dart';
import 'package:provider/provider.dart';

import '../provider/LanguageProvider.dart';


class HealthRecordsScreen extends StatelessWidget {
  const HealthRecordsScreen({super.key});

  IconData _getIcon(String? type) {
    switch (type) {
      case 'lab':
        return Icons.science_outlined;
      case 'visit':
        return Icons.description_outlined;
      case 'transport':
        return Icons.local_shipping_outlined;
      default:
        return Icons.folder_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = context.watch<LanguageProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFEEF5F0),
      body: SafeArea(
        child: Consumer<HealthRecordsProvider>(
          builder: (context, provider, child) {
            final records = provider.filteredRecords;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    langProvider.translate('Healthrecords'),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF102E26),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    langProvider.translate('allsafty'),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.45),
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Search field
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: provider.searchRecords,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: langProvider.translate('search'),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.35),
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black.withOpacity(0.4),
                        ),
                        suffixIcon: provider.searchQuery.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: provider.clearSearch,
                        )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Statistics
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          value: '${provider.totalRecords}',
                          label: langProvider.translate('Totalrecords'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          value: '${provider.labReports}',
                          label: langProvider.translate('Labreports'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          value: '${provider.careVisits}',
                          label: langProvider.translate('Carevisits'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Records list
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: records.isEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(30),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 42,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No records found',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF102E26),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : ListView.separated(
                      itemCount: records.length,
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, index) => Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black.withOpacity(0.06),
                      ),
                      itemBuilder: (context, index) {
                        final record = records[index];

                        return InkWell(
                          onTap: () {
                            // Navigate to the selected record.
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6F4EE),
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _getIcon(record.icon.toString()),
                                    size: 20,
                                    color: const Color(0xFF1B5E4F),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        record.title ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.w600,
                                          color: Color(0xFF102E26),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        record.sub ?? '',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black
                                              .withOpacity(0.45),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black
                                          .withOpacity(0.08),
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.chevron_right,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

