import 'dart:convert';
import 'dart:io';

import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:base_module/core/app_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../widget/help_widget.dart';
import '../../../../widget/ui_design.dart';

class PortfolioDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> formDetails;

  const PortfolioDetailsScreen({
    super.key,
    required this.formDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppGradientBackground(),

          CustomScrollView(
            slivers: [

              /// APP BAR
              CustomSliverAppBar(
                title: 'Portfolio Details',
              ),

              /// DETAILS
              SliverPadding(
                padding: const EdgeInsets.all(16),

                sliver: SliverList.separated(
                  itemCount: formDetails.length,

                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 14),

                  itemBuilder: (context, index) {
                    final entry = formDetails.entries.elementAt(index);

                    final key = entry.key;
                    final value = entry.value;

                    final isImage = _isImageUrl(value);

                    return isImage
                        ? _buildImageCard(key, value.toString())
                        : _buildDetailsCard(
                      key: key,
                      value: value,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// DETAILS CARD
  Widget _buildDetailsCard({
    required String key,
    required dynamic value,
  }) {

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ],
        ),

        border: Border.all(
          color: Colors.white10,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// ICON
          Container(
            height: 52,
            width: 52,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.08),
            ),

            child: Icon(
              _getFieldIcon(key),
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          /// CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                /// TITLE
                Text(
                  _formatTitle(key),

                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 8),

                /// VALUE
                Text(
                  value is List
                      ? value.join(", ")
                      : value?.toString() ?? "N/A",

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// IMAGE CARD
  Widget _buildImageCard(String key, String imageUrl) {

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),

        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ],
        ),

        border: Border.all(color: Colors.white10),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          /// TITLE
          Row(
            children: [

              Container(
                height: 42,
                width: 42,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white.withOpacity(0.08),
                ),

                child: const Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  _formatTitle(key),

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(22),

            child: CachedNetworkImage(
              imageUrl: '${AppConfig.imageUrl}/$imageUrl',

              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,

              placeholder: (context, url) {
                return Container(
                  height: 220,
                  color: Colors.white.withOpacity(0.05),

                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },

              errorWidget: (context, url, error) {
                return Container(
                  height: 220,

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Icon(
                        Icons.broken_image_outlined,
                        color: Colors.white.withOpacity(0.6),
                        size: 42,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Unable to load image',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// CHECK IMAGE
  bool _isImageUrl(dynamic value) {
    if (value == null) return false;

    String stringValue = value.toString().toLowerCase();

    final hasImagePath =
        stringValue.contains('uploads/forms') ||
            stringValue.contains(AppConfig.imageUrl);

    final hasImageExtension =
        stringValue.endsWith('.jpg') ||
            stringValue.endsWith('.jpeg') ||
            stringValue.endsWith('.png') ||
            stringValue.endsWith('.gif') ||
            stringValue.endsWith('.webp') ||
            stringValue.endsWith('.bmp');

    return hasImagePath && hasImageExtension;
  }

  /// TITLE FORMAT
  String _formatTitle(String key) {
    return key
        .replaceAll("_", " ")
        .split(" ")
        .map(
          (e) =>
      e.isNotEmpty
          ? e[0].toUpperCase() + e.substring(1)
          : '',
    )
        .join(" ");
  }

  /// ICONS
  IconData _getFieldIcon(String fieldName) {

    final name = fieldName.toLowerCase();

    if (name.contains('name')) {
      return Icons.person_outline;
    }

    if (name.contains('email')) {
      return Icons.email_outlined;
    }

    if (name.contains('phone') ||
        name.contains('mobile')) {
      return Icons.phone_outlined;
    }

    if (name.contains('address')) {
      return Icons.location_on_outlined;
    }

    if (name.contains('date') ||
        name.contains('dob')) {
      return Icons.calendar_today_outlined;
    }

    if (name.contains('amount') ||
        name.contains('premium') ||
        name.contains('income')) {
      return Icons.currency_rupee;
    }

    if (name.contains('policy')) {
      return Icons.shield_outlined;
    }

    if (name.contains('aadhar') ||
        name.contains('pan')) {
      return Icons.badge_outlined;
    }

    if (name.contains('image') ||
        name.contains('photo') ||
        name.contains('document')) {
      return Icons.image_outlined;
    }

    return Icons.info_outline;
  }
}