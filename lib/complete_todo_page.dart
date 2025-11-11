import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/provider/todo_provider.dart';

class CompletedTodoPage extends StatelessWidget {
  const CompletedTodoPage({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TodoProvider>(context);
    final completedList = provider.completedTodoList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Todos",
          style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: const Color(0xff622CA7),
      ),
      body: completedList.isEmpty
          ? const Center(
        child: Text(
          "No completed tasks yet 😅",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: completedList.length,
        itemBuilder: (context, index) {
          final todo = completedList[index];
          return ListTile(
            leading:
            const Icon(Icons.check_circle, color: Colors.green),
            title: Text(
              todo.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          );
        },
      ),
    );
  }
}
