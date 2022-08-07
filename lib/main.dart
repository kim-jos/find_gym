import 'package:find_gym/screens/pick_role.dart';
import 'package:find_gym/screens/user_gym_list.dart';
import 'package:find_gym/utils/themes.dart';
import 'package:find_gym/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'generated/l10n.dart';
import 'services/auth_service.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<SupabaseClient>(
      SupabaseClient(env('SUPABASE_URL'), env('SUPABASE_ANON_KEY')));
  Get.put<GetStorage>(GetStorage());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Themes.setStatusBarColors();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ko', 'KR'),
      ],
      home: const UserGymListScreen(),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  WrapperState createState() => WrapperState();
}

class WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    sessionCheck();
  }

  void sessionCheck() async {
    AuthService authService = AuthService();
    await GetStorage.init();
    final storage = Get.find<GetStorage>();
    final session = storage.read('user');
    if (session == null) {
      Get.to(const PickRoleScreen());
    } else {
      final response = await authService.recoverSession(session);
      await storage.write('user', response.data?.persistSessionString);
      Get.to(const UserGymListScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
