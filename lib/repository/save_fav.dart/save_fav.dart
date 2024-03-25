import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:smartlisten/model/song_model.dart';

class FavSongsRepo {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("Favourites").doc(FirebaseAuth.instance.currentUser?.uid).collection("tracks");

  Future<void> addToFavouriteSongs(SongModel songModel) async {
    try {
      await _collectionReference.doc(songModel.trackId.toString()).set(songModel.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> removeFromFavouriteSongs(SongModel songModel) async {
    try {
      await _collectionReference.doc(songModel.trackId.toString()).delete();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<SongModel>> getFavouriteSongsByUser() async {
    try {
      final data = _collectionReference.withConverter<SongModel>(
          fromFirestore: (snapshot, _) => SongModel.fromJson(snapshot.data()!), toFirestore: (model, _) => model.toJson());

      List<SongModel> favSongs = [];

      favSongs = await data.get().then((value) => value.docs.map((e) => e.data()).toList());

      return favSongs;
    } catch (e) {
      throw e.toString();
    }
  }

  Future checkSongIsFavourite(SongModel songModel) async {
    DocumentReference docRef = _collectionReference.doc(songModel.trackId.toString());
    final doc = await docRef.get();
    if (doc.exists) {
      return true;
    }
    return false;
  }
}
