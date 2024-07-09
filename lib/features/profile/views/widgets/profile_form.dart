import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/gaps.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/features/profile/models/profile_model.dart';
import 'package:mood_tracker/features/profile/view_models/profile_vm.dart';
import 'package:mood_tracker/features/profile/views/widgets/profile_button.dart';
import 'package:mood_tracker/features/profile/views/widgets/profile_input.dart';

class ProfileForm extends ConsumerStatefulWidget {
  const ProfileForm({super.key});

  @override
  ConsumerState<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController(text: '');
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _onPressChangePassword() async {
    final profileNotifier = ref.read(profileProvider.notifier);

    if (_formKey.currentState!.validate()) {
      try {
        await profileNotifier.changePassword(
          currentPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text,
        );
        if (profileNotifier.errorMessage.isEmpty) {
          _showSnackBar('Password changed successfully');
          _formKey.currentState!.reset();
          _oldPasswordController.clear();
          _newPasswordController.clear();
          FocusScope.of(context).unfocus();
        } else {
          _showSnackBar(profileNotifier.errorMessage);
        }
      } catch (e) {
        _showSnackBar(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider).value!;

    ref.listen<AsyncValue<ProfileModel>>(profileProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) => _showSnackBar(error.toString()),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileInputField(
          hintText: profile.email,
          icon: FontAwesomeIcons.envelope,
          readOnly: true,
        ),
        Gaps.v10,
        ProfileInputField(
          hintText: profile.name,
          icon: FontAwesomeIcons.user,
          readOnly: true,
        ),
        Gaps.v28,
        Text(
          'Change password',
          style: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
        Gaps.v10,
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileInputField(
                controller: _oldPasswordController,
                hintText: "Enter old password",
                icon: FontAwesomeIcons.lock,
                readOnly: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
              ),
              Gaps.v10,
              ProfileInputField(
                controller: _newPasswordController,
                hintText: "Enter new password",
                icon: FontAwesomeIcons.lock,
                readOnly: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  return null;
                },
              ),
              Gaps.v24,
              ProfileButton(
                onTap: _onPressChangePassword,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
