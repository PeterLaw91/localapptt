import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(MyApp());
}