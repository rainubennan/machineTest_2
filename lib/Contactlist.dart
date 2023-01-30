import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/API%20Manager.dart';
import 'package:machinetest/Application_Form.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ContactsPage> createState() => ContactsPageState();
}

class ContactsPageState extends State<ContactsPage> {

  List contactList = []; // Contact Listing Array

//MARK : GET JOB DATA - API
  void getContactData() async {
    NetworkHelper _networkHelper = NetworkHelper();
    var response = await _networkHelper.getContactData();
    if (kDebugMode) {
      print(response);
    }

    if (mounted) {
      setState(() {
        contactList = response["data"];
      });
    }
    if(contactList.isEmpty)
    {
      showAlert('Error', "No Contacts available ");
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
  void initState() {
    super.initState();
    getContactData();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title:const Text(
        "Contacts",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      ),
      body: Column(
        children:  [
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(child: ListTile(
                    title: Text(contactList[index]["first_name"] + " " + contactList[index]["last_name"],
                      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                    ),
                    subtitle: Text(contactList[index]["email"],style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),),
                    trailing: TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          Edit_Application()));
                    }, child: const Text("Edit"),),
                    //
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          contactList[index]["avatar"]),
                    ),
                  ),);
                }
            ),
          ),

        ]
        ,
      )
      ,
    );
  }

}