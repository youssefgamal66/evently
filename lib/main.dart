import 'package:evently/core/app_theme/app_theme.dart';
import 'package:evently/core/maneger/app_provider.dart';
import 'package:evently/core/routes/app_route.dart';
import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/module/event/manger/event_provider.dart';
import 'package:evently/module/layout/manager/layout_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()..getTheme()..getlanguage()),
        ChangeNotifierProvider(create: (context) => LayoutProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider()),
      ],
      child: Builder(
        builder: (context) {
          var provider = context.watch<AppProvider>();
          return MaterialApp(
            title: 'Localizations Sample App',
            locale: Locale(provider.lang),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            themeMode: provider.themeMode,
            darkTheme: AppTheme.DrakTheme,
            routes: AppRoute.routes,
            initialRoute: RouteName.splash,
          );
        },
      ),
    );
  }
}
