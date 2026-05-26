import 'dart:io';

import 'package:app_grownidhi/features/screens/individual/form_submit_details/form_submit_details_provider.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/product_apply_form_response.dart';
import 'package:base_module/core/models/service_products_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/custom_appbat.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/help_widget.dart';

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
    // TODO: implement initState
    Future.microtask(() {
      context.read<FormSubmitDetailsProvider>().fetchApplyForm(
        widget.productDetails.id ?? 0,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppGradientBackground(),
          Consumer<FormSubmitDetailsProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (provider.productApplyForm.formFields == null ||
                  provider.productApplyForm.formFields!.isEmpty) {
                return buildEmptyState(
                  title: "No Members Found",
                  subTitle: "Looks like there are no family members added yet.",
                  icon: Icons.group_off_rounded,
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    buildProductHeader(provider.productApplyForm.product),
                    spaceHeight(20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: customMultiSelectDropdown(
                              title: 'Company Data',

                              items: provider.companyData
                                  .map((e) => e.companyName ?? '')
                                  .toList(),

                              selectedItems: provider.selectedCompanyNames,

                              onConfirm: (values) {
                                provider.selectedCompanyNames = values;

                                provider.selectedCompanyIds = provider
                                    .companyData
                                    .where(
                                      (e) => values.contains(e.companyName),
                                    )
                                    .map((e) => e.id ?? 0)
                                    .toList();
                                provider.fetchAgentData();
                                provider.notifyListeners();
                              },
                            ),
                          ),
                          spaceWidth(20),

                          Expanded(
                            child: customMultiSelectDropdown(
                              title: 'Client Data',
                              items: provider.agentData
                                  .map((e) => e.name ?? '')
                                  .toList(),
                              selectedItems: provider.selectedClientNames,
                              onConfirm: (values) {
                                provider.selectedClientNames = values;

                                provider.selectedAgentIds = provider
                                    .agentData.where((e) => values.contains(e.name))
                                    .map((e) => e.id ?? 0)
                                    .toList();

                                provider.notifyListeners();
                              },
                            ),
                          )

                        ],
                      ),
                    ),
                    spaceHeight(10),
                    ListView.builder(
                      padding: EdgeInsets.all(11),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.productApplyForm.formFields?.length,
                      itemBuilder: (context, index) => buildTextField(
                        provider.productApplyForm.formFields![index],
                        provider,
                      ),
                    ),
                    spaceHeight(20),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomLoadingButton(
                        isLoading: provider.isSubmitLoading,
                        onTap: () => provider.productFormApply(
                          context,
                          provider.productApplyForm.product,
                        ),
                        text: 'Apply Form',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildProductHeader(Product? product) {
    return Stack(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),

        // Back Button
        Positioned(
          top: 10,
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 20),
                ),
              ),
              spaceWidth(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Subcategory
                  Row(
                    children: [
                      _buildTag(product?.categoryName?? 'Category'),
                      const SizedBox(width: 10),
                      if (product?.subcategoryName != null)
                        _buildTag(
                          product!.subcategoryName!,
                          color: Colors.white.withOpacity(0.3),
                        ),
                    ],
                  ),
                  // Product Name
                  Text(
                    product?.productName ?? 'Product Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildTextField(
    FormFields formField,
    FormSubmitDetailsProvider provider,
  ) {
    if (formField.fieldType == 'text') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(
          hintText: formField.label ?? 'Not Defined',
          controller: provider.controller.putIfAbsent(
            formField.fieldName ?? '',
            () => TextEditingController(),
          ),
        ),
      );
    }
   else if (formField.fieldType == 'number') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(
          hintText: formField.label ?? 'Not Defined',
          keyboardType: TextInputType.number,
          controller: provider.controller[formField.label],
        ),
      );
    }
    else if (formField.fieldType == 'date') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(
          hintText: formField.label ?? 'Not Defined',
          isRead: true,
          controller: provider.controller[formField.label],
          onTap: () => pickDateTime(
            context,
            provider.controller.putIfAbsent(
              formField.fieldName ?? '',
              () => TextEditingController(),
            ),
          ),
        ),
      );
    }
    else if (formField.fieldType == 'textarea') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customTextField(
          hintText: formField.label ?? 'Not Defined',
          maxLines: 3,
          controller: provider.controller[formField.label],
        ),
      );
    }
    else if (formField.fieldType == 'select') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customDropdown(
          hintText: formField.label ?? 'Not Defined',
          label: formField.fieldName ?? 'Not Defined',
          items: (formField.options ?? [])
              .map((value) => value.toString())
              .toList(),
          onChanged: (value) {
            provider.setDropdownValue(formField.fieldName ?? '', value ?? '');
          },
          value: provider.selectedDropdown[formField.fieldName],
        ),
      );
    }
    else if (formField.fieldType == 'radio') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customRadioGroup(
          title: formField.label ?? '',
          options: (formField.options ?? [])
              .map((value) => value.toString())
              .toList(),
          groupValue: provider.selectedRadio[formField.fieldName] ?? '',
          onChanged: (value) {
            provider.setRadioValue(formField.fieldName ?? '', value);
          },
        ),
      );
    }
   else if (formField.fieldType == 'checkbox') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: customCheckboxGroup(
          title: formField.label ?? '',
          options: (formField.options ?? [])
              .map((value) => value.toString())
              .toList(),
          isChecked: (value) {
            return provider.isChecked(formField.fieldName ?? '', value);
          },
          onTap: (value) {
            provider.toggleCheckbox(formField.fieldName ?? '', value);
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        documentUploadWidget(
          label: formField.label ?? 'Upload Document',

          imageFile: provider.selectedImages[formField.fieldName],

          onPick: () async {
            await provider.imagePicker.showImageSourceDialog(
              context: context,

              onImagePicked: (xFile) {
                if (xFile != null) {
                  provider.setImage(
                    formField.fieldName ?? '',
                    File(xFile.path),
                  );
                }
              },
            );
          },

          onRemove: () {
            provider.setImage(
              formField.fieldName ?? '',
              null,
            );
          },
        ),
      );
    }
  }
}
