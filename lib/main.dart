import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/menu_screen.dart';
import 'providers/cart_provider.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PierresCafeApp());
}

class PierresCafeApp extends StatelessWidget {
  const PierresCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: "Pierre's Cafe",
        theme: AppTheme.lightTheme,
        home: const MenuScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
