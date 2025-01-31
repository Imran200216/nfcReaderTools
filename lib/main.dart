import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nfcreadertools/core/colors/app_colors.dart';
import 'package:nfcreadertools/core/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/features/auth/presentation/provider/apple_sign_in_provider.dart';
import 'package:nfcreadertools/features/auth/presentation/provider/email_password_auth_provider.dart';
import 'package:nfcreadertools/features/auth/presentation/provider/google_sign_in_provider.dart';
import 'package:nfcreadertools/features/bottom_nav/presentation/provider/bottom_nav_provider.dart';
import 'package:nfcreadertools/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// firebase options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// local storage for saving the get started status
  await Hive.initFlutter();
  await Hive.openBox('userGetStartedStatusBox');

  /// safe area bg color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.safeAreaColor,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// bottom nav provider
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),

        /// email password auth provider
        ChangeNotifierProvider(
            create: (context) => EmailPasswordAuthProvider()),

        /// google auth provider
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),

        /// apple auth provider
        ChangeNotifierProvider(create: (context) => AppleSignInProvider()),
      ],
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return ToastificationWrapper(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                routerConfig: AppRouter.router,
              ),
            );
          },
        );
      },
    );
  }
}
