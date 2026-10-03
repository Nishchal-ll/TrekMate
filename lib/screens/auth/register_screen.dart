import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/user_session.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/common/custom_checkbox.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/social_auth_button.dart';

/// Register screen matching Celtic Trekking design in ui.html
class RegisterScreen extends StatefulWidget {
  final VoidCallback onNavigateToLogin;
  final VoidCallback onRegisterSuccess;

  const RegisterScreen({
    super.key,
    required this.onNavigateToLogin,
    required this.onRegisterSuccess,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController(text: 'Sir Edmund Hillary');
  final _emailController = TextEditingController(text: 'explorer@celtictrekking.com');
  final _passwordController = TextEditingController();
  String? _selectedDestination = 'nepal';
  bool _agreeTerms = false;
  bool _isLoading = false;

  int _passwordScore = 0;
  String _passwordStrengthLabel = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _calculatePasswordStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;
    if (RegExp(r'[a-z]').hasMatch(password) && RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'\d').hasMatch(password)) score++;
    if (RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) score++;

    const labels = ['', 'Weak', 'Fair', 'Good', 'Strong'];

    setState(() {
      _passwordScore = score;
      _passwordStrengthLabel = password.isNotEmpty ? labels[score] : '';
    });
  }

  void _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty) {
      AppToast.show(context, 'Please enter your name', isError: true);
      return;
    }

    if (email.isEmpty || !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      AppToast.show(context, 'Invalid email address', isError: true);
      return;
    }

    if (password.length < 8) {
      AppToast.show(context, 'Password must be at least 8 characters', isError: true);
      return;
    }

    if (_selectedDestination == null || _selectedDestination!.isEmpty) {
      AppToast.show(context, 'Please select a destination', isError: true);
      return;
    }

    if (!_agreeTerms) {
      AppToast.show(context, 'Please agree to the Terms & Privacy Policy', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    UserSession().register(
      name: name,
      email: email,
      destination: _selectedDestination!,
    );

    AppToast.show(context, 'Account created successfully!');

    setState(() {
      _isLoading = false;
    });

    widget.onRegisterSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: widget.onNavigateToLogin,
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back, size: 16, color: AppColors.muted),
                        SizedBox(width: 6),
                        Text(
                          'Back to Sign In',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.muted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStepIndicator(),
                  const SizedBox(height: 18),
                  CustomTextField(
                    label: 'Full Name',
                    placeholder: 'Sir Edmund Hillary',
                    prefixIcon: Icons.person_outline,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Email Address',
                    placeholder: 'explorer@celtictrekking.com',
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    label: 'Password',
                    placeholder: 'Min. 8 characters',
                    prefixIcon: Icons.lock_outline,
                    controller: _passwordController,
                    isPassword: true,
                    onChanged: _calculatePasswordStrength,
                  ),
                  const SizedBox(height: 8),
                  _buildPasswordStrengthBar(),
                  const SizedBox(height: 14),
                  _buildDestinationDropdown(),
                  const SizedBox(height: 14),
                  CustomCheckbox(
                    value: _agreeTerms,
                    onChanged: (val) {
                      setState(() {
                        _agreeTerms = val;
                      });
                    },
                    label: 'I agree to the Terms & Privacy Policy',
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.navy,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.navy,
                              ),
                            )
                          : const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.navy,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(color: AppColors.border, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'OR SIGN UP WITH',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.muted.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(color: AppColors.border, thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      SocialAuthButton(
                        type: SocialType.google,
                        onTap: () => AppToast.show(
                          context,
                          'Google sign-up connected',
                        ),
                      ),
                      const SizedBox(width: 10),
                      SocialAuthButton(
                        type: SocialType.facebook,
                        onTap: () => AppToast.show(
                          context,
                          'Facebook sign-up connected',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(fontSize: 13, color: AppColors.muted),
                        ),
                        GestureDetector(
                          onTap: widget.onNavigateToLogin,
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.navy,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Container(
      width: double.infinity,
      height: 140,
      decoration: const BoxDecoration(
        color: AppColors.navy,
        image: DecorationImage(
          image: NetworkImage('https://picsum.photos/seed/nepaltrailv3/800/400'),
          fit: BoxFit.cover,
          opacity: 0.35,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.navy.withValues(alpha: 0.3),
              AppColors.navy.withValues(alpha: 0.7),
              AppColors.navy,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        alignment: Alignment.bottomLeft,
        child: const Text(
          'Join the Expedition',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStrengthBar() {
    Color getBarColor(int index) {
      if (index >= _passwordScore) return AppColors.border;
      switch (_passwordScore) {
        case 1:
          return AppColors.error;
        case 2:
          return AppColors.warning;
        case 3:
          return AppColors.gold;
        case 4:
          return AppColors.success;
        default:
          return AppColors.border;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: index < 3 ? 4 : 0),
                height: 3,
                decoration: BoxDecoration(
                  color: getBarColor(index),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        if (_passwordStrengthLabel.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            _passwordStrengthLabel,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.muted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDestinationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PREFERRED DESTINATION', style: AppStyles.label),
        const SizedBox(height: 7),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedDestination,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.muted),
              style: AppStyles.input,
              items: const [
                DropdownMenuItem(
                  value: 'nepal',
                  child: Row(
                    children: [
                      Icon(Icons.explore_outlined, color: AppColors.navy, size: 18),
                      SizedBox(width: 10),
                      Text('Nepal — Himalayas'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'tibet',
                  child: Row(
                    children: [
                      Icon(Icons.explore_outlined, color: AppColors.navy, size: 18),
                      SizedBox(width: 10),
                      Text('Tibet — Roof of the World'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'morocco',
                  child: Row(
                    children: [
                      Icon(Icons.explore_outlined, color: AppColors.navy, size: 18),
                      SizedBox(width: 10),
                      Text('Morocco — Atlas Mountains'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'romania',
                  child: Row(
                    children: [
                      Icon(Icons.explore_outlined, color: AppColors.navy, size: 18),
                      SizedBox(width: 10),
                      Text('Romania — Carpathians'),
                    ],
                  ),
                ),
              ],
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedDestination = val;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
