import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappusingapi/allApiService.dart';
import 'package:todoappusingapi/screens/addPage.dart';
import 'package:todoappusingapi/utils/Snackbarhelper.dart';
import 'package:todoappusingapi/widget/todocard.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({
    super.key,
  });
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List Using Api'),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text('No Todo Item'),
            ),
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['_id'] as String;
                  return TodoCard(
                    index: index,
                    deleteById: deleteTodo,
                    navigateEdit: navigateToEditPage,
                    item: item,
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage, label: Text('Add Todo')),
    );
  }

  Future<void> navigateToAddPage() async {
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTodoPage()));

     setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async {
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddTodoPage(todo: item)));
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  //Get todo from Apiservice:
  Future<void> fetchTodo() async {
    final response = await ApiService.read();

    if (response != null) {
      setState(() {
        items = response;
      });
    }
    else showErrorMessage(context, massage: 'Something went wrong');

    setState(() {
      isLoading = false;
    });
  }

  //Delete todo from Apiservice::
  Future<void> deleteTodo(String id) async {
    final isSuccess = await ApiService.delete(id);

    if (isSuccess) {
      //Remove item from the list:
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage(context, massage: 'Deletion Failed');
    }
  }
}
