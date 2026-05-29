import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/constants/theme.dart';

import 'blocs/weather/weather_bloc.dart';
import 'cubits/theme_cubit.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  //khởi tạo dotenv
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => WeatherBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

enum WeatherTheme { sun, rain, normal }

ThemeData _themeFromMode(WeatherTheme mode) {
  switch (mode) {
    case WeatherTheme.sun:
      return ThemeApp.sunTheme;
    case WeatherTheme.rain:
      return ThemeApp.rainTheme;
    case WeatherTheme.normal:
      return ThemeApp.normalTheme;
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, WeatherTheme>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: _themeFromMode(themeState),
          home: HomeScreen(themeData: _themeFromMode(themeState)),
        );
      },
    );
  }
}
