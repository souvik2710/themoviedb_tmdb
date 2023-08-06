



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/common_widgets/linear_custom_bar.dart';
import 'package:themoviedb_tmdb/profile/bookmark_page.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';
import 'package:themoviedb_tmdb/view_model.dart';

import '../common_widgets/text_heading.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (FirebaseAuth.instance.currentUser != null) {
      debugPrint(FirebaseAuth.instance.currentUser?.uid);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: ConstantColors.highlightedColor,
                      backgroundImage:NetworkImage('https://img.mensxp.com/media/content/2016/Apr/best-mens-sunglasses-for-summer-800x420-1460547079.jpg'),
                      radius: 45,

                    ),
                    const SizedBox(width: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(FirebaseAuth.instance.currentUser?.displayName??'',style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                        Text(FirebaseAuth.instance.currentUser?.email??'',style: const TextStyle(color: ConstantColors.lightTextColor,)),
                    ],),
                  ],
                ),
                const MediumSizedBoxCustom(),
                const TextMovieHeadingWidget(headingText: 'Your Activities',),
                const MediumSizedBoxCustom(),
                InkWell(
                  onTap: ()async{
                    await ref.read(movieViewModel).vmGetParticularDetailsBookMarkArray();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookMarkPage()));
                  },
                    child:  LinearCustomBar(headingTitle: 'Bookmark List',count: ref.watch(movieViewModel).bookmarkIntList.length, iconDataPass: Icons.bookmark,)),
                const MediumSizedBoxCustom(),
                const LinearCustomBar(headingTitle: 'Reviews',count: 24, iconDataPass: Icons.chat_bubble,), 
                const MediumSizedBoxCustom(),
                const LinearCustomBar(headingTitle: 'History',isArrow: true, iconDataPass: Icons.play_arrow,), 
                const MediumSizedBoxCustom(),
                const TextMovieHeadingWidget(headingText: 'Theme',),
                const MediumSizedBoxCustom(),
                const LinearCustomBar(headingTitle: 'Switch to Dark Theme',isArrow: true, iconDataPass: Icons.nightlight,),
                const MediumSizedBoxCustom(),
                const TextMovieHeadingWidget(headingText: 'Account',),
                const MediumSizedBoxCustom(),
                const LinearCustomBar(headingTitle: 'Settings',isArrow: true, iconDataPass: Icons.settings,), 
                const MediumSizedBoxCustom(),
                const LinearCustomBar(headingTitle: 'My Subscription Plan',isArrow: true, iconDataPass: Icons.monetization_on,), 
                const MediumSizedBoxCustom(),
                const LinearCustomBar(headingTitle: 'Change Password',isArrow: true, iconDataPass: Icons.lock,), 
                const MediumSizedBoxCustom(),
                InkWell(
                  onTap: ()
                    async{
                        await ref.read(movieViewModel).signOut();
                        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Logout Successfully')));
                      // await ref.read(movieViewModel).getUserCloudF();
                      // await ref.read(movieViewModel).updateUserOnlyBookMarkCloudF( bookmarkList: [3]);


                    },
                    child: const LinearCustomBar(headingTitle: 'Logout',isArrow: true, iconDataPass: Icons.logout_sharp,isLogout: true,)),
                const MediumSizedBoxCustom(),



              ],
            ),
          ),
        ),
      ),
    );
  }
}

