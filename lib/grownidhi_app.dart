import 'package:app_grownidhi/routes/app_routes.dart';
import 'package:app_grownidhi/routes/route_names.dart';
import 'package:flutter/material.dart';

import 'config/provider_config.dart';
import 'package:provider/provider.dart';

class GrownidhiApp extends StatelessWidget {
  const GrownidhiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: ProviderConfig.providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grownidhi App',
          initialRoute: RouteNames.splashScreen,
          routes: AppRoutes.routes,
      
          theme: ThemeData(
            fontFamily: 'Iosef',
          ),
        ),
      ),
    );
  }}
