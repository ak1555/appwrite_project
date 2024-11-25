import 'package:flutter/material.dart';
import 'package:projawrite/services/appwriteservice.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController _controller = TextEditingController();
  late Appwriteservice _appwriteServices ;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     _appwriteServices=Appwriteservice();
  }

  Future <void> addTask()async{
    final employee = _controller.text;
    if(employee.isNotEmpty){
      try {
        await _appwriteServices.addTask()
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("DETAILS",style: TextStyle(letterSpacing: 1),),),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },child: Icon(Icons.add),),
    );
  }
}