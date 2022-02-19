import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'data.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
   int index;
  @HiveField(1)
  final String taskMsg;
  @HiveField(2)
   bool isDone = false;
  Task(this.index,this.taskMsg, this.isDone);
}

void addTask(int index, String msg, bool isDone){
  final task = Task(index,msg,isDone);
  Hive.box('Task').add(task);
}