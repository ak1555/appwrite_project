import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projawrite/services/appwriteservice.dart';
import 'package:projawrite/todo.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _controller = TextEditingController();
  late Appwriteservice _appwriteServices;
  File? _image;
  Uint8List? pic;
  List ls = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appwriteServices = Appwriteservice();
    LoadTask();
  }

  Future<void> addTask() async {
    print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
    print(img);
    final employee = _controller.text;
    final bytes = await _image!.readAsBytes();
    final base64Img = base64Encode(bytes);
    if (employee.isNotEmpty) {
      try {
        await _appwriteServices.addTask(employee, base64Img);
      } catch (e) {
        print(e);
      }
    }
    _controller.clear();
    LoadTask();
  }

  Future<void> LoadTask() async {
    print(
        "LLLLLLLLLLLLLLLLLLLLLOOOOOOOOOOOOOOOOOOAAAAAAAAAAAAAAAAAAAAAAADDDDDDDDDDD");
    print(ls.length);
    try {
      final details = await _appwriteServices.getTask();
      setState(() {
        ls = details.map((e) => Task.formDoument(e)).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> UpdateDetail(Task ind) async {
    try {
      final updated =
          await _appwriteServices.UpdateColor(ind.id, !ind.isComplete);
      setState(() {
        ind.isComplete != updated.data['completed'];

        LoadTask();
      });
    } catch (e) {
      print(e);
    }
  }

  double height = 0;
  double width = 250;
  ImagePicker _imagepicker = ImagePicker();
  bool img = false;

  void pickImage() async {
    final pickedimage =
        await _imagepicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedimage!.path);
      img = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "EMPLOYEES",
            style: TextStyle(letterSpacing: 1),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
                child: GridView.builder(
              itemCount: ls.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.5,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemBuilder: (context, index) {
                print("**********************************8");
                print(ls[index].isComplete);
                // bool d= ls[index].isComplete;
                print("============================");
                // print(d);
                return Card(
                  child: GestureDetector(
                    onLongPress: () {
                      if (ls[index].isComplete == false) {
                        final idd = ls[index].id;
                        _appwriteServices.delete(idd);
                        LoadTask();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("OOPS!!!"),
                              content: Text("You must deactivate first."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("OK"))
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              ls[index].isComplete ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey[100]),
                              child: ClipOval(
                                child: Image.memory(
                                  pic =
                                      base64Decode(ls[index].photo.toString()),
                                  fit: BoxFit.cover,
                                ),
                              )),
                          SizedBox(height: 5),
                          Container(
                              child: Center(
                            child: Text(
                              ls[index].name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          )),
                          SizedBox(height: 5),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  backgroundColor: ls[index].isComplete
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                onPressed: () {
                                  UpdateDetail(ls[index]);
                                },
                                child: ls[index].isComplete
                                    ? Text(
                                        "DEACTIVATE",
                                        // ls[index].isComplete.toString(),
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        "ACTIVATE",
                                        // ls[index].isComplete.toString(),
                                        style: TextStyle(
                                          letterSpacing: 1,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: height,
              width: width,
              color: Colors.grey.shade100,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 110,
                    width: 250,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[200]),
                          child: img
                              ? ClipOval(
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    pickImage();
                                  },
                                  icon: Icon(
                                    Icons.person_add_alt_1,
                                    size: 43,
                                    color: Colors.grey.shade700,
                                  )),
                          // IconButton(
                          //     onPressed: () {
                          //       pickImage();
                          //     },
                          //     icon: Icon(
                          //       Icons.person_add_alt_1,
                          //       size: 43,
                          //       color: Colors.grey.shade700,
                          //     )),
                        ),
                        Spacer(),
                        Container(
                          height: 100,
                          width: 50,
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  height = 0;
                                });
                              },
                              icon: Icon(Icons.cancel_outlined)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: 45,
                    width: 200,
                    padding: EdgeInsets.only(left: 8, right: 8),
                    margin: EdgeInsets.only(left: 13, right: 13),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Enter Name"),
                        )),
                        Icon(
                          Icons.person,
                          size: 23,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        onPressed: () {
                          if (img == true) {
                            addTask();
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("OOPS!!!"),
                                  content: Text("Must need a photo"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"))
                                  ],
                                );
                              },
                            );
                          }
                          setState(() {
                            height = 0;
                            img = false;
                          });
                        },
                        child: Text("SUBMIT")),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            height = 300;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
