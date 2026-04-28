import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../features/navigation/navigation_providers.dart';

/// Універсальна кнопка профілю для AppBar.
/// Відображає аватар користувача, при натисканні відкриває меню з:
///   - переходом на ProfileScreen
///   - зміною мови
///   - виходом з акаунта
class ProfileButton extends ConsumerWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(supabaseProvider).auth.currentUser;
    final theme = Theme.of(context);
    final locale = ref.watch(localeProvider);

    final avatarUrl =
        user?.userMetadata?['avatar_url'] as String? ??
        'https://api.dicebear.com/7.x/adventurer/png?seed=${user?.id ?? 'guest'}';

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => _showProfileMenu(context, ref, theme, locale, avatarUrl),
        child: Hero(
          tag: 'profile_avatar',
          child: CircleAvatar(
            radius: 18,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.2),
            backgroundImage: user != null ? NetworkImage(avatarUrl) : null,
            onBackgroundImageError: (exception, stackTrace) {},
            child: user == null
                ? Icon(
                    Icons.person_outline,
                    size: 18,
                    color: theme.colorScheme.primary,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  void _showProfileMenu(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    String locale,
    String avatarUrl,
  ) {
    final user = ref.read(supabaseProvider).auth.currentUser;
    final navBarBottom = MediaQuery.of(context).padding.bottom;

    // Hide nav bar before opening sheet
    ref.read(navBarVisibleProvider.notifier).hide();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _ProfileSheet(
        ref: ref,
        theme: theme,
        locale: locale,
        user: user,
        avatarUrl: avatarUrl,
        bottomPad: navBarBottom,
      ),
    ).whenComplete(() {
      if (!context.mounted) return;
      // Restore nav bar when sheet is dismissed (any method)
      // Only do it if we are NOT on the profile screen (which handles its own visibility)
      final String location = GoRouterState.of(context).uri.toString();
      if (location != '/profile') {
        ref.read(navBarVisibleProvider.notifier).show();
      }
    });
  }
}

class _ProfileSheet extends ConsumerWidget {
  final WidgetRef ref;
  final ThemeData theme;
  final String locale;
  final dynamic user;
  final String avatarUrl;
  final double bottomPad;

  const _ProfileSheet({
    required this.ref,
    required this.theme,
    required this.locale,
    required this.user,
    required this.avatarUrl,
    this.bottomPad = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef innerRef) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 32 + bottomPad),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle ──────────────────────────────────────────────────────────
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // ── User Info ────────────────────────────────────────────────────────
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.2,
                ),
                backgroundImage: user != null ? NetworkImage(avatarUrl) : null,
                onBackgroundImageError: (exception, stackTrace) {},
                child: user == null
                    ? Icon(
                        Icons.person,
                        size: 28,
                        color: theme.colorScheme.primary,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.userMetadata?['full_name'] as String? ?? 'Barista',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      user?.email ?? '',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Divider(color: Colors.white12),
          const SizedBox(height: 12),

          const SizedBox(height: 12),

          // ── Перейти до профілю ───────────────────────────────────────────────
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.manage_accounts_outlined,
              color: theme.colorScheme.primary,
            ),
            title: Text(
              innerRef.t('edit_profile'),
              style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.white38,
              size: 18,
            ),
            onTap: () {
              Navigator.of(context).pop();
              context.push('/profile');
            },
          ),

          const Divider(color: Colors.white12),

          // ── Вихід ───────────────────────────────────────────────────────────
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: Text(
              innerRef.t('sign_out'),
              style: GoogleFonts.outfit(color: Colors.redAccent, fontSize: 14),
            ),
            onTap: () async {
              Navigator.of(context).pop();
              await innerRef.read(supabaseProvider).auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
