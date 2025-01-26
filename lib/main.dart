import 'package:flutter/material.dart';
import 'package:nfcreadertools/core/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nfcreadertools/features/splash/provider/splash_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          /// Splash provider
          ChangeNotifierProvider(create: (context) => SplashProvider()),
        ],
        builder: (context, child) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                routerConfig: AppRouter.router,
              );
            },
          );
        });
  }
}
