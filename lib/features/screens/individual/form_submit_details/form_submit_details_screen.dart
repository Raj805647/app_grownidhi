import 'dart:io';

import 'package:app_grownidhi/features/screens/individual/form_submit_details/form_submit_details_provider.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/form_state_details_response.dart';
import 'package:base_module/core/models/service_products_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_appbat.dart';

class FormSubmitDetailsScreen extends StatefulWidget {
  final ServiceProductsData productDetails;
  const FormSubmitDetailsScreen({super.key, required this.productDetails});

  @override
  State<FormSubmitDetailsScreen> createState() =>
      _FormSubmitDetailsScreenState();
}

class _FormSubmitDetailsScreenState extends State<FormSubmitDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<FormSubmitDetailsProvider>().fetchFormStateDetails(
        widget.productDetails.id ?? 0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormSubmitDetailsProvider>(
      builder: (context, provider, child) => Scaffold(
        extendBodyBehindAppBar: true,

        appBar: CustomAppBar(title: provider.appBarName),

        body: Stack(
          children: [
            /// BACKGROUND
            const AppGradientBackground(),

            /// FORM UI
            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.formDataList.isEmpty
                ? const Center(
                    child: Text(
                      'Data Not Available',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),

                        /// TITLE
                        const Text(
                          "Fill Your Details",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Please complete the form below",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),

                        const SizedBox(height: 25),

                        /// FORM CONTAINER
                        Container(
                          padding: const EdgeInsets.all(18),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),

                            borderRadius: BorderRadius.circular(28),

                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),

                          child: Column(
                            children: List.generate(
                              provider.formDataList.length,
                              (index) {
                                final field = provider.formDataList[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: _buildField(context, provider, field),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// SUBMIT BUTTON
                        provider.formDataList.isNotEmpty
                            ? SizedBox(
                                width: double.infinity,
                                height: 58,

                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF2575FC),

                                    elevation: 10,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),

                                  onPressed: () {
                                    provider.getFormValues(
                                      context,
                                      widget.productDetails,
                                    );
                                  },

                                  child: const Text(
                                    "Submit Form",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    BuildContext context,
    FormSubmitDetailsProvider provider,
    Fields field,
  ) {
    switch (field.fieldType) {
      /// TEXT
      case "text":
        return customTextField(
          hintText: field.label ?? '',
          controller: provider.controllers[field.fieldName],
        );

      /// NUMBER
      case "number":
        return customTextField(
          hintText: field.label ?? '',
          controller: provider.controllers[field.fieldName],
          keyboardType: TextInputType.number,
        );

      /// DATE
      case "date":
        return customTextField(
          controller: provider.controllers[field.fieldName],
          hintText: field.label ?? '',
          isRead: true,
          suffixIcon: const Icon(Icons.calendar_month),

          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              initialDate: DateTime.now(),
            );

            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

              provider.controllers[field.fieldName]?.text = formattedDate;

              provider.notifyListeners();

              print("Selected Date => $formattedDate");
            }
          },
        );

      /// TEXTAREA
      case "textarea":
        return customTextField(
          hintText: field.label ?? '',
          controller: provider.controllers[field.fieldName],
          maxLines: 3,
        );

      /// SELECT
      case "select":
        return customDropdown(
          label: field.label ?? '',

          /// Selected value
          value: provider.selectedDropdown[field.fieldName],

          /// Dropdown items
          items: field.options is List ? List<String>.from(field.options) : [],

          onChanged: (value) {
            provider.setDropdownValue(field.fieldName ?? '', value);

            print("Selected => $value");
          },
        );

      /// RADIO
      case "radio":
        return Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.label ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              ...List.generate(
                field.options.length,
                (i) => RadioListTile(
                  activeColor: Colors.white,

                  value: field.options[i],

                  groupValue: provider.selectedRadio[field.fieldName],

                  onChanged: (value) {
                    provider.setRadioValue(field.fieldName ?? '', value);
                  },

                  title: Text(
                    field.options[i],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );

      /// CHECKBOX
      case "checkbox":
        return Container(
          padding: const EdgeInsets.all(14),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.label ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              ...List.generate(
                field.options.length,
                (i) => CheckboxListTile(
                  activeColor: Colors.white,

                  value: provider.isChecked(
                    field.fieldName ?? '',
                    field.options[i],
                  ),

                  onChanged: (value) {
                    provider.toggleCheckbox(
                      field.fieldName ?? '',
                      field.options[i],
                    );
                  },

                  title: Text(
                    field.options[i],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );

      /// IMAGE
      case "image":
        final image = provider.getImage(field.fieldName ?? '');

        return GestureDetector(
          onTap: () {
            provider.pickImage(
              context: context,
              fieldName: field.fieldName ?? '',
            );
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),

            height: 150,
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),

              border: Border.all(color: Colors.white.withOpacity(0.3)),

              color: Colors.white.withOpacity(0.08),
            ),

            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(22),

                    child: Image.file(File(image.path), fit: BoxFit.cover),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        Icons.cloud_upload_rounded,
                        size: 42,
                        color: Colors.white,
                      ),

                      SizedBox(height: 12),

                      Text(
                        "Upload Image",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        );

      default:
        return const SizedBox();
    }
  }
}
