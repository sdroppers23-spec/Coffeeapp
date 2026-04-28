import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../navigation/navigation_providers.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/premium_background.dart';
import '../discover/lots/lots_providers.dart';
import '../brewing/custom_recipe_list.dart';
import 'package:intl/intl.dart';
import '../../core/providers/settings_provider.dart';


class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isLoading = false;

  Future<void> _signOut() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(supabaseProvider).auth.signOut();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    // Hide nav bar when entering profile
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(navBarVisibleProvider.notifier).hide();
    });
  }

  @override
  void dispose() {
    // Nav bar restoration is handled by PopScope for immediate feedback, 
    // but we keep a fallback here.
    super.dispose();
  }

  void _editProfile(User user) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),
          _EditProfileDialog(
            user: user,
            supabase: ref.read(supabaseProvider),
          ),
        ],
      ),
    ).then((_) => setState(() {})); // refresh UI
  }

  void _showPasswordResetDialog(String email) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),
          Dialog(
          backgroundColor: Colors.transparent,
          child: GlassContainer(
            borderRadius: 24,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mail_outline_rounded, color: Color(0xFFC8A96E), size: 48),
                const SizedBox(height: 24),
                Text(
                  context.t('password_reset'),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  context.t('password_reset_instruction'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(color: Colors.white70),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final successMessage = context.t('instruction_email_sent');
                          Navigator.of(context).pop();
                          try {
                            await ref.read(supabaseProvider).auth.resetPasswordForEmail(email);
                            messenger.showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color(0xFFC8A96E),
                                content: Text(
                                  successMessage,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          } catch (e) {
                            messenger.showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC8A96E),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(context.t('ok')),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white54,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(context.t('cancel')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      return PremiumBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle_outlined, size: 80, color: Colors.white24),
                  const SizedBox(height: 24),
                  Text(
                    context.t('profile_guest_title'),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.t('profile_guest_message'),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(isGuestProvider.notifier).setGuest(false);
                      // This will trigger the redirect in app_router
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      context.t('go_to_auth'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final meta = user.userMetadata ?? {};
    final displayName = meta['full_name'] as String? ?? 'Barista';
    final avatarUrl =
        meta['avatar_url'] as String? ??
        'https://api.dicebear.com/7.x/adventurer/png?seed=${user.id}';

    final recipesAsync = ref.watch(globalCustomRecipesProvider);
    final lotsAsync = ref.watch(userLotsStreamProvider);
    final favoritesAsync = ref.watch(favoriteLotsStreamProvider);

    final recipesCount = recipesAsync.when(data: (d) => d.length, loading: () => 0, error: (e, s) => 0);
    final lotsCount = lotsAsync.when(data: (d) => d.length, loading: () => 0, error: (e, s) => 0);
    final favoritesCount = favoritesAsync.when(data: (d) => d.length, loading: () => 0, error: (e, s) => 0);

    final createdAt = user.createdAt;
    final joinDate = DateFormat('dd.MM.yyyy').format(DateTime.parse(createdAt));
    final isGoogleUser = user.appMetadata['provider'] == 'google' || 
                        (user.identities?.any((i) => i.provider == 'google') ?? false);

    return PremiumBackground(
      child: PopScope(
        onPopInvokedWithResult: (didPop, _) {
          ref.read(navBarVisibleProvider.notifier).show();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          title: Text(
            ref.t('profile'),
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              ref.read(navBarVisibleProvider.notifier).show();
              context.pop();
            },
          ),
          actions: [
            if (_isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              )
            else ...[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: ref.t('sign_out'),
                onPressed: _signOut,
              ),
            ],
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              // Avatar
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white12,
                      backgroundImage: NetworkImage(avatarUrl),
                      onBackgroundImageError: (e, s) => const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white54,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFC8A96E),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () => _editProfile(user),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                displayName,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user.email ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.white54),
              ),
              const SizedBox(height: 40),

              // Stats Area
              GlassContainer(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatColumn(ref.t('recipes'), recipesCount.toString(), Icons.receipt_long_rounded),
                    _StatColumn(ref.t('lots'), lotsCount.toString(), Icons.inventory_2_rounded),
                    _StatColumn(ref.t('favorites'), favoritesCount.toString(), Icons.favorite_rounded),
                  ],
                ),
              ),

              const SizedBox(height: 32),
              
              // Account Details
              GlassContainer(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoRow(
                      label: ref.t('account_id'),
                      value: '${user.id.substring(0, 8)}...',
                      icon: Icons.fingerprint_rounded,
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: user.id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(ref.t('id_copied'))),
                        );
                      },
                    ),
                    const Divider(color: Colors.white12, height: 24),
                    _InfoRow(
                      label: ref.t('join_date'),
                      value: joinDate,
                      icon: Icons.calendar_today_rounded,
                    ),
                  ],
                ),
              ),

              if (!isGoogleUser) ...[
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () => _showPasswordResetDialog(user.email!),
                  child: Text(
                    ref.t('forgot_password'),
                    style: GoogleFonts.outfit(
                      color: const Color(0xFFC8A96E),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _editProfile(user),
                  icon: const Icon(Icons.settings),
                  label: Text(
                    ref.t('edit_profile'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8A96E),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // App Logo at bottom
              Image.asset(
                'assets/images/Logo2.png',
                height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              const Text(
                'v1.0.0',
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 120), // Bottom padding for nav bar clearance
            ],
          ),
        ),
      ),
    ),
  );
}
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String val;
  final IconData icon;
  const _StatColumn(this.label, this.val, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFC8A96E), size: 20),
        const SizedBox(height: 8),
        Text(
          val,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.white60),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFFC8A96E)),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.outfit(fontSize: 14, color: Colors.white70),
            ),
            const Spacer(),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (onTap != null) ...[
              const SizedBox(width: 8),
              const Icon(Icons.copy_rounded, size: 14, color: Colors.white38),
            ],
          ],
        ),
      ),
    );
  }
}

class _EditProfileDialog extends StatefulWidget {
  final User user;
  final SupabaseClient supabase;

  const _EditProfileDialog({required this.user, required this.supabase});

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  late TextEditingController _nameController;
  late TextEditingController _avatarUrlController;
  bool _isSaving = false;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final meta = widget.user.userMetadata ?? {};
    _nameController = TextEditingController(
      text: meta['full_name'] as String? ?? '',
    );
    _avatarUrlController = TextEditingController(
      text: meta['avatar_url'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _avatarUrlController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await widget.supabase.auth.updateUser(
        UserAttributes(
          data: {
            'full_name': _nameController.text.trim(),
            'avatar_url': _avatarUrlController.text.trim(),
          },
        ),
      );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: $e',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedFile == null) return;

    setState(() => _isUploading = true);
    try {
      final bytes = await pickedFile.readAsBytes();
      final fileExt = pickedFile.name.split('.').last;
      final fileName =
          '${widget.user.id}-${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      final storage = widget.supabase.storage.from('avatars');

      await storage.uploadBinary(
        fileName,
        bytes,
        fileOptions: FileOptions(contentType: 'image/$fileExt', upsert: true),
      );

      final imageUrl = storage.getPublicUrl(fileName);

      setState(() {
        _avatarUrlController.text = imageUrl;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.t('image_uploaded')),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.t('upload_failed', args: {'error': e.toString()}),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: GlassContainer(
        borderRadius: 24,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t('edit_profile_dialog_title'),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: context.t('display_name_label'),
                  labelStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _avatarUrlController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        labelText: context.t('avatar_url_label'),
                        labelStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: _isUploading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFC8A96E),
                            ),
                          )
                        : const Icon(
                            Icons.photo_library,
                            color: Color(0xFFC8A96E),
                          ),
                    tooltip: context.t('upload_from_gallery'),
                    onPressed: _isUploading ? null : _pickAndUploadImage,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      context.t('cancel'),
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8A96E),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            context.t('save'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
