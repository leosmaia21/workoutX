// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workout/databasemanager/databasemanager.dart';
import 'package:workout/services/authservice.dart';
import 'package:workout/utilities/measure_icons.dart';
import 'package:workout/utilities/toast.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    var name = context.read<DatabaseManager>().getName();

    return Drawer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [
                    Color(0xFFF77723),
                    Color(0xFFF7A456),
                    Color(0xFFF7BE8A),
                    Color(0xFFF5EEE9),
                  ],
                ),
              ),
              child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: IntrinsicHeight(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Column(
                            children: <Widget>[
                              header(name!),
                              // SizedBox(
                              //   height: 50,
                              // ),
                              buildMenuItem(
                                "Treinos antigos",
                                Icons.fitness_center,
                                () {
                                  null;
                                },
                              ),
                              buildMenuItem('Medições', Measure.ruler, () {
                                // toast("funciona");
                              }),
                              buildMenuItem(
                                  'Peso', Icons.monitor_weight_outlined, () {
                                null;
                              }),
                              buildMenuItem(
                                "Fotografias",
                                Icons.photo,
                                () {
                                  null;
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                        leading: Icon(Icons.logout),
                                        title: Text('Terminar sessão'),
                                        onTap: () async {
                                          await context
                                              .read<AuthService>()
                                              .signOut();
                                              context.read<DatabaseManager>().setLogOut();
                                            
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Wrapper()),
                                              (_) => false);
                                        })
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildMenuItem(String text, IconData icon, VoidCallback? onClicked) {
    return ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                //offset: Offset(10.0, 10.0),
                blurRadius: 20.0,
                color: Colors.black,
              ),
            ],
          ),
        ),
        onTap: onClicked);
  }

  Widget header(String name) {
    return DrawerHeader(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: imageProfile(),
          ),
          Align(
            alignment: Alignment.centerRight + Alignment(-0.2, -0.4),
            child: Text(
              name,
              style: GoogleFonts.amita(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  // child: (_imageFile == null)
  //               ? Image(
  //                   image: AssetImage('lib/assets/images/cara_moniz_gif1.gif'),
  //                   fit: BoxFit.cover)
  //               : Image.file(_imageFile!),
  bool change=false;

  backgroudImage() {
    if (context.read<DatabaseManager>().hasPhoto== true || change==true) {
      // toast("ole");
      change=false;
      return context.read<DatabaseManager>().image;
    } else {
      return AssetImage('lib/assets/images/cara_moniz_gif1.gif');
    }
  }

  Widget imageProfile() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: backgroudImage(),

          // roundColor: Colors.transparent,
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((context) => bottomSheet()));
              }, //funcao carregar na camera
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 28,
              ),
            );
          }),
        )
      ],
    );
  }

  Widget bottomSheet() {
    return Builder(
      builder: (context) {
        return Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                'Escolher fotografia',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      await takePhoto(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera),
                    label: Text(
                      'Câmera',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  // SizedBox(width: 20),
                  TextButton.icon(
                    onPressed: () async {
                      await takePhoto(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text(
                      'Galeria',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> takePhoto(ImageSource source) async {
    var pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    
    String uid=FirebaseAuth.instance.currentUser!.uid.toString();
    if (pickedFile != null) {
      var path=File(pickedFile.path);
      await FirebaseStorage.instance.ref().child('users_photos/'+uid).putFile(path);
      await  context.read<DatabaseManager>().getProfileImage();
      setState(() {
       change=true;
      });
     
    }
  }
}
