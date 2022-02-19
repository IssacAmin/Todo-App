import 'package:todoapp/widgets/data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class BottomScreen extends StatefulWidget {
   const BottomScreen({Key? key}) : super(key: key);

  @override
  _BottomScreenState createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  final int number = Hive.box('Task').length;
  TextEditingController inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding:  EdgeInsets.only(top: 35, bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:    [
            const Text("Add Task",
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30,),
             SizedBox(
              width: 300,
              child: TextField(
                controller: inputController,
                autofocus: true,
                showCursor: true,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 300,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: (){
                    if(inputController.text != '') {
                      Navigator.of(context).pop();
                      addTask(number,inputController.text, false);
                    }
                },
                child: const Text("add"),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
