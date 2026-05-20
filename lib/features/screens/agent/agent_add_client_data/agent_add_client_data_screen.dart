import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/models/agent_client_response.dart';
import 'package:flutter/material.dart';

import '../../../../widget/custom_button.dart';
import '../../../../widget/custom_textfield.dart';
import 'package:provider/provider.dart';

import 'agent_add_client_data_provider.dart';

class AgentAddClientDataScreen extends StatefulWidget {
  final AgentClientData? agentClientData;
  const AgentAddClientDataScreen({super.key, required this.agentClientData});

  @override
  State<AgentAddClientDataScreen> createState() =>
      _AgentAddClientDataScreenState();
}

class _AgentAddClientDataScreenState extends State<AgentAddClientDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<AgentAddClientDataProvider>().autoField(
        widget.agentClientData ?? AgentClientData(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Client'),
      body: Stack(
        children: [
          /// Background
          AppGradientBackground(),

          /// Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Consumer<AgentAddClientDataProvider>(
                builder: (context, provider, child) => Column(
                  children: [
                    /// Profile Image
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GestureDetector(
                          onTap: () {
                            provider.pickProfileImage(context: context);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.blue.shade100,
                            backgroundImage: provider.profileImage != null
                                ? FileImage(provider.profileImage!)
                                : widget.agentClientData?.profileImage !=
                                          null &&
                                      widget
                                          .agentClientData!
                                          .profileImage!
                                          .isNotEmpty
                                ? NetworkImage(
                                    '${AppConfig.imageUrl}/${widget.agentClientData!.profileImage}',
                                  )
                                : null,

                            child:
                                provider.profileImage == null &&
                                    (widget.agentClientData?.profileImage ==
                                            null ||
                                        widget
                                            .agentClientData!
                                            .profileImage!
                                            .isEmpty)
                                ? const Icon(
                                    Icons.person,
                                    size: 55,
                                    color: Colors.blue,
                                  )
                                : null,
                          ),
                        ),

                        /// Camera Button
                        GestureDetector(
                          onTap: () {
                            provider.pickProfileImage(context: context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),

                        /// Remove Button
                        if (provider.profileImage != null ||
                            (widget.agentClientData?.profileImage != null &&
                                widget
                                    .agentClientData!
                                    .profileImage!
                                    .isNotEmpty))
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                /// Remove Local Image
                                provider.removeProfileImage();

                                /// Optional:
                                /// clear network image also in edit mode
                                widget.agentClientData?.profileImage = null;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// Name
                    customTextField(
                      hintText: "Name",
                      prefixIcon: Icons.person_outline,
                      controller: provider.nameController,
                    ),

                    const SizedBox(height: 16),

                    /// Email
                    customTextField(
                      hintText: "Email",
                      prefixIcon: Icons.email_outlined,
                      controller: provider.emailController,
                    ),

                    const SizedBox(height: 16),

                    /// Phone
                    customTextField(
                      hintText: "Phone",
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                      controller: provider.phoneController,
                    ),

                    const SizedBox(height: 16),

                    /// Password
                    customTextField(
                      hintText: "Password",
                      obscureText: true,
                      prefixIcon: Icons.lock_outline,
                      controller: provider.passwordController,
                    ),

                    const SizedBox(height: 16),

                    /// Confirm Password
                    customTextField(
                      hintText: "Confirm Password",
                      obscureText: true,
                      prefixIcon: Icons.lock_reset_outlined,
                      controller: provider.confirmPasswordController,
                    ),

                    const SizedBox(height: 16),

                    /// Status Dropdown
                    DropdownButtonFormField<int>(
                      value: 1,
                      decoration: InputDecoration(
                        labelText: "Account Status",
                        prefixIcon: const Icon(Icons.verified_user_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 1, child: Text("Active")),
                        DropdownMenuItem(value: 0, child: Text("Inactive")),
                      ],
                      onChanged: (value) {},
                    ),

                    const SizedBox(height: 28),

                    CustomLoadingButton(
                      isLoading: provider.isLoading,
                      text: "Add/Update Client",
                      loadingText: "Updating...",
                      onTap: () => provider.agentAddClientData(
                        context,
                        widget.agentClientData?.id ?? 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
