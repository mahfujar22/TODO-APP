import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:project/model/todo_model.dart';
import 'package:project/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import 'complete_todo_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();

  Future<void> _showDialog({TODOModel? todo}) async {
    if (!mounted) return;

    if (todo != null) {
      _textController.text = todo.title;
    } else {
      _textController.clear();
    }

    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(todo == null ? 'Add Todo List' : 'Edit Todo'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: 'Write todo item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _textController.clear();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_textController.text.isEmpty) return;

                final provider = context.read<TodoProvider>();

                if (todo == null) {
                  await provider.addToDoList(
                    TODOModel(title: _textController.text, isCompleted: false),
                  );
                } else {
                  await provider.updateToDo(todo, _textController.text);
                }

                if (!mounted) return;
                Navigator.pop(context);
                _textController.clear();
              },
              child: Text(todo == null ? 'Submit' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 160,
              decoration: const BoxDecoration(
                color: Color(0xff622CA7),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Center(
                child: Text(
                  "TO DO List",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TodoList :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CompletedTodoPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle_outline),
                  ),
                ],
              ),
            ),

            Expanded(
              child: provider.allTODOList.isEmpty
                  ? const Center(
                child: Text(
                  "No tasks added yet!",
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: provider.allTODOList.length,
                itemBuilder: (context, index) {
                  final todo = provider.allTODOList[index];

                  return ListTile(
                    onTap: () {
                      provider.todoStatusChange(todo);
                    },
                    leading: MSHCheckbox(
                      size: 30,
                      value: todo.isCompleted,
                      colorConfig:
                      MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: Colors.blue,
                      ),
                      onChanged: (value) {
                        provider.todoStatusChange(todo);
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        decoration: todo.isCompleted
                            ? TextDecoration.none
                            : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                          const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _showDialog(todo: todo);
                          },
                        ),
                        IconButton(
                          icon:
                          const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            provider.removedToDoList(todo);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff622CA7),
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
