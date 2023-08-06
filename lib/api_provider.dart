
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'model/movie_results_model.dart';


final apiProvider = Provider((ref)=>ApiProvider(ref: ref) );

class ApiProvider{
Ref ref;
ApiProvider({required this.ref});
static String BASE_URL = 'https://api.themoviedb.org';
static String API_KEY = 'c5f91272e8db79e3deb27701f18d2894';

Future<MovieResultsModel> getNowPlaying() async{
  final response = await http.get(Uri.parse('$BASE_URL/3/movie/now_playing?api_key=$API_KEY&language=en-US'));
  final responseString = jsonDecode(response.body);
  if(response.statusCode==200){
    return MovieResultsModel.fromJson(responseString);
  }else {
    throw Exception('failed to load User details ');
  }
}
Future<MovieResultsModel> getTvShows() async{
  final response = await http.get(Uri.parse('$BASE_URL/3/tv/popular?api_key=$API_KEY&language=en-US'));
  final responseString = jsonDecode(response.body);
  if(response.statusCode==200) {
    return MovieResultsModel.fromJson(responseString);
  }else {
    throw Exception('failed to load User details ');
  }
}
Future<MovieResultsModel> getPopularMovies() async{
  final response = await http.get(Uri.parse('$BASE_URL/3/movie/top_rated?api_key=$API_KEY&language=en-US'));
  final responseString = jsonDecode(response.body);
  if(response.statusCode==200) {
    return MovieResultsModel.fromJson(responseString);
  }else {
    throw Exception('failed to load User details ');
  }
}
Future<MovieResultsModel> getMoviesTrending() async{
  final response = await http.get(Uri.parse('$BASE_URL/3/trending/movie/week?api_key=$API_KEY'));
  final responseString = jsonDecode(response.body);
  if(response.statusCode==200) {
  return MovieResultsModel.fromJson(responseString);
  }else {
    throw Exception('failed to load User details ');
  }
}

Future<Result?> getParticularMovieDetails(int movieID) async{
  debugPrint('ooo--- ${'$BASE_URL/3/movie/$movieID?api_key=$API_KEY&language=en-US'}');
  final response = await http.get(Uri.parse('$BASE_URL/3/movie/$movieID?api_key=$API_KEY&language=en-US'));
  final responseString = jsonDecode(response.body);
  debugPrint('yyy -- ${response.statusCode}');
  if(response.statusCode==200) {
  return Result.fromJson(responseString);
  }else {
    return null;
    throw Exception('failed to load User details ');
  }
}
// Future<MovieResultsModel> getParticularMovieCast(int movieID) async{
//   final response = await http.get(Uri.parse('$BASE_URL/3/movie/$movieID/credits?api_key=$API_KEY&language=en-US'));
//   final responseString = jsonDecode(response.body);
//   return MovieResultsModel.fromJson(responseString);
// }
}
