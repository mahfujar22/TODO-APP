import 'package:flutter/cupertino.dart';
import 'package:project/model/todo_model.dart';

class TodoProvider extends ChangeNotifier{

  final List<TODOModel> _todoList =[];


  List<TODOModel> get allTODOList => _todoList;

  void addToDoList(TODOModel todoModel){
    _todoList.add(todoModel);
    notifyListeners();
  }


  void todoStatusChange(TODOModel todoModel){
    final index = _todoList.indexOf(todoModel);
    _todoList[index].toggleCompleted();
    notifyListeners();
  }


  void removedToDoList(TODOModel todoModel){
    final index = _todoList.indexOf(todoModel);
    _todoList.remove(todoModel);
    notifyListeners();
  }


  List<TODOModel> get completedTodoList =>
      _todoList.where((todo) => todo.isCompleted == true).toList();





 }