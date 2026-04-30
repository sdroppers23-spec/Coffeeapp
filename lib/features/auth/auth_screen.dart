import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/supabase/supabase_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/database/database_provider.dart';
import '../../core/providers/settings_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

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
  bool _obscurePassword = true;

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

      // Trigger immediate sync to pull user data (lots, recipes) after auth change
      if (mounted) {
        final user = supabase.auth.currentUser;
        if (user != null) {
          // 1. Claim any data created in guest mode
          await ref.read(syncServiceProvider).claimGuestData(user.id);
          // 2. Disable guest mode
          ref.read(isGuestProvider.notifier).setGuest(false);
          // 3. Push the claimed data and pull user data
          ref.read(syncServiceProvider).syncAll();
        }
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
      final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];

      // GoogleSignIn version 7.x uses a singleton and needs initialization
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        // On mobile, providing a clientId can sometimes cause a mismatch if it's not the native ID.
        // serverClientId is what Supabase needs to verify the idToken.
        clientId: kIsWeb ? webClientId : null,
        serverClientId: webClientId,
      );

      final googleUser = await googleSignIn.authenticate();
      
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'No ID Token found.';
      }

      final supabase = ref.read(supabaseProvider);
      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      // Same post-login logic as email login
      if (mounted) {
        final user = supabase.auth.currentUser;
        if (user != null) {
          await ref.read(syncServiceProvider).claimGuestData(user.id);
          ref.read(isGuestProvider.notifier).setGuest(false);
          ref.read(syncServiceProvider).syncAll();
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-In Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/Logo2.png',
                      height: 140,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ref.t('auth_greeting'),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 48),
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: ref.t('email'),
                      labelStyle: const TextStyle(color: Colors.white54),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: ref.t('password'),
                      labelStyle: const TextStyle(color: Colors.white54),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: Colors.white54,
                          size: 20,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            _isLogin ? ref.t('log_in') : ref.t('sign_up'),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : _signInWithGoogle,
                    icon: const Icon(
                      Icons.g_mobiledata,
                      size: 32,
                      color: Colors.white,
                    ),
                    label: Text(
                      ref.t('google_sign_in'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Guest Mode Button
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            ref.read(isGuestProvider.notifier).setGuest(true);
                          },
                    child: Text(
                      ref.t('continue_as_guest'),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
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
                      _isLogin
                          ? ref.t('create_account')
                          : ref.t('already_have_account'),
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
          // Language Switcher in top right
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: GestureDetector(
              onTap: () {
                final current = ref.read(localeProvider);
                ref
                    .read(localeProvider.notifier)
                    .setLocale(current == 'uk' ? 'en' : 'uk');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ref.watch(localeProvider) == 'uk' ? '🇺🇦' : '🇺🇸',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      ref.watch(localeProvider).toUpperCase(),
                      style: GoogleFonts.outfit(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
