import 'package:flutter/material.dart';
import '../widgets/list_item.dart';
import 'bottom_screen.dart';
import 'package:hive/hive.dart';

class TasksScreen extends StatefulWidget {
   const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {

  @override
  void dispose() {


    Hive.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(
          Icons.add,
        color: Colors.white,
        ),
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context)=> const BottomScreen() ,isScrollControlled: true);

        },
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  const [
                 CircleAvatar(
                   radius: 30,
                   backgroundColor: Colors.white,
                  child: Icon(Icons.list,
                    color: Colors.lightBlueAccent,
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Todoey",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              ),
              child: getTaskList()
            ),
          ),
        ],
      ),
    );
  }
}