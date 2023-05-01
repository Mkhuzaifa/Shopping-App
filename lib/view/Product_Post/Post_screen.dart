import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uuid/uuid.dart';
import '../../Utils/helpers/Sessions.dart';
import '../View_product.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({Key? key}) : super(key: key);

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  var uuid = Uuid();

  DatabaseReference ref = FirebaseDatabase.instance.ref("post list");

  getdata() async {
    DatabaseEvent event = await ref.once();
    print("asdkfjhsjkhfjkashfhasjkhfjkashdfhasjkhfkjasdhkfjhasdjkfhjkh${event. snapshot. value}");
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    FocusNode EmailFocusNode = FocusNode();
    FocusNode PasswordFocusNode = FocusNode();
    List lists = [];
    @override
    void dispose() {
      titleController.dispose();
      EmailFocusNode.dispose();
      descriptionController.dispose();
      PasswordFocusNode.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Postscreen"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              // child: FirebaseAnimatedList(
              //   query: ref,
              //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
              //       Animation<double> animation, int index) {
              //     var data = snapshot.children.toList();
              //     print(data[0].child("title"));
              //     return GridView(
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         mainAxisExtent: 300,
              //         crossAxisSpacing: 10,
              //         mainAxisSpacing: 10,
              //       ),
              //       children: [],
              //     );
              //   },
              // ),)
              child: StreamBuilder(
                stream: ref.onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {

                    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 300,mainAxisSpacing: 10,crossAxisSpacing: 10),
                   itemBuilder: (context, index) {
                     print(snapshot.data);

                   },
                    );
                  } else {
                    return Center(
                      child: Text("Something went wrong"),
                    );
                  }
                },
              ),
            ),
          ],
        ),

    );
  }
}
// Expanded(
// child: StreamBuilder(
// stream: ref.onValue,
// builder: (context, AsyncSnapshot<Event> snapshot) {
// if(snapshot.hasData){
// print("Error on the way");
// lists.clear();
// DataSnapshot dataValues = snapshot.data.snapshot;
// Object? values = dataValues.value;
// values?.forEach((key, values) {
// lists.add(values);
// });
// return ListView.builder(
// itemCount: snapshot.data.toString().length,
// itemBuilder: (context, index) {
// return ListTile(
// leading: CircleAvatar(
// backgroundImage: NetworkImage(lists[index]["imagePath"].toString()),
// ),
// title: Text(lists[index]["title"].toString()),
// );
// },
// );
// }else{
// return CircularProgressIndicator();
// }
// },
// ),
// ),
// await ref.child(uuid.v1()).set({
// "userId" : SessionControler().userId,
// "imagePath" : "https://optedcode.com/wp-content/uploads/2022/10/ceoofoptedcode.png",
// "title" : "this is title",
// "description" : "this is description"
// });
