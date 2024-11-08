import 'dart:async';
// import 'dart:convert';
import 'package:clientwork/components/appcolors.dart';
import 'package:clientwork/components/radiobutton.dart';
import 'package:clientwork/components/radiobutton2.dart';
import 'package:clientwork/screens/form.dart';
import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;
import '../components/button.dart';
import '../components/textstyles.dart';
import '../routes/routenames.dart';

class paymentmethod extends StatefulWidget {
  final Map<String, dynamic> doctorDetails;

  const paymentmethod({Key? key, required this.doctorDetails})
      : super(key: key);

  @override
  State<paymentmethod> createState() => _PaymentMethodState();
}

class Doctor {
  final int id;

  Doctor({
    required this.id,
  });

  factory Doctor.fromId(int id) {
    return Doctor(id: id);
  }
}

class _PaymentMethodState extends State<paymentmethod> {
  String firstName = '';
  String lastName = '';
  String email = '';
  String phone = '';
  String consultationReason = '';
  bool loading = false;

  DateTime? selectedDate;
  Doctor? doctor;
  int? doctorId;
  Timer? _debounce;
  String selectedAppointmentType = '';
  String selectedOption = '';

  final GlobalKey<FieldsState> fieldsKey = GlobalKey<FieldsState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController consultationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    doctorId = widget.doctorDetails['doctor_id'];
    selectedDate = DateTime.now();
    print('Selected Doctor ID: $doctorId');
  }

  void updateFormFieldValues({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String consultationReason,
  }) {
    setState(() {
      this.firstName = firstName;
      this.lastName = lastName;
      this.email = email;
      this.phone = phone;
      this.consultationReason = consultationReason;
    });
  }

Future<void> submitForm() async {
  setState(() {
    loading = true; // Show loading indicator
  });

  try {
    // Validate if doctorId is selected
    if (doctorId == null) {
      showErrorToast('Please select a doctor.');
      return;
    }

    // Validate if date is selected
    if (selectedDate == null) {
      showErrorToast('Please select a date.');
      return;
    }

    // Validate if appointment type is selected
    if (selectedAppointmentType.isEmpty) {
      showErrorToast('Please fill in empty fiels.');
      return;
    }

    // Validate if consultation type is selected
    if (selectedOption.isEmpty) {
      showErrorToast('Please select a consultation type.');
      return;
    }

    // Ensure all required fields are filled
  

    // Send data to the server only if all validations pass
    await fieldsKey.currentState?.sendDataToServer(doctorId!);

    // If the operation is successful, show a success message
    showSuccessToast('Appointment created successfully');
    Navigator.pushNamed(context, Routenames.bottomnavbar);
  } catch (e) {
    print('Error Occurred: $e');
    showErrorToast('Failed to create appointment.');
  } finally {
    setState(() {
      loading = false; // Hide loading indicator
    });
  }
}




  void handleOptionChange(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  void handleAppointmentTypeChange(String? newAppointmentType) {
    setState(() {
      selectedAppointmentType = newAppointmentType!;
      print('Selected Appointment Type: $selectedAppointmentType');
    });
  }

  void _onFormSubmit() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
       setState(() {
      loading = true;
    });
      submitForm();
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.logoclr,
        title: Text(
          'Book Appointment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Fill the following form',
                  style: AppWidget.BTextFieldstyle(),
                ),
              ),
              fields(
                key: fieldsKey,
                doctorDetails: widget.doctorDetails,
                selectedConsultationType: selectedOption,
                doctorId: doctorId!,
                selectedDate: selectedDate,
                selectedAppointmentType: selectedAppointmentType,
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                emailController: emailController,
                phoneController: phoneController,
                consultationController: consultationController,
                updateFormFieldValues: updateFormFieldValues,
              ),
              DateSelectField(onSelect: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              }),
              RadioButtonsExample(
                selectedOption: selectedOption,
                onOptionChanged: handleOptionChange,
              ),
              SizedBox(height: 10),
              appointment(
                selectedOption: selectedAppointmentType,
                onChanged: handleAppointmentTypeChange,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomCenter,
                
                child: Containers(
                  loading: loading, 
                  clr: AppColors.logoclr,
                  txt: 'Submit',
                  onTap: _onFormSubmit,
                 
                ),
              ),
                if (loading)
            Center(
              child: CircularProgressIndicator(), // Show loading indicator
            ),
            ],
          ),
          
        ),
      ),
    );
  }
 void showErrorToast(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ),
  );
}

void showSuccessToast(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ),
  );
}}
