import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/custom_textfield.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/models/client_complete_profile_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'agent_client_add_update_profile_provider.dart';

class AgentClientAddUpdateProfileScreen extends StatefulWidget {
final int clientId;
final ClientCompleteData clientData;
  const AgentClientAddUpdateProfileScreen({super.key, required this.clientId, required this.clientData});

  @override
  State<AgentClientAddUpdateProfileScreen> createState() => _AgentClientAddUpdateProfileScreenState();
}

class _AgentClientAddUpdateProfileScreenState extends State<AgentClientAddUpdateProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask((()=> context.read<AgentClientAddUpdateProfileProvider>().initailizeTextController(widget.clientData)));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff101426),

      appBar: CustomAppBar(title: 'Add Client Complete Profile'),

      body: Stack(
        children: [
          AppGradientBackground(),

          Consumer<AgentClientAddUpdateProfileProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [Color(0xff1E293B), Color(0xff0F172A)],
                        ),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.blueAccent.withOpacity(0.2),
                            child: const Icon(
                              Icons.person_add_alt_1,
                              size: 40,
                              color: Colors.blueAccent,
                            ),
                          ),

                          const SizedBox(height: 14),

                          const Text(
                            "Client Profile Details",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Fill all required information carefully",
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// PERSONAL DETAILS
                    buildSectionTitle("Personal Information"),

                    customTextField(
                      hintText: "Father Name",
                      controller: provider.fatherNameController,
                    ),

                    customTextField(
                      hintText: "Alternate Mobile Number",
                      controller: provider.alternateMobileController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                    ),

                    customTextField(
                      hintText: "Date of Birth",
                      isRead: true,
                      controller: provider.dobController,
                      onTap: () => pickDateTime(
                        context,
                        provider.dobController,
                        includeTime: false,
                      ),
                    ),

                    customDropdown(
                      label: "Gender",
                      value: provider.gender,
                      items: const ["male", "female", "other"],
                      onChanged: (v) {
                        provider.gender = v;
                        provider.notifyListeners();
                      },
                    ),

                    customDropdown(
                      label: "Marital Status",
                      value: provider.maritalStatus,
                      items: const ["single", "married"],
                      onChanged: (v) {
                        provider.maritalStatus = v;
                        provider.notifyListeners();
                      },
                    ),

                    const SizedBox(height: 20),

                    /// ADDRESS
                    buildSectionTitle("Address Details"),

                    customTextField(
                      hintText: "Address Line 1",
                      controller: provider.addressLine1Controller,
                    ),

                    customTextField(
                      hintText: "Address Line 2",
                      controller: provider.addressLine2Controller,
                    ),

                    customTextField(
                      hintText: "City",
                      controller: provider.cityController,
                    ),

                    customTextField(
                      hintText: "State",
                      controller: provider.stateController,
                    ),

                    customTextField(
                      hintText: "Pincode",
                      controller: provider.pincodeController,
                    ),

                    customTextField(
                      hintText: "Country",
                      controller: provider.countryController,
                    ),

                    const SizedBox(height: 20),

                    /// PROFESSIONAL DETAILS
                    buildSectionTitle("Professional Details"),

                    customTextField(
                      hintText: "Occupation",
                      controller: provider.occupationController,
                    ),

                    customTextField(
                      hintText: "Designation",
                      controller: provider.designationController,
                    ),

                    customTextField(
                      hintText: "Education",
                      controller: provider.educationController,
                    ),

                    customTextField(
                      hintText: "Annual Income",
                      controller: provider.annualIncomeController,
                    ),

                    customTextField(
                      hintText: "Monthly Income",
                      controller: provider.monthlyIncomeController,
                    ),

                    const SizedBox(height: 20),

                    /// DOCUMENT UPLOAD
                    buildSectionTitle("Documents"),

                    uploadDocumentCard(
                      title: "Education Document",
                      icon: Icons.upload_file,
                      fileName: provider.educationDocumentName,
                      onTap: ()=> provider.pickEducationDocument(context),
                    ),

                    const SizedBox(height: 30),

                    /// SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: ()=>provider.submitClientDta(context, widget.clientId),
                        child: const Text(
                          "Save Profile",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// SECTION TITLE
  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// DOCUMENT CARD
  Widget uploadDocumentCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    String? fileName,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xff1A2238),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.blueAccent),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    fileName ?? "Tap to upload document",
                    style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white54,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
