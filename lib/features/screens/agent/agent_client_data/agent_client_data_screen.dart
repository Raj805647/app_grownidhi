import 'package:app_grownidhi/features/screens/agent/agent_client_data/agent_client_data_provider.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:app_grownidhi/widget/custom_appbat.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:base_module/core/app_config.dart';
import 'package:base_module/core/models/agent_client_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'agent_add_client_data_screen.dart';

class AgentClientDataScreen extends StatefulWidget {
  const AgentClientDataScreen({super.key});

  @override
  State<AgentClientDataScreen> createState() => _AgentClientDataScreenState();
}

class _AgentClientDataScreenState extends State<AgentClientDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<AgentClientDataProvider>().fetchAgentClientData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AgentClientDataProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: CustomAppBar(
          title: 'Client Data',
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AgentAddClientDataScreen(agentClientData: null,),
                ),
              ),
              icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
            ),
          ],
        ),
        body: Stack(
          children: [
            AppGradientBackground(),
            (provider.isLoading)
                ? Center(child: CircularProgressIndicator())
                : (provider.agentClientData.isEmpty)
                ? Center(child: Text('Not Available Data'))
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16),
                    itemCount: provider.agentClientData.length,
                    itemBuilder: (context, index) =>
                        buildClientDataCard(provider.agentClientData[index]),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildClientDataCard(AgentClientData agentClientData) {
    final bool isActive = (agentClientData.status == true);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AgentAddClientDataScreen(agentClientData: agentClientData),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.grey.shade200,
                backgroundImage:
                    agentClientData.profileImage != null &&
                        agentClientData.profileImage!.isNotEmpty
                    ? NetworkImage(
                        '${AppConfig.imageUrl}/${agentClientData.profileImage}',
                      )
                    : null,
                child:
                    agentClientData.profileImage == null ||
                        agentClientData.profileImage!.isEmpty
                    ? const Icon(Icons.person, size: 30)
                    : null,
              ),

              const SizedBox(width: 14),

              /// Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          agentClientData.name ?? "N/A",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isActive ? "Account Active" : "Account Unactive",
                            style: TextStyle(
                              color: isActive ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Email
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            agentClientData.email ?? "N/A",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Phone
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          agentClientData.phone ?? "N/A",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// Created By
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "Created By: ${agentClientData.createdBy ?? 'N/A'}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Text(
                      agentClientData.createdAt ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
