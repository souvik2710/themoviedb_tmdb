

// To parse this JSON data, do
//
//     final bookMarkFirebaseModel = bookMarkFirebaseModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BookMarkFirebaseModel bookMarkFirebaseModelFromJson(String str) => BookMarkFirebaseModel.fromJson(json.decode(str));

String bookMarkFirebaseModelToJson(BookMarkFirebaseModel data) => json.encode(data.toJson());

class BookMarkFirebaseModel {
  final String email;
  final String uid;
  final List<int> bookmarks;

  BookMarkFirebaseModel({
    required this.email,
    required this.uid,
    required this.bookmarks,
  });

  factory BookMarkFirebaseModel.fromJson(Map<String, dynamic> json) => BookMarkFirebaseModel(
    email: json["email"],
    uid: json["uid"],
    bookmarks: List<int>.from(json["bookmarks"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "uid": uid,
    "bookmarks": List<dynamic>.from(bookmarks.map((x) => x)),
  };
}
