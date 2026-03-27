import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/supabase/supabase_provider.dart';
import '../../core/l10n/app_localizations.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final supabase = ref.read(supabaseProvider);
      if (_isLogin) {
        await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      } else {
        await supabase.auth.signUp(email: email, password: password);
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      // Use browser-based OAuth with deep link for a "global" fix that doesn't require SHA-1 fingerprints
      // The redirect URL must be io.supabase.specialtytracker://login-callback
      await ref.read(supabaseProvider).auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.specialtytracker://login-callback',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Google Sign-In Error: $e'),
        backgroundColor: Colors.red,
      ));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Specialty Tracker',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC8A96E),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                ref.t('auth_subtitle'),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white54, height: 1.5),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: ref.t('email'), labelStyle: const TextStyle(color: Colors.white54)),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: ref.t('password'), labelStyle: const TextStyle(color: Colors.white54)),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                    : Text(_isLogin ? ref.t('log_in') : ref.t('sign_up'), style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _signInWithGoogle,
                icon: const Icon(Icons.g_mobiledata, size: 32, color: Colors.white),
                label: Text(ref.t('google_sign_in'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                child: Text(
                  _isLogin ? ref.t('create_account') : ref.t('already_have_account'),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
