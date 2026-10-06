import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants/app_colors.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/splash/splash_screen.dart';

enum AppScreen { splash, login, register, dashboard }

/// Top-level Celtic Trekking App configuration
class CelticTrekkingApp extends StatefulWidget {
  const CelticTrekkingApp({super.key});

  @override
  State<CelticTrekkingApp> createState() => _CelticTrekkingAppState();
}

class _CelticTrekkingAppState extends State<CelticTrekkingApp> {
  AppScreen _currentScreen = AppScreen.splash;

  void _navigateTo(AppScreen screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // White icons on Android
        statusBarBrightness: Brightness.dark,     // White text/icons on iOS
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        title: 'Celtic Trekking',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.offWhite,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryBlue,
            primary: AppColors.primaryBlue,
            secondary: AppColors.gold,
            surface: AppColors.white,
          ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
          ),
        ),
        builder: (context, child) {
          // Wrap with a Mobile Device Frame if running on a wide screen (Desktop/Web)
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                return Scaffold(
                  backgroundColor: const Color(0xFF071126),
                  body: Stack(
                    children: [
                      // Ambient glow background blobs
                      Positioned(
                        top: -100,
                        left: -50,
                        child: Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.navy.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -80,
                        right: -50,
                        child: Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryBlue.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      // Centered phone frame
                      Center(
                        child: Container(
                          width: (constraints.maxWidth - 32).clamp(320.0, 390.0),
                          height: (constraints.maxHeight - 32).clamp(500.0, 844.0),
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(44),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.6),
                                blurRadius: 50,
                                offset: const Offset(0, 20),
                              ),
                              BoxShadow(
                                color: AppColors.primaryBlue.withValues(alpha: 0.25),
                                blurRadius: 80,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: child ?? const SizedBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return child ?? const SizedBox();
            },
          );
        },
        home: _buildCurrentScreen(),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentScreen) {
      case AppScreen.splash:
        return SplashScreen(
          onContinue: () => _navigateTo(AppScreen.login),
        );
      case AppScreen.login:
        return LoginScreen(
          onNavigateToRegister: () => _navigateTo(AppScreen.register),
          onLoginSuccess: () => _navigateTo(AppScreen.dashboard),
        );
      case AppScreen.register:
        return RegisterScreen(
          onNavigateToLogin: () => _navigateTo(AppScreen.login),
          onRegisterSuccess: () => _navigateTo(AppScreen.dashboard),
        );
      case AppScreen.dashboard:
        return DashboardScreen(
          onLogout: () => _navigateTo(AppScreen.login),
        );
    }
  }
}
