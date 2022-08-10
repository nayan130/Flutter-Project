import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_system_management/model/member_model.dart';
import 'package:meal_system_management/provider/add_member_provider.dart';
import 'package:provider/provider.dart';

class AddMemberPage extends StatefulWidget {
  static const String routeName = '/add_member';

  const AddMemberPage({Key? key}) : super(key: key);

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  late bool _passwordVisible = false;
  late String _selectedMember;
  final _userPasswordController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _userNameController = TextEditingController();
  String? _imagePath;
  late ImageSource imageSource;
  //File? _pickedImage;

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _userPasswordController.dispose();
    _userNameController.dispose();
    _userPhoneController.dispose();
    //_selectedMember.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _selectedMember = ModalRoute.of(context)!.settings.arguments as String;
    print(_selectedMember);

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _pickedImages() async {
    final selectedImage = await ImagePicker().pickImage(source: imageSource);
    //final _pickedImageFile = File(selectedImage!.path);
    if (selectedImage != null) {
      setState(() {
        _imagePath = selectedImage.path;
        //_pickedImage = _pickedImageFile;
      });
    }
    Navigator.pop(context);
  }

  void _removed() {
    setState(() {
      _imagePath = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Add Members'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/bg_login6.jpg',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor:
                                  const Color.fromARGB(255, 179, 171, 171),
                              child: _imagePath == null
                                  ? CircleAvatar(
                                      radius: 60.0,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: Image.asset(
                                              'images/login_place_holder.png')),
                                    )
                                  : CircleAvatar(
                                      radius: 66,
                                      backgroundImage:
                                          FileImage(File(_imagePath!)),
                                    ),
                            ),
                          ),
                          Positioned(
                              bottom: 12,
                              right: 8,
                              child: RawMaterialButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Chose Option',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 233, 66, 183)),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(children: [
                                              InkWell(
                                                onTap: () {
                                                  imageSource =
                                                      ImageSource.camera;
                                                  _pickedImages();
                                                },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color:
                                                            Colors.purpleAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .purpleAccent),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  imageSource =
                                                      ImageSource.gallery;
                                                  _pickedImages();
                                                },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color:
                                                            Colors.purpleAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Gallery',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .purpleAccent),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: _removed,
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Remove',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        );
                                      });
                                },
                                elevation: 10,
                                fillColor: Colors.purpleAccent,
                                child: Icon(Icons.add_a_photo),
                                padding: EdgeInsets.all(15),
                                shape: CircleBorder(),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Add ' + _selectedMember,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        cursorColor: Color(0xffff3333),
                        keyboardType: TextInputType.name,
                        controller: _userNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Name ';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Enter " + _selectedMember + " Name",
                            icon: Icon(
                              Icons.account_circle,
                              size: 30,
                              color: Colors.lightBlue,
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.9),
                                ))),
                        style: TextStyle(
                          //color: Color(0xffff3333),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        cursorColor: Color(0xffff3333),
                        keyboardType: TextInputType.number,
                        controller: _userPhoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Number ';
                          }
                          if (value.length != 11) {
                            return 'Please enter your valid 11 digit mobile Number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Enter " + _selectedMember + " Number",
                            icon: Icon(
                              Icons.phone,
                              size: 30,
                              color: Colors.lightBlue,
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.9),
                                ))),
                        style: TextStyle(
                          //color: Color(0xffff3333),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _userPasswordController,
                        obscureText: !_passwordVisible,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password ';
                          }
                          if (value.length <= 5) {
                            return 'Please enter at least six digit password  ';
                          }
                          return null;
                        },
                        cursorColor: Color(0xffff3333),
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: _selectedMember + " Password",
                          icon: Icon(
                            Icons.lock,
                            size: 30,
                            color: Colors.lightBlue,
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.9),
                              )),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(
                          //color: Color(0xffff3333),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: _saveInfo,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffff3333),
                          ),
                          child: const Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveInfo() async {
    if (formKey.currentState!.validate()) {
    final newMember = MemberInfo(
        name: _userNameController.text,
        phone: _userPhoneController.text,
        password: _userPasswordController.text,
        image: _imagePath,
        deposit: 0,
        membertype:  _selectedMember ,
        meal: 0,
        mealrate: 0);
    print(newMember.toString());
    final status = await Provider.of<AddMemberProvider>(context, listen: false)
        .addNewMembers(newMember);
    if (status) {
      Navigator.pop(context);
    }
    }
  }
}
