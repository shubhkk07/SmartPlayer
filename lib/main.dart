import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/add_remove_favourites/cubit/add_remove_favourites_cubit.dart';
import 'package:smartlisten/bloc/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:smartlisten/bloc/bloc_observer/bloc_observer.dart';
import 'package:smartlisten/bloc/fav_song/bloc/favsongs_bloc.dart';
import 'package:smartlisten/bloc/song_bloc/bloc/song_bloc.dart';
import 'package:smartlisten/theme/app_theme.dart';
import 'package:smartlisten/utils/firebase_options.dart';
import 'package:smartlisten/view/AuthenticationView/auth_view.dart';
import 'package:smartlisten/view/SongView/home.dart';
import 'bloc/audio_control/bloc/audio_control_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DefaultFirebaseOptions.initializeApp();

  Bloc.observer = CustomBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc()),
        BlocProvider(create: (context) => FavsongsBloc()),
        BlocProvider(create: (context) => AudioControlBloc()),
        BlocProvider(create: (context) => AddRemoveFavouritesCubit()),
        BlocProvider(create: (context) => SongBloc()..add(FetchNewSongs())),
      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Audio Cart',
          theme: AppTheme.lightTheme,
          home: Builder(builder: (context) {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              return const HomeView();
            }
            return const AuthView();
          })),
    );
  }
}
