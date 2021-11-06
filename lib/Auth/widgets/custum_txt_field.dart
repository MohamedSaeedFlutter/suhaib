import 'package:flutter/material.dart';

class CustumTextField extends StatelessWidget {
   CustumTextField({@required this.hintTxt, @required this.txtType, this.obscureTxt,
      @required this.nameController, this.onClick ,this.vald});
String hintTxt = "";
TextInputType txtType ;
String vald = "";
bool obscureTxt;
final TextEditingController nameController;
Function onClick ;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textAlign: TextAlign.right,
        onSaved: onClick,
        validator: (value) {
          if(value.isEmpty){
            return vald;
          }return null;
        },
        controller: nameController,
        obscureText: obscureTxt,
        decoration:
        InputDecoration(
          // label: Text(hintTxt),
          hintText: hintTxt,
          hintStyle: TextStyle(inherit: true),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide(
                  color: Color.fromRGBO(238, 239, 243,1),
              style: BorderStyle.none)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
                color: Color.fromRGBO(238, 239, 243,1)),
          ),
          fillColor: Color.fromRGBO(238, 239, 243,1),
        ),
        keyboardType: txtType,
        style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400),

      ),
    );
  }
}
