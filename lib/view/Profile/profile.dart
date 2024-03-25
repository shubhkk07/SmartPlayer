import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/add_remove_favourites/cubit/add_remove_favourites_cubit.dart';
import 'package:smartlisten/bloc/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:smartlisten/bloc/fav_song/bloc/favsongs_bloc.dart';
import 'package:smartlisten/bloc/song_bloc/bloc/song_bloc.dart';
import 'package:smartlisten/view/favourite_song.dart/favourite_song.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var toggleVal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: ListTile(
                tileColor: Colors.white,
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text("Shubham", style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black)),
                subtitle: Text("shubhkk07@gmail.com")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          ListTile(
            tileColor: Color.fromARGB(255, 247, 247, 250),
            title: Text(
              'Dark Theme',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black.withOpacity(0.7)),
            ),
            leading: const Icon(
              Icons.color_lens_rounded,
              size: 30,
            ),
            trailing: SwitchTheme(
              data: SwitchThemeData(trackOutlineWidth: MaterialStateProperty.all(1)),
              child: Switch(
                  trackOutlineColor: MaterialStateProperty.all(Colors.black.withOpacity(0.4)),
                  value: toggleVal,
                  onChanged: (val) {
                    setState(() {
                      toggleVal = val;
                    });
                    //THEME Change
                  }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: Color.fromARGB(255, 247, 247, 250),
            title: Text(
              'Favourites Song',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black.withOpacity(0.7)),
            ),
            leading: const Icon(
              Icons.music_note_rounded,
              size: 30,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouriteSongs(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            tileColor: const Color.fromARGB(255, 247, 247, 250),
            title: Text(
              'Sign Out',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black.withOpacity(0.7)),
            ),
            leading: const Icon(
              Icons.power_settings_new_rounded,
              size: 30,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Icon(Icons.logout_rounded),
                      content: const Text('Do you want to sign out?'),
                      actions: [
                        ElevatedButton(
                            onPressed: () async {
                              context.read<AuthenticationBloc>().add(UserLoggedOut());
                            },
                            child: const Text('Yes')),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'))
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
