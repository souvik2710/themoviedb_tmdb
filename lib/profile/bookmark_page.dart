


import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/common_widgets/card_custom_movie.dart';
import 'package:themoviedb_tmdb/common_widgets/text_heading.dart';
import 'package:themoviedb_tmdb/model/movie_results_model.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';
import 'package:themoviedb_tmdb/view_model.dart';

class BookMarkPage extends HookConsumerWidget {
  static String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final List<Result> listOfMovieBookMarks = ref.watch(movieViewModel).bookmarkMovieResultList;
    return  Scaffold(
      appBar: AppBar(title: const Text('Bookmark List',style: TextStyle(color: ConstantColors.darkTextColor,fontSize: 16),),
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
            child: const Icon(Icons.arrow_back_ios_new_sharp,color: ConstantColors.darkTextColor,)),
        elevation: 3,
        backgroundColor: Colors.white,
      ),
      body:   SafeArea(
        child: (ref.watch(movieViewModel).bookmarkIntList.length)==0?const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.bookmark, color: ConstantColors.highlightedColor,size: 46,),
            MediumSizedBoxCustom(),
            Align(
              alignment: Alignment.center,
                child: Text('Bookmark List is Empty',style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,)),
            MediumSizedBoxCustom(),
            Text('After bookmarking moves and series, they are \n displayed here',style: TextStyle(fontSize: 12,color: Colors.grey, ),textAlign: TextAlign.center,),


          ],
        ):Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
          GridView.builder(
            itemCount: listOfMovieBookMarks.length,
            itemBuilder: (context, index) => CardCustomMovie(movieName: '${listOfMovieBookMarks[index].title}', duration: '',
              imageUrl: '$BASE_IMAGE_URL/${listOfMovieBookMarks[index].posterPath}',
              rating: listOfMovieBookMarks[index].voteAverage?.toStringAsFixed(2)??'0', entireMovie: listOfMovieBookMarks[index],),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
          )
        ),
      ),
    );
  }
}
