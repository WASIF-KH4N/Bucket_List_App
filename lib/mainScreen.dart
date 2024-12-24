import 'package:bucketlist/addbucketlist.dart';
import 'package:bucketlist/viewitem.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<dynamic> BucketListData = [];
  bool isLoading=false;
  Future<void> getdata()async{
    // get data from API

    setState(() {
      isLoading=true;

    });

    try {
      Response response = await Dio().get(
          "https://flutter-api-12-default-rtdb.firebaseio.com/bucketlist.json");
      // print (response.statusCode); 200 Successfully requested
      //  print (response.statusMessage); 0K
      BucketListData=response.data;
      isLoading=false;
     setState(() {

     });
    }
    catch(e){
      isLoading=false;
      setState(() {

      });
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("invalid URL"),
        );
        },
      );
    };
  }
  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AddbucketlistScreen();

        }));

      }, child: Icon(Icons.add),
        shape: CircleBorder(),
      ),
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: getdata,
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Icon(Icons.refresh_outlined),
              ))
        ],
        centerTitle: true,
        title: Text("BUCKET LIST APP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,),),
       ),
      body: RefreshIndicator(
        onRefresh: () async{
          getdata();
        },
        child: isLoading ? Center(child: CircularProgressIndicator()): ListView.builder(
          itemCount: BucketListData.length,
            itemBuilder: (BuildContext context,int index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return ViewItemScreen(title: BucketListData[index]['item']?? "",
                  image:BucketListData[index]['image']?? "",);
                }));
              },
              leading: CircleAvatar(
                radius:30,
                backgroundImage: NetworkImage(BucketListData[index]['image']?? ""),),
               title: Text(BucketListData[index]['item']?? "",),

              trailing: Text(BucketListData[index]['cost'].toString()?? ""),
                ),
          );
        }
        ),
      ),
    );
  }
}
