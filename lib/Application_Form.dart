import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'API Manager.dart';

void main(){
  runApp(MaterialApp(home:Edit_Application(),debugShowCheckedModeBanner: false,));
}

class Edit_Application extends StatefulWidget{
  @override
  State<Edit_Application> createState() => _Edit_ApplicationState();
}

class _Edit_ApplicationState extends State<Edit_Application> {

  TextEditingController nameController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();

  //MARK : Update list - API
  void updateList(String name,String jobTitle) async {
    NetworkHelper _networkHelper = NetworkHelper();
    var response = await _networkHelper.updateList(name, jobTitle);
    if (kDebugMode) {
      print(response);
    }
    showAlert(response["name"] + "\n" +  response["job"], "created : " + response["createdAt"]);
    
    if (mounted) {
      setState(() {
        //_showLoader = false;
      });
    }
  }

  //MARK: Alert Dialogue Box
  void showAlert(String title, String content) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            MaterialButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update"),),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
          children: [
            const SizedBox(height: 10,),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label:Text(" Enter your  name"),
                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                ),),
            const SizedBox(height: 15,),
            TextFormField(
              controller: jobTitleController,
              decoration: const InputDecoration(
                  label:Text(" Enter your current job"),
                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
              ),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){ 
                
                updateList(nameController.text, jobTitleController.text);
                
              }, child: const Text("Update")),
            )

      ],),
        ),
    ),);
  }
}