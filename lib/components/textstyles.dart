import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppWidget{
  static TextStyle BoldTextFieldstyle(){
 return GoogleFonts.poppins(
                      color: Colors.black, fontSize: 15,
                     
                       fontWeight: FontWeight.normal);
}
 static TextStyle BTextFieldstyle(){
 return GoogleFonts.poppins(
                      color: Colors.black, fontSize: 22,
                    
                       fontWeight: FontWeight.normal);
}
static TextStyle TextFieldstyle(){
 return GoogleFonts.poppins(
                      color: Colors.black, fontSize: 18,
                    
                       fontWeight: FontWeight.w600);
}
static TextStyle LightTextFieldstyle(){
 return TextStyle(
                      color: Colors.white, fontSize: 18,
                      fontFamily: 'Poppins',
                       fontWeight: FontWeight.w300);
}


  static TextStyle specsFieldstyle(){
 return GoogleFonts.poppins(
                      color: Colors.black, fontSize: 22,
                    
                       fontWeight: FontWeight.normal);}

                       
                       
                    }