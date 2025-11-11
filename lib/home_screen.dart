import 'package:flutter/material.dart';
import 'package:project/model/todo_model.dart';
import 'package:project/provider/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'complete_todo_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textController = TextEditingController();

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo List'),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(hintText: 'write todo item'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_textController.text.isEmpty) {
                  return null;
                }

                context.read<TodoProvider>().addToDoList(
                  new TODOModel(
                    title: _textController.text,
                    isCompleted: false,
                  ),
                );
                _textController.clear();
                Navigator.pop(context);
              },
              child: Text('Submit'),
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
            Expanded(
              child: Container(
                decoration: BoxDecoration(
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
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TodoList :',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
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
                    icon: Icon(Icons.check_circle_outline),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: provider.allTODOList.length,
                itemBuilder: (context, itemIndex) {
                  return ListTile(
                    onTap: () {
                      provider.todoStatusChange(
                        provider.allTODOList[itemIndex],
                      );
                    },
                    leading: MSHCheckbox(
                      size: 30,
                      value: provider.allTODOList[itemIndex].isCompleted,
                      colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                        checkedColor: Colors.blue,
                      ),
                      onChanged: (selected) {
                        provider.todoStatusChange(
                          provider.allTODOList[itemIndex],
                        );
                      },
                    ),
                    title: Text(
                      provider.allTODOList[itemIndex].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        decoration:
                            provider.allTODOList[itemIndex].isCompleted == true
                            ? TextDecoration.none
                            : null,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        provider.removedToDoList(
                          provider.allTODOList[itemIndex],
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff622CA7),
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
