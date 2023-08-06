import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/authencation/sign_up.dart';

import 'firebase_options.dart';
import 'main_page/bottom_navigation_bar.dart';
import 'main_page/view.dart';
late final FirebaseAuth auth;
late final FirebaseApp app;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Disable persistence on web platforms. Must be called on initialization:
  // auth = FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.NONE);
// To change it after initialization, use `setPersistence()`:
//   await auth.setPersistence(Persistence.LOCAL);


  // We store the app and auth to make testing with a named instance easier.
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  runApp( const ProviderScope(
      overrides: [
      ],
      child: MyApp(

      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      showSemanticsDebugger: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.orange,
            // statusBarIconBrightness: Brightness.dark,
            //statusBarBrightness: Brightness.light,
          ),

          //color:Colors.orange
        ),

      ),
          // home:  BottomNav(),
      home: StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            // debugPrint('rrr ${snapshot.data?.displayName??''}');
            return  BottomNav();
          }else{
            return  SignUpPage();
          }

        }
      ),
    );
  }
}

