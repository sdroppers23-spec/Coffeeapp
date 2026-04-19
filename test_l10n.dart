// ignore_for_file: avoid_print
import 'package:specialty_tracker/core/l10n/sca_flavor_wheel_l10n.dart';

void main() {
  print('TESTING UK LOCALE');
  print(ScaFlavorWheelL10n.translate('uk', 'wheel_cat_fruity'));
  print(ScaFlavorWheelL10n.translate('uk', 'wheel_note_blackberry'));
  print(ScaFlavorWheelL10n.translate('uk', 'some_unknown_key'));
}
