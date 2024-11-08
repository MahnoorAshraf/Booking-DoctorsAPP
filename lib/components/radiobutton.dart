import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'textstyles.dart';

class RadioButtonsExample extends StatefulWidget {
  final String? selectedOption;
  final Function(String) onOptionChanged;

  RadioButtonsExample({
    this.selectedOption, 
    required this.onOptionChanged,
  });

  @override
  State<RadioButtonsExample> createState() => _RadioButtonsExampleState();
}

class _RadioButtonsExampleState extends State<RadioButtonsExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 8,
                top: 7,
                bottom: 10,
              ),
              child: Text(
                'Select Consultation type',
                style: AppWidget.specsFieldstyle(),
              ),
            ),
          ),
          RadioListTile(
            title: Text('Standard Consultation(Weekday)',style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),),
            value: 'Standard consultation weekday',
            groupValue: widget.selectedOption,
            onChanged: (value) {
              widget.onOptionChanged(value.toString());
            },
          ),
           RadioListTile(
            title: Text('Standard Consultation(Weekend)',style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),),
            value: 'Standard consultation weekend',
            groupValue: widget.selectedOption,
            onChanged: (value) {
              widget.onOptionChanged(value.toString());
            },
          ),
          RadioListTile(
            title: Text('Long Consultation(Weekday)',style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),),
            value: 'Long consultation weekday',
            groupValue: widget.selectedOption,
            onChanged: (value) {
              widget.onOptionChanged(value.toString());
            },
          ),
          RadioListTile(
            title: Text('Long Consultation(Weekend)',style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),),
            value: 'Long consultation weekend',
            groupValue: widget.selectedOption,
            onChanged: (value) {
              widget.onOptionChanged(value.toString());
            },
          ),
          
         
        ],
      ),
    );
  }
}
