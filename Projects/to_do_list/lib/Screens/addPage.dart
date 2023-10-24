import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: ' Title'),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: submitData,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 50),
              backgroundColor: Colors.greenAccent,
              foregroundColor: Colors.black,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void submitData() async {
    final enteredTitle = titleController.text;
    final enteredDescription = descriptionController.text;
    final body = {
      "title": enteredTitle,
      "description": enteredDescription,
      "is_completed": false
    };
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      print("Creation Sucess");
      successMessage("Creation Success");
    } else {
      print("Creation Failed");
      errorMessage("Creation Failed");
    }
  }

  void successMessage(String message) {
    final snackBar = SnackBar(
        content: Text(message), backgroundColor: Colors.lightGreenAccent);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void errorMessage(String message) {
    final snackBar =
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
