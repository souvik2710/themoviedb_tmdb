


import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/model/movie_results_model.dart';
import 'package:themoviedb_tmdb/movie/view.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';
import 'package:themoviedb_tmdb/view_model.dart';

class CardCustomMovie extends HookConsumerWidget {
   const CardCustomMovie({
    required this.movieName,
     required this.duration,
     required this.imageUrl,
     required this.rating,
     required this.entireMovie,
     super.key,
  });
   final Result entireMovie;
   final String movieName;
   final String imageUrl;
   final String duration;
   final String rating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isFavoriteLocal = useState(false);
    final ValueNotifier<bool> isFirst = useState(true);
    if(isFirst.value){
      isFavoriteLocal.value = (ref.read(movieViewModel).isFavorite(entireMovie.id!))?true:false;
      isFirst.value =false;
    }

    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SingleMovieDetails(movieResult: entireMovie,)));
          },
          child: Stack(
            children: [
              Container(
                  height: 200,
                  width:150,
                  // padding: const EdgeInsets.only(left:10.0,top:15.0,right:10.0,bottom: 0.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:NetworkImage(imageUrl),
                      fit:BoxFit.fill,
                    ),
                    // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderRadius: BorderRadius.circular(10.0),
                  )

              ),
              Positioned(
                  bottom: 8,
                  right: 8,
                  child: InkWell(
                    onTap: ()async{
                     if(ref.read(movieViewModel).isFavorite(entireMovie.id!)){
                      await  ref.read(movieViewModel).removeBookMark(entireMovie.id!);
                     }else{
                       await ref.read(movieViewModel).addBookMark(entireMovie.id!, entireMovie);
                     }
                     isFavoriteLocal.value =! isFavoriteLocal.value;

                    },
                      child: (ref.read(movieViewModel).isFavorite(entireMovie.id!))?Icon(Icons.favorite,color: ConstantColors.highlightedColor,):Icon(Icons.favorite,color: Colors.white,))),
            ],
          ),
        ),
        Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movieName,maxLines:1,style: TextStyle(),),
              Row(
                children: [
                  Text(duration),
                  Text(rating),

                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}