




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/authencation/sign_up.dart';
import 'package:themoviedb_tmdb/common_widgets/text_field.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';
import 'package:themoviedb_tmdb/view_model.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final eEmailController = useTextEditingController();
    final ePasswordController = useTextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.092,),
                    const Text('Sign In',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.032,),
                    const Text('Enter your user information below or continue \n with one of your sociol acoounts',textAlign:TextAlign.center,
                      style: TextStyle(color: ConstantColors.mediumTextColor),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.032,),
                    NewCommonMainTextField(labelTextPass: 'E-mail',textEditingController: eEmailController,
                      preFixIconPass: const Icon(Icons.mail),
                      inputFormattersPass: [
                        LengthLimitingTextInputFormatter(254)
                      ],
                    ),

                    SizedBox(height:MediaQuery.of(context).size.height*0.032,),
                    NewCommonMainTextField(labelTextPass: 'Password',textEditingController: ePasswordController,
                      preFixIconPass: const Icon(Icons.lock),
                      isObscureText: true,
                      isTypePassword: true,
                      inputFormattersPass: [
                        LengthLimitingTextInputFormatter(254)
                      ],
                    ),

                    SizedBox(height:MediaQuery.of(context).size.height*0.032,),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password?',
                        style: TextStyle(fontSize: 12,color: Colors.grey),
                      ),
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.022,),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:ConstantColors.highlightedColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          minimumSize: Size(MediaQuery.of(context).size.width,50),
                          // minimumSize:  Size(widget.width! == null?299:widget.width!,widget.height! == null?47:widget.height!),

                        ),
                        onPressed: ()async{
                          await  ref.read(movieViewModel).signInFirebase(eEmailController.text, ePasswordController.text);
                          await ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Signed In Successfully')));


                        },
                        child: const Text('Sign in',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.022,),

                    // const SizedBox(height: 20,),

                    RichText(text:  TextSpan(
                      style: const TextStyle(fontSize: 16, color: ConstantColors.mediumTextColor),
                      text: 'Don\'t have an account? ',
                      children: [
                        WidgetSpan(child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignUpPage()));
                          },
                          child: const Text('Sign up',style: TextStyle(color: ConstantColors.highlightedColor),),
                        )),
                      ],
                    ),),

                    // Text('Already have an account: Sign in',style: TextStyle(fontSize: 14),),


                  ],
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
