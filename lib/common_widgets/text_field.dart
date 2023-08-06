

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';

class NewCommonMainTextField extends StatefulWidget {
  final String labelTextPass;
  final TextEditingController? textEditingController;
  final Key? formKey;
  final bool? isEnable;
  final bool? isObscureText ;
  final bool? isTypePassword ;
  // final Function(String v)? onChanged;
  final Function? onChanged;
  final Icon? preFixIconPass;
  final List<TextInputFormatter>? inputFormattersPass;
  const NewCommonMainTextField({super.key, required this.labelTextPass, this.textEditingController,this.formKey, this.isEnable,this.onChanged, this.inputFormattersPass,this.isObscureText=false, this.preFixIconPass, this.isTypePassword=false});

  @override
  State<NewCommonMainTextField> createState() => _NewCommonMainTextFieldState();
}

class _NewCommonMainTextFieldState extends State<NewCommonMainTextField> {
  bool isValid = false;
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isValid?58:45,
      width: MediaQuery.of(context).size.width,
      //299
      child: Form(
        key: formKey,
        child: TextFormField(
          inputFormatters: widget.inputFormattersPass,
          focusNode:myFocusNode ,
          enabled: widget.isEnable,
          cursorColor: ConstantColors.darkTextColor,
          controller: widget.textEditingController,

          // onChanged: widget.onChanged?.call(widget.textEditingController!.text),
          onChanged: (String val){
            if (widget.onChanged != null) {
              widget.onChanged!(val);
            }
          },
          obscureText: !isPasswordVisible && widget.isTypePassword!,
          autofocus: false,
          validator: (value) {
            return null;
          },
          style: TextStyle(color: widget.isEnable == false?const Color(0xff737373).withOpacity(0.5):const Color(0xff737373),fontWeight: FontWeight.w600,fontSize: 16,),
          // textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            // hintText: "E-mail",
              prefixIcon:widget.preFixIconPass,
              prefixIconColor: ConstantColors.mediumTextColor,
              suffixIconColor: ConstantColors.mediumTextColor,
              suffixIcon : (widget.isTypePassword! && !isPasswordVisible)?
              InkWell(
                onTap: (){
                  setState(() {
                    isPasswordVisible = true;
                    // widget.isObscureText = false;
                  });

                },
                  child: const Icon(Icons.visibility_off,size: 20,)
              ):
              (widget.isTypePassword! && isPasswordVisible)?InkWell(
                onTap: (){
                  setState(() {
                    isPasswordVisible = false;
                    // widget.isObscureText = false;
                  });
                },
                  child: const Icon(Icons.visibility,size: 20,)
              ):null,
              isDense: true,
              contentPadding: const EdgeInsets.all(10),
              labelText: widget.labelTextPass,
              // hintStyle: TextStyle(color: Color.fromRGBO(221, 206, 189, 1)),
              // floatingLabelStyle: TextStyle(color: isValid?Color(0xffDC0416):myFocusNode.hasFocus?Color(0xFF72C6B1):Color(0xff737373).withOpacity(0.7),fontSize: 12,fontWeight: FontWeight.w500),
              labelStyle: const TextStyle(color:Color(0xff737373),fontWeight: FontWeight.w500,fontSize: 16,),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Color(0xff737373)),
                borderRadius: BorderRadius.circular(6),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(width: 1, color: widget.isEnable == false?const Color(0xff737373).withOpacity(0.5):const Color(0xff737373)),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color:ConstantColors.mediumTextColor,
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(6)
              ),

              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.isEnable == false?const Color(0xff737373).withOpacity(0.5):const Color(0xff737373),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6)
              )
          ),
        ),
      ),
    );
  }
}
