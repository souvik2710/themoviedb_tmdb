// To parse this JSON data, do
//
//     final movieResultsModel = movieResultsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MovieResultsModel movieResultsModelFromJson(String str) => MovieResultsModel.fromJson(json.decode(str));

String movieResultsModelToJson(MovieResultsModel data) => json.encode(data.toJson());

class MovieResultsModel {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  MovieResultsModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResultsModel.fromJson(Map<String, dynamic> json) => MovieResultsModel(
    page: json["page"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  // final String? mediaType;
  // final List<int> genreIds;
  final double? popularity;
  // final DateTime? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    // required this.mediaType,
    // required this.genreIds,
    required this.popularity,
    // required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    id: json["id"],
    title: json["title"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    // mediaType: json["media_type"],
    // genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    popularity: json["popularity"]?.toDouble(),
    // releaseDate: DateTime.parse(json["release_date"]),
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "id": id,
    "title": title,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "poster_path": posterPath,
    // "media_type": mediaType,
    // "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "popularity": popularity,
    // "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
