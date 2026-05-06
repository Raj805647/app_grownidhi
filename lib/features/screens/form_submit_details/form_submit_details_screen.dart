import 'package:app_grownidhi/features/screens/form_submit_details/form_submit_details_provider.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormSubmitDetailsScreen extends StatefulWidget {
  final int id;
  const FormSubmitDetailsScreen({super.key, required this.id});

  @override
  State<FormSubmitDetailsScreen> createState() => _FormSubmitDetailsScreenState();
}

class _FormSubmitDetailsScreenState extends State<FormSubmitDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FormSubmitDetailsProvider>().fetchFormStateDetails(
        widget.id,);
    });
  }


  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FormSubmitDetailsProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final fields = provider.formDataList ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text("Fill Details")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// Dynamic Fields
          ...fields.map((field) => _buildField(field)).toList(),

          const SizedBox(height: 20),

          /// Submit Button
          ElevatedButton(
            onPressed: () {
              provider.submitForm(formData);
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  Widget _buildField(Field field) {
    switch (field.fieldType) {

      case "text":
      case "number":
        return _textField(field);

      case "textarea":
        return _textField(field, maxLines: 3);

      case "date":
        return _dateField(field);

      case "radio":
        return _radioField(field);

      case "select":
        return _dropdownField(field);

      case "image":
        return _imageField(field);

      default:
        return const SizedBox();
    }
  }
}

