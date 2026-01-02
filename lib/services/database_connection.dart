import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseConnection {
  // Private constructor for singleton
  DatabaseConnection._privateConstructor();

  // Single instance
  static final DatabaseConnection instance = DatabaseConnection._privateConstructor();

  // Supabase client
  late final SupabaseClient client;

  // Initialize Supabase
  Future<void> init() async {
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (supabaseUrl == null || supabaseAnonKey == null) {
      throw Exception(
        'Supabase credentials not found. Please check your .env file.\n'
        'Required: SUPABASE_URL and SUPABASE_ANON_KEY',
      );
    }

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );

    client = Supabase.instance.client;
  }
}
