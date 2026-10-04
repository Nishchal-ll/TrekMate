import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../models/user_session.dart';
import '../../widgets/common/app_toast.dart';
import '../../widgets/common/custom_checkbox.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/social_auth_button.dart';

/// Login Screen matching Celtic Trekking design
class LoginScreen extends StatefulWidget {
  final VoidCallback onNavigateToRegister;
  final VoidCallback onLoginSuccess;

  const LoginScreen({
    super.key,
    required this.onNavigateToRegister,
    required this.onLoginSuccess,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'explorer@celtictrekking.com');
  final _passwordController = TextEditingController(text: 'adventure123');
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty) {
      AppToast.show(context, 'Please enter your email', isError: true);
      return;
    }

    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      AppToast.show(context, 'Invalid email address', isError: true);
      return;
    }

    if (password.isEmpty) {
      AppToast.show(context, 'Please enter your password', isError: true);
      return;
    }

    if (password.length < 6) {
      AppToast.show(context, 'Password must be at least 6 characters', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    UserSession().login(email: email);
    AppToast.show(context, 'Welcome back, ${UserSession().userName}!');

    setState(() {
      _isLoading = false;
    });

    widget.onLoginSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Welcome Back', style: AppStyles.heading1),
                    const SizedBox(height: 4),
                    const Text(
                      'Sign in to continue your journey',
                      style: AppStyles.subtitle,
                    ),
                    const SizedBox(height: 18),
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
                      placeholder: 'Enter your password',
                      prefixIcon: Icons.lock_outline,
                      controller: _passwordController,
                      isPassword: true,
                      onSubmitted: _handleLogin,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomCheckbox(
                            value: _rememberMe,
                            onChanged: (val) {
                              setState(() {
                                _rememberMe = val;
                              });
                            },
                            label: 'Remember me',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            AppToast.show(context, 'Reset link sent to your email');
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Lighter modern blue button with subtle gradient & glow
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.buttonBlue, AppColors.buttonBlueDark],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.buttonBlue.withValues(alpha: 0.35),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _isLoading ? null : _handleLogin,
                          borderRadius: BorderRadius.circular(12),
                          child: Center(
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.white,
                                    ),
                                  )
                                : const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
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
                            'OR CONTINUE WITH',
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SocialAuthButton(
                          type: SocialType.google,
                          onTap: () => AppToast.show(
                            context,
                            'Google sign-in connected',
                          ),
                        ),
                        const SizedBox(width: 10),
                        SocialAuthButton(
                          type: SocialType.facebook,
                          onTap: () => AppToast.show(
                            context,
                            'Facebook sign-in connected',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(fontSize: 13, color: AppColors.muted),
                          ),
                          GestureDetector(
                            onTap: widget.onNavigateToRegister,
                            child: const Text(
                              'Create one',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroHeader() {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      height: 160 + topPadding,
      decoration: const BoxDecoration(
        color: AppColors.navy,
        image: DecorationImage(
          image: NetworkImage('https://picsum.photos/seed/celticmtnv3/800/500'),
          fit: BoxFit.cover,
          opacity: 0.28,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.navy.withValues(alpha: 0.2),
              AppColors.navy.withValues(alpha: 0.7),
              AppColors.navy,
            ],
          ),
        ),
        padding: EdgeInsets.only(top: topPadding + 8, bottom: 14, left: 20, right: 20),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 75,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.terrain, color: AppColors.gold, size: 28),
                SizedBox(width: 8),
                Text(
                  'CELTIC TREKKING',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
