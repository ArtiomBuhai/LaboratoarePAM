import 'package:flutter/material.dart';
import 'app.dart';
import 'service_locator.dart';

void main() {
  // Initialize dependency injection
  ServiceLocator.setupDependencies();
  runApp(const MyApp());
}
