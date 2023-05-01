import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:netshop/Utils/helpers/Sessions.dart';
import 'package:netshop/constants/App_style/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../constants/App_style/AppTextStyle.dart';
import '../../services/auth_controllers/Profile_controller.dart';

class Message_screen extends StatefulWidget {
  String? Name, image, receiver;

  Message_screen({this.Name, this.image, this.receiver});

  @override
  State<Message_screen> createState() => _Message_screenState();
}

class _Message_screenState extends State<Message_screen> with WidgetsBindingObserver {
  final Message = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("chat list");
  DatabaseReference refs = FirebaseDatabase.instance.ref().child("User");
  var uuid = Uuid();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("online");
  }

  @override
  void setStatus(String status) async {
    await refs.child(SessionControler().userId.toString()).update({"onlineStatus": status});
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
       setStatus("online");
    } else {
       setStatus("offline");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.orange,
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          title: ChangeNotifierProvider(
            create: (_) => ProfileController(),
            child: Consumer<ProfileController>(
              builder: (context, provider, child) {
                return StreamBuilder(
                  stream:  refs.child(widget.receiver.toString()).onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.orange),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orange,
                                        ),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) {
                                            return Icon(Icons.person);
                                          },
                                          imageUrl: widget.image.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Text(
                                      widget.Name.toString(),
                                      style: AppTextStyle.normalText(
                                          fontSize: 20,
                                          fontweight: FontWeight.w500,
                                          colors: Colors.white),
                                    ),
                                    Text(map["onlineStatus"],
                                      style: AppTextStyle.normalText(
                                          fontSize: 13,
                                          fontweight: FontWeight.w500,
                                          colors: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  },
                );
              },
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: FirebaseAnimatedList(reverse: true,
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                return Container(height: 50,width: 80,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Colors.blue.withOpacity(0.3)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(snapshot.child("messege").value.toString(),textAlign: TextAlign.end)),
                    ));
              },
            )),
            Container(
              height: 70,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextFormField(
                        controller: Message,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 15),
                            hintText: "Message Type..",
                            focusColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        ref.child(uuid.v4()).set({
                          "isSeen": false,
                          "receiverid": widget.receiver.toString(),
                          "messege": Message.text.toString(),
                          "Sender": SessionControler().userId.toString(),
                          "typy": "text",
                          "time": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        }).then((value) {
                          Message.clear();
                        });
                      },
                      child: CircleAvatar(
                          radius: 23,
                          backgroundColor: AppColors.orange,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
