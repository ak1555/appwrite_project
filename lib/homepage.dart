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
  List ls = ["aleena","karthik","asta","julius","yami","novochrome","captain","novel","memosa","dark",];

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
        // await _appwriteServices.addTask()
      } catch (e) {
        print(e);
      }
    }
  }

      double height =0;
    double width = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("DETAILS",style: TextStyle(letterSpacing: 1),),),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,childAspectRatio: 2/2.5,crossAxisSpacing: 2,mainAxisSpacing: 2),
             itemBuilder: (context, index) {
               return Card(
                child: Container(
                  decoration: BoxDecoration(
                     color: Colors.red,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.grey[100]),
                      child: Icon(Icons.person_add_alt_1,size: 43,color: Colors.grey.shade700,),
                      ),
                      Container(child: Center(child: Text(ls[index].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),))
                    ,
                    Center(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4),),backgroundColor: Colors.green),
                      onPressed: () {
                      
                    }, child: Text("ACTIVATE",style: TextStyle(letterSpacing: 1,color: Colors.white,fontWeight: FontWeight.bold,),)),)
                    ],
                  ),
                ),
               );
             },)),
             AnimatedContainer(duration: Duration(milliseconds: 1000),
             height: height,
             width: width,
             color: Colors.grey.shade100,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),color: Colors.grey[200]),
                ),
                Container(
                  height: 45,
                  width: 200,
                  padding: EdgeInsets.only(left: 8,right: 8),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Expanded(child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,hintText: "Enter Name"),
                      )),
                      Icon(Icons.person,size: 23,)
                    ],
                  ),
                ),
                 SizedBox(height: .5),
                Center(child: ElevatedButton(style: ElevatedButton.styleFrom(
                  shape:  BeveledRectangleBorder(borderRadius: BorderRadius.circular(4))
                ),
                  onPressed: () {
                  
                }, child: Text("SUBMIT")),),
                SizedBox(height: 1,),
              ],
            ),
             )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          height=300;
        });
      },child: Icon(Icons.add),),
    );
  }
}