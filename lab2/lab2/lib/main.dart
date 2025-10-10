import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const ShopUiLabApp());
}

class ShopUiLabApp extends StatelessWidget {
  const ShopUiLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop UI Lab',
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
