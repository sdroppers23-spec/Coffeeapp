import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../navigation/navigation_providers.dart';
import '../../shared/widgets/glass_container.dart';

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
    // Restore nav bar when leaving profile
    ref.read(navBarVisibleProvider.notifier).show();
    super.dispose();
  }

  void _editProfile(User user) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: _EditProfileDialog(
          user: user,
          supabase: ref.read(supabaseProvider),
        ),
      ),
    ).then((_) => setState(() {})); // refresh UI
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(supabaseProvider).auth.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Redirecting...', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      );
    }

    final meta = user.userMetadata ?? {};
    final displayName = meta['full_name'] as String? ?? 'Barista';
    final avatarUrl =
        meta['avatar_url'] as String? ??
        'https://api.dicebear.com/7.x/adventurer/png?seed=${user.id}';

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
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
                tooltip: 'Sign Out',
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
                      onBackgroundImageError: (_, _) => const Icon(
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
                    _StatColumn(ref.t('recipes'), '12'),
                    _StatColumn(ref.t('scans'), '4'),
                    _StatColumn(ref.t('badges'), '3'),
                  ],
                ),
              ),

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
            ],
          ),
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String val;
  const _StatColumn(this.label, this.val);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFC8A96E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white60),
        ),
      ],
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
          const SnackBar(
            content: Text('Image uploaded successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Upload failed: $e. Make sure you have an "avatars" bucket initialized in Supabase.',
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
        debugKey: 'profileDialog',
        borderRadius: 24,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Profile',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Display Name',
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
                            labelText: 'Avatar URL',
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
                        tooltip: 'Upload from Gallery',
                        onPressed: _isUploading ? null : _pickAndUploadImage,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white54),
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
                      : const Text(
                          'Save',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
