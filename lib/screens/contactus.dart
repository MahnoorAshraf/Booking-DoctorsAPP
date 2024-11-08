import 'package:clientwork/components/appcolors.dart';
import 'package:clientwork/components/button.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/routenames.dart';

class contactus extends StatefulWidget {
  const contactus({super.key});

  @override
  State<contactus> createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
   
     
      appBar: AppBar(
    backgroundColor: AppColors.logoclr,
    title: Text('Contact us',style: TextStyle(color: Colors.white),),
    centerTitle: true,
    leading: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routenames.bottomnavbar);
      },
      child: Icon(
        Icons.arrow_back_ios, 
        color: Colors.white,
      ),
    ),),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Get in Touch',
                    style: GoogleFonts.bebasNeue(
                        color: Colors.black,
                        fontSize: 30,
                        
                        )),
              )),
              Container(
                height: screenHeight * 0.26,
                width: screenWidth *0.9,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
               color:AppColors.bgcolor,
                border: Border.all(color:AppColors.logoclr,width: 1.5)),
        
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.clock),
                            SizedBox(width: 10),
                            Text('Opening Hours',
                                style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                                    
                          ],
                        ),
                      ),
                              SizedBox(height: 10),
              Text(
                'Mon–Fri: 8am–6:30pm',
                style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
              ),
              Text('Sat: 9am–5pm',  style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),),
              Text('Sun: 9am–4pm', style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),),
                    ],
                  )),
              SizedBox(height:10),
              Container(

                  height: screenHeight * 0.32,
                width: screenWidth *0.9,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                 color: AppColors.bgcolor,
                border: Border.all(color: AppColors.logoclr,width: 1.5)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.mapPin),
                          SizedBox(width: 6),
                                                  Text('Address',
                              style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),),
                        ],
                      ),
                    ),
                            SizedBox(height: 10),
              Text(
                'Booking Doctor App,',
                style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
              ),
              Text('54 Nullarbor Avenue\nFranklin, ACT 2913.',
                   style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),),
                 
             
              Text('Tel: (+61) 02 6253 8663',  style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),),
              Text('contact@franklingeneralpractice.com.au',  style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),),
                  ],
                ),
              ),
              SizedBox(height: 5),
             Text('Get Appointment',
             style: GoogleFonts.bebasNeue(color: Colors.black,fontSize: 24),),
              SizedBox(height:5),
            Containers(clr:AppColors.logoclr, txt: 'Book Appointment', onTap: (){
              Navigator.pushNamed(context, Routenames.doctorsdata);
            }),
              
       ] ),
      ),
    ));
  }
}
