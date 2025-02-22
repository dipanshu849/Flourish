import 'package:flourish/src/app.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://snahlxpgzotdrkpzhpgk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNuYWhseHBnem90ZHJrcHpocGdrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAyNTAzMTQsImV4cCI6MjA1NTgyNjMxNH0.FXfFGMxIEhEFeWPKsGEWNSRxjyMUbB56Z7pOZWx9CJM',
  );
  final session = Supabase.instance.client.auth.currentSession;

  runApp(App(isLoggedIn: session != null));
}
