import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_list/Screens/addPage.dart';
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    getAllToDo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: getAllToDo,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              final id = item['_id'] as String;
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'edit') {
                      //perofrmedit function
                      navigateEditPage(item);
                    }
                    if (value == 'delete') {
                      //perform delete function
                      deleteById(id);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              );
            },
          ),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateAddPage,
        label: const Text('Add'),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  Future<void> navigateEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(),
    );
    await Navigator.push(context, route);
    getAllToDo();
  }

  Future<void> navigateAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(),
    );
    await Navigator.push(context, route);
    getAllToDo();
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      // getAllToDo();
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      print('Error in API call');
    }
  }

  Future<void> getAllToDo() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      print('Error in API call');
    }
    setState(() {
      isLoading = false;
    });
  }
}
