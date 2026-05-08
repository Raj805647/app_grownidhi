import 'dart:convert';
import 'dart:io';

import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:base_module/core/app_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PortfolioDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> formDetails;

  const PortfolioDetailsScreen({super.key, required this.formDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Portfolio Details'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: formDetails.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final entry = formDetails.entries.elementAt(index);
            final key = entry.key;
            final value = entry.value;

            // Check if value is a URL that should show an image
            final isImageUrl = _isImageUrl(value);

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: isImageUrl
                  ? _buildImageTile(key, value.toString())
                  : ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getFieldIcon(key),
                    size: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
                title: Text(
                  key.replaceAll("_", " ").toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    value is List
                        ? value.join(", ")
                        : value?.toString() ?? "N/A",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImageTile(String key, String imageUrl) {
    print('akdjfnakjfd=> ${AppConfig.imageUrl}/${imageUrl}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            key.replaceAll("_", " ").toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: '${AppConfig.imageUrl}/$imageUrl',
              placeholder: (context, url) => Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey.shade100,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 40,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Failed to load image',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }

  bool _isImageUrl(dynamic value) {
    if (value == null) return false;

    String stringValue = value.toString();
    final hasImagePath = stringValue.contains('uploads/forms') ||
        stringValue.contains(AppConfig.imageUrl);

    final hasImageExtension = stringValue.contains('.jpg') ||
        stringValue.contains('.jpeg') ||
        stringValue.contains('.png') ||
        stringValue.contains('.gif') ||
        stringValue.contains('.webp') ||
        stringValue.contains('.bmp');

    return hasImagePath && hasImageExtension;
  }

  IconData _getFieldIcon(String fieldName) {
    final name = fieldName.toLowerCase();
    if (name.contains('name')) return Icons.person_outline;
    if (name.contains('email')) return Icons.email_outlined;
    if (name.contains('phone')) return Icons.phone_outlined;
    if (name.contains('address')) return Icons.location_on_outlined;
    if (name.contains('date')) return Icons.calendar_today_outlined;
    if (name.contains('image') || name.contains('photo') || name.contains('document'))
      return Icons.image_outlined;
    return Icons.info_outline;
  }
  }
