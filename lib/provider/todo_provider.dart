import 'package:flutter/foundation.dart';
import '../model/todo_model.dart';
import '../model/sqlite_helper.dart';

class TodoProvider extends ChangeNotifier {
  List<TODOModel> _todoList = [];
  List<TODOModel> get allTODOList => _todoList;

  TodoProvider() {
    loadTodos();
  }

  Future<void> loadTodos() async {
    _todoList = await TodoDB.instance.getAllTodos();
    print(" Loaded todos from DB: ${_todoList.length}");
    notifyListeners();
  }

  Future<void> addToDoList(TODOModel todoModel) async {
    await TodoDB.instance.addTodo(todoModel);
    print(" Added todo: ${todoModel.title}");
    await loadTodos();
  }

  Future<void> removedToDoList(TODOModel todoModel) async {
    if (todoModel.id != null) {
      await TodoDB.instance.deleteTodo(todoModel.id!);
      print("🗑 Deleted todo id: ${todoModel.id}");
      await loadTodos();
    }
  }

  Future<void> updateToDo(TODOModel todo, String newTitle) async {
    final updatedTodo = TODOModel(
      id: todo.id,
      title: newTitle,
      isCompleted: todo.isCompleted,
    );
    await TodoDB.instance.updateTodo(updatedTodo);
    print(" Updated todo id ${todo.id} to: $newTitle");
    await loadTodos();
  }

  Future<void> todoStatusChange(TODOModel todo) async {
    final updatedTodo = TODOModel(
      id: todo.id,
      title: todo.title,
      isCompleted: !todo.isCompleted,
    );
    await TodoDB.instance.updateTodo(updatedTodo);
    print(" Changed status of id ${todo.id} to ${updatedTodo.isCompleted}");
    await loadTodos();
  }

  List<TODOModel> get completedTodoList =>
      _todoList.where((todo) => todo.isCompleted).toList();
}
