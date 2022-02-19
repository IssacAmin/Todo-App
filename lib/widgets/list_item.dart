import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/widgets/data.dart';

class ListItem extends StatefulWidget {
  final Task task;
    const ListItem({Key? key,  required this.task}) : super(key: key);
  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(widget.task.taskMsg,
          style: TextStyle(
            fontSize: 15,
            decoration: getTextDecoration(widget.task.isDone),
          ),
        ),
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(Colors.grey),
              value: widget.task.isDone,
              onChanged: (bool? value){
               setState(() {
                  widget.task.isDone = value!;
                   final Task updatedTask = Task(widget.task.index, widget.task.taskMsg, value);
                  Hive.box('Task').putAt(widget.task.index,updatedTask);
                 });
              },
            ),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: (){
                Hive.box('Task').deleteAt(widget.task.index);
                final List<Task> taskList = Hive.box('Task').values.toList().cast<Task>();
                for(int i = 0; i < Hive.box('Task').length;i++)
                  {
                    taskList[i].index = i;
                  }
              },
              child: const Icon(
                Icons.clear,
                color: Colors.grey,
                size: 15,
              ),
            )
          ],
        ),
      ],
    );
  }
}

TextDecoration getTextDecoration (bool isChecked){
  if(isChecked == true){
    return TextDecoration.lineThrough;
  }
    return TextDecoration.none;
}

List<Widget> getTasks(List<Task> list1){
  List<Widget> list2 = [
    Text('${Hive.box('Task').length} tasks',
    style: const TextStyle(
      fontSize: 13,
      color: Colors.grey,
    ),)
  ];
  for(int i = 0; i < list1.length; i++){

      final Task task = Task(list1[i].index,list1[i].taskMsg, list1[i].isDone);
      list2.add(ListItem( task: task));
  }
  return list2;
}


class TaskList extends StatelessWidget {
  final List<Task> list;
  const  TaskList({Key? key,  required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(25),
        children: getTasks(list)
    );
  }
}

ValueListenableBuilder<Box> getTaskList(){
  final builder = ValueListenableBuilder(
      valueListenable: Hive.box('Task').listenable(), builder: (BuildContext context, box, Widget? child) {
    final tasks =  Hive.box('Task').values.toList().cast<Task>();
    return  TaskList( list: tasks);
  },
  );
  return builder;
}