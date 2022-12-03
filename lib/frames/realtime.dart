import 'package:flutter/material.dart';
import 'package:sign_language_dictionary_app/controller/drawer.dart';

class RealTimeTranslate extends StatefulWidget {
  const RealTimeTranslate({Key? key}) : super(key: key);

  @override
  State<RealTimeTranslate> createState() => _RealTimeTranslateState();
}

class _RealTimeTranslateState extends State<RealTimeTranslate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image:const DecorationImage(
            image: AssetImage('assets/images/realtime.jpg'),
          ),
          border: Border.all(color: Colors.lightBlueAccent),
          borderRadius: BorderRadius.circular(40),
        ),
        margin: EdgeInsets.only(
            left: 15, right: 15, bottom: AppBar().preferredSize.height),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Icons.change_circle,
                        //   size: 40,
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.2,
              child:const Text(
                "Iam madhawa MAduranga",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: AppBar().preferredSize.height * 0.7,
            )
          ],
        ),
      ),
      drawer: CommonDrawer().funDrawer(context),
      floatingActionButton: Container(
        height: 75,
        width: 75,
        child: FloatingActionButton(
          onPressed: () {},
          child:const Icon(
            Icons.camera,
            size: 70,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //floatingActionButtonAnimator:
    );
  }
}
