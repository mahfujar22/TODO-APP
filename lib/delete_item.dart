import 'package:flutter/material.dart';
import 'package:project/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class DeleteItem extends StatefulWidget {
  const DeleteItem({super.key});

  @override
  State<DeleteItem> createState() => _DeleteItemState();
}

class _DeleteItemState extends State<DeleteItem> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("delete Todos",
          style: TextStyle(
              color: Colors.white
          ),),
        backgroundColor: const Color(0xff622CA7),
      ),

    );
  }
}
