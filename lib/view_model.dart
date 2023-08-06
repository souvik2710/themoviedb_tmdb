








import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/profile/bookmark_model.dart';

import 'api_provider.dart';
import 'model/movie_results_model.dart';

final movieViewModel = ChangeNotifierProvider<MovieViewModel>((ref) => MovieViewModel(ref: ref));

class MovieViewModel extends ChangeNotifier{
   Ref ref;
   MovieViewModel({required this.ref});
   MovieResultsModel? mMoviesTrending;
   MovieResultsModel? mNowPlaying;
   MovieResultsModel? mTvShows;
   MovieResultsModel? mPopularMovies;
   bool isLoading = false;
   bool isLoadingMoviesTrending = false;
   bool isLoadingNowPlaying = false;
   bool isLoadingGetTvShows = false;
   bool isLoadingGetPopularMovies = false;

   BookMarkFirebaseModel? bookMarkFirebaseModel;
   List<int> bookmarkIntList =[];
   List<Result> bookmarkMovieResultList =[];

   Future<void> vmGetMoviesTrending()async{
     try{
       isLoadingMoviesTrending = true;
       notifyListeners();
       mMoviesTrending = await ref.read(apiProvider).getMoviesTrending();

     }catch(e){
       debugPrint("ERROR -> $e");

     }finally{
       isLoadingMoviesTrending = false;
       notifyListeners();
     }
   }
   
   Future<void> vmGetNowPlaying()async{
     try{
       isLoadingNowPlaying = true;
       notifyListeners();
       mNowPlaying = await ref.read(apiProvider).getNowPlaying();

     }catch(e){
       debugPrint("ERROR -> $e");

     }finally{
       isLoadingNowPlaying = false;
       notifyListeners();
     }
   }
   Future<void> vmGetTvShows()async{
     try{
       isLoadingGetTvShows = true;
       notifyListeners();
       mTvShows = await ref.read(apiProvider).getTvShows();

     }catch(e){
       debugPrint("ERROR -> $e");

     }finally{
       isLoadingGetTvShows = false;
       notifyListeners();
     }
   }
   Future<void> vmGetPopularMovies()async{
     try{
       isLoadingGetPopularMovies = true;
       notifyListeners();
       mPopularMovies = await ref.read(apiProvider).getPopularMovies();

     }catch(e){
       debugPrint("ERROR -> $e");

     }finally{
       isLoadingGetPopularMovies = false;
       notifyListeners();
     }
   }

   Future<void> vmGetParticularDetails()async{
     try{
       isLoadingGetPopularMovies = true;
       notifyListeners();
       mPopularMovies = await ref.read(apiProvider).getPopularMovies();

     }catch(e){
       debugPrint("ERROR -> $e");

     }finally{
       isLoadingGetPopularMovies = false;
       notifyListeners();
     }
   }
   Future<void> vmGetParticularCast()async{
     try{
       isLoadingGetPopularMovies = true;
       notifyListeners();
       mPopularMovies = await ref.read(apiProvider).getPopularMovies();

     }catch(e){
       debugPrint("ERROR -> $e");

     }finally{
       isLoadingGetPopularMovies = false;
       notifyListeners();
     }
   }

   Future<void> signUpFirebase( String emailAddress,String password, String name)async{
     try {
       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailAddress,
         password: password,
       );
       debugPrint('success --> ${credential.user?.email??''}');
       final userFetched = credential.user;
       debugPrint(userFetched?.uid);
       if(userFetched!=null){
         await updateUserNameFireBase(user: userFetched, updateName: '$name');
       }
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         debugPrint('The password provided is too weak.');
       } else if (e.code == 'email-already-in-use') {
         debugPrint('The account already exists for that email.');
       }
     } catch (e) {
       debugPrint('$e');
     }
   }

   Future<void> signInFirebase( String emailAddress,String password)async{
     try {
       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: emailAddress,
           password: password,
       );
       debugPrint('success --> ${credential.user?.email??''}');
       final userFetched = credential.user;
       debugPrint(userFetched?.uid);

     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         debugPrint('No user found for that email.');
       } else if (e.code == 'wrong-password') {
         debugPrint('Wrong password provided for that user.');
       }
     }
   }

   Future<void> signOut()async{
     try {
       await FirebaseAuth.instance.signOut();
     } on FirebaseAuthException catch (e) {
         debugPrint('FAILED ---> ${e.code}');

     }
   }
   Future<void> updateUserNameFireBase({required User user, required String updateName})async{
     try {
       await user.updateDisplayName("$updateName");
     } on FirebaseAuthException catch (e) {
       debugPrint('FAILED ---> ${e.code}');

     }
   }


   Future<void> updateUserCloudF({required List<int> bookmarkList})async{
     try {
       final db =  FirebaseFirestore.instance;
       final movieUser = db.collection("movieuser");
       final userMain =  FirebaseAuth.instance.currentUser;
       if (userMain != null) {
         debugPrint(FirebaseAuth.instance.currentUser?.uid);
         final updateData = <String, dynamic>{
           "email": "${userMain.email}",
           "uid": userMain.uid,
           "bookmarks": bookmarkList,
         };
         await movieUser.doc(userMain.uid).set(updateData);
         debugPrint('data successfully added');

       }
     } on Error catch (e) {
       debugPrint('FAILED ---> ${e}');

     }
   }
   Future<void> updateUserOnlyBookMarkCloudF({required List<int> bookmarkList})async{
     try {
       final db =  FirebaseFirestore.instance;
       final movieUser = db.collection("movieuser");
       final userMain =  FirebaseAuth.instance.currentUser;
       if (userMain != null) {
         debugPrint(FirebaseAuth.instance.currentUser?.uid);
         final updateData = <String, dynamic>{
           "bookmarks": bookmarkList,
         };
         await movieUser.doc(userMain.uid).update(updateData);
         debugPrint('bookmark data UPDATED added');

       }
     } on Error catch (e) {
       debugPrint('FAILED ---> ${e}');

     }
   }

   Future<void> getUserCloudF()async{
     try {
       final db =  FirebaseFirestore.instance;
       final userMain =  FirebaseAuth.instance.currentUser;
       if (userMain != null) {
         final docRef = db.collection("movieuser").doc(userMain.uid);
        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot= await docRef.get();
         final data =  documentSnapshot.data() as Map<String, dynamic>;
         debugPrint('uuuu--->$data');
         bookMarkFirebaseModel = BookMarkFirebaseModel.fromJson(data);
         bookmarkIntList = bookMarkFirebaseModel?.bookmarks??[];
         debugPrint('email o --->${bookMarkFirebaseModel?.email??''}');
       }
     } on Error catch (e) {
       debugPrint('FAILED ---> ${e}');

     }
   }

   Future<void> addBookMark(int movieID, Result resultPass)async{
     try {
       int i1 = bookmarkIntList.indexWhere((element) => element==movieID);
       if(i1==-1){
         bookmarkIntList.add(movieID);
       }
       int i2 = bookmarkMovieResultList.indexWhere((element) => element.id==movieID);
       if(i2==-1){
         bookmarkMovieResultList.add(resultPass);
       }
       debugPrint('listbookmark - ${bookmarkIntList}');
       bookmarkMovieResultList.forEach((element) {
       });
       await updateUserOnlyBookMarkCloudF(bookmarkList:bookmarkIntList);
       notifyListeners();

     } on Error catch (e) {
       debugPrint('FAILED ---> ${e}');

     }
   }
   Future<void> removeBookMark(int movieID)async{
     try {
       int i = bookmarkIntList.indexWhere((element) => element==movieID);
       if(i!=-1){
         bookmarkIntList.remove(movieID);
         bookmarkMovieResultList.removeWhere((element) => element.id==movieID);
       }
       debugPrint('listbookmark - ${bookmarkIntList}');
       await updateUserOnlyBookMarkCloudF(bookmarkList:bookmarkIntList);
       notifyListeners();
     } on Error catch (e) {
       debugPrint('FAILED ---> ${e}');

     }
   }

   bool isFavorite(int movieID){
     print(bookmarkIntList);
       int i = bookmarkIntList.indexWhere((element) => element==movieID);
       if(i==-1){
        return false;
      }else{
         return true;
       }
       // notifyListeners();
   }

   Future<void> vmGetParticularDetailsBookMarkArray()async{
     try{
       isLoading = true;
       notifyListeners();
       // debugPrint('listbookmark - ${bookmarkIntList}');
       bookmarkMovieResultList.clear();
       for(int b in bookmarkIntList){
         // debugPrint('pp-->$b');
         final Result? result = await ref.read(apiProvider).getParticularMovieDetails(b);
         if(result!=null){
           bookmarkMovieResultList.add(result);
         }

          // bookmarkMovieResultList.toSet().toList();
       }
       // mPopularMovies = await ref.read(apiProvider).getPopularMovies();
     }catch(e){
       debugPrint("ERROR2 -> $e");

     }finally{
       isLoading = false;
       notifyListeners();
     }
   }

}

// await ref.read(movieViewModel).updateUserCloudF( bookmarkList: [3,5]);
