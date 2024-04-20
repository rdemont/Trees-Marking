

import 'package:flutter/material.dart';
import 'package:treesmarking/pages/mainPage.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'services/databaseService.dart';



void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    DatabaseService.initializeDb();

    return MaterialApp(
      title: "Tree-Marking",

      
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],


      supportedLocales: [
        Locale('en'), // English
        Locale('fr'), // French
      ],
      localeListResolutionCallback: (allLocales, supportedLocales) {
    final locale = allLocales?.first.languageCode;
print("++++++++++++++++System local : $locale");    
    if (locale == 'en') {
      return const Locale('en','US');
    }
    // The default locale
    return const Locale('fr','FR');    
  },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
      //home: const  MarkedTreeListPage(),
    );
  }
}
