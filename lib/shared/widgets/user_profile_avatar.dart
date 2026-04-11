import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/supabase/supabase_provider.dart';
import 'glass_container.dart';

class UserProfileAvatar extends ConsumerWidget {
  final double radius;
  const UserProfileAvatar({super.key, this.radius = 17});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseProvider).auth.currentUser;
    final meta = user?.userMetadata ?? {};
    final avatarUrl =
        meta['avatar_url'] as String? ??
        'https://api.dicebear.com/7.x/adventurer/png?seed=${user?.id ?? 'default'}';

    return GestureDetector(
      onTap: () => _showProfileMenu(context, ref),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white12,
        backgroundImage: avatarUrl.startsWith('http')
            ? NetworkImage(avatarUrl)
            : const AssetImage('assets/images/placeholder_avatar.jpg')
                as ImageProvider,
        onBackgroundImageError: (_, __) {},
        child: (avatarUrl.isEmpty)
            ? Icon(Icons.person, color: Colors.white54, size: radius * 0.8)
            : null,
      ),
    );
  }

  void _showProfileMenu(BuildContext context, WidgetRef ref) {
    final user = ref.read(supabaseProvider).auth.currentUser;
    final meta = user?.userMetadata ?? {};
    final displayName = meta['full_name'] as String? ?? 'Barista';
    final email = user?.email ?? '';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.all(20),
          blur: 30,
          opacity: 0.15,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white12,
                      backgroundImage: avatarUrlFromMeta(meta, user?.id).startsWith('http')
                          ? NetworkImage(avatarUrlFromMeta(meta, user?.id))
                          : const AssetImage('assets/images/placeholder_avatar.jpg')
                              as ImageProvider,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          email,
                          style: GoogleFonts.poppins(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildMenuItem(context, Icons.language, 'Мова', trailing: '🇺🇦 UA'),
                _buildMenuItem(context, Icons.person_outline, 'Редагувати профіль', onTap: () {
                  context.pop();
                  context.push('/profile');
                }),
                _buildMenuItem(context, Icons.logout, 'Вийти', color: Colors.redAccent, onTap: () async {
                  context.pop();
                  await ref.read(supabaseProvider).auth.signOut();
                }),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  String avatarUrlFromMeta(Map<String, dynamic> meta, String? userId) {
    return meta['avatar_url'] as String? ??
        'https://api.dicebear.com/7.x/adventurer/png?seed=${userId ?? 'default'}';
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title, {
    String? trailing,
    Color? color,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color ?? const Color(0xFFC8A96E)),
      title: Text(
        title,
        style: GoogleFonts.poppins(color: color ?? Colors.white70, fontSize: 14),
      ),
      trailing: trailing != null
          ? Text(
              trailing,
              style: GoogleFonts.poppins(
                color: const Color(0xFFC8A96E),
                fontWeight: FontWeight.bold,
              ),
            )
          : const Icon(Icons.chevron_right, color: Colors.white10),
      onTap: onTap ?? () {},
    );
  }
}
