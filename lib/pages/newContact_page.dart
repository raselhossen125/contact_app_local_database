// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, unused_local_variable, avoid_print, unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:io';
import 'package:contact_app_local_database/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/contact_model.dart';
import '../untils/colors.dart';
import '../widget/back_btn.dart';
import '../widget/textField_widget.dart';

class NewContactPage extends StatefulWidget {
  static const routeName = '/new-contact';

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  late Size size;
  String? imagePath;
  String? dob;
  String genderGroupValue = '';
  ImageSource source = ImageSource.camera;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final websiteController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            BackBtn(
              cardColor: Colors.white,
              cardBtnColor: Colors.black,
              cardBtnIcon: Icon(Icons.arrow_back),
              cardBtnFunction: () {
                Navigator.of(context).pop();
              },
              titleColor: Colors.black,
              title: 'New Contact',
              actionIcon: Icons.save,
              actionIconColor: Colors.deepOrange,
              actionIconFunction: () {
                _saveButton();
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
                children: [
                  Container(
                    height: 172,
                    width: size.width,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            imagePath == null
                                ? Image.asset(
                                    'images/R.png',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(imagePath!),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    source = ImageSource.camera;
                                    _getImage();
                                  },
                                  icon: Icon(
                                    Icons.camera,
                                    color: Colors.deepOrange,
                                  ),
                                  label: Text(
                                    'Capture',
                                    style: TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    source = ImageSource.gallery;
                                    _getImage();
                                  },
                                  icon: Icon(
                                    Icons.photo,
                                    color: Colors.deepOrange,
                                  ),
                                  label: Text(
                                    'Gallery',
                                    style: TextStyle(color: Colors.deepOrange),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 110,
                    width: size.width,
                    child: Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Container(
                            width: size.width / 2 - 14.5,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: _showDatePickerDialog,
                                  child: Text(
                                    'Select Date of Birth',
                                  ),
                                ),
                                Chip(
                                  backgroundColor: appColor().cardColor,
                                  label: Text(
                                    dob == null ? "No date chosen!" : dob!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 1,
                            color: appColor().cardColor,
                          ),
                          Container(
                            width: size.width / 2 - 14.5,
                            child: Padding(
                              padding: EdgeInsets.only(right: 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Gender :",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Radio<String>(
                                          activeColor: appColor().cardColor,
                                          value: 'Male',
                                          groupValue: genderGroupValue,
                                          onChanged: (value) {
                                            setState(() {
                                              genderGroupValue =
                                                  value as String;
                                            });
                                          }),
                                      Text(
                                        'Male',
                                        style: TextStyle(
                                            color: appColor().cardColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Radio<String>(
                                          activeColor: appColor().cardColor,
                                          value: 'Female',
                                          groupValue: genderGroupValue,
                                          onChanged: (value) {
                                            setState(() {
                                              genderGroupValue =
                                                  value as String;
                                            });
                                          }),
                                      Text(
                                        'Female',
                                        style: TextStyle(
                                            color: appColor().cardColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFromFieldWidget(
                          controller: nameController,
                          prefixIcon: Icons.person,
                          hintText: 'Enter your name',
                        ),
                        SizedBox(height: 10),
                        TextFromFieldWidget(
                          controller: phoneController,
                          prefixIcon: Icons.phone,
                          hintText: 'Enter your phone number',
                        ),
                        SizedBox(height: 10),
                        TextFromFieldWidget(
                          controller: emailController,
                          prefixIcon: Icons.email,
                          hintText: 'Enter your email',
                        ),
                        SizedBox(height: 10),
                        TextFromFieldWidget(
                          controller: addressController,
                          prefixIcon: Icons.location_on,
                          hintText: 'Enter your address',
                        ),
                        SizedBox(height: 10),
                        TextFromFieldWidget(
                          controller: websiteController,
                          prefixIcon: Icons.web,
                          hintText: 'Enter your website url',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getImage() async {
    final selectedImage = await ImagePicker().pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        imagePath = selectedImage.path;
      });
    }
  }

  void _showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1922),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _saveButton() async{
    final contact = ContactModel(
      name: nameController.text,
      number: phoneController.text,
      email: emailController.text,
      address: addressController.text,
      dob: dob,
      gender: genderGroupValue,
      image: imagePath,
      website: websiteController.text,
    );
    print(contact.toString());
    final status = await Provider.of<ContactProvider>(context,listen: false).addNewContact(contact);
    if(status) {
      Navigator.of(context).pop();
    }
  }
}
