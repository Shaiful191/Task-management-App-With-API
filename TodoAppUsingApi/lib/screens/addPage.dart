
import 'package:flutter/material.dart';
import 'package:todoappusingapi/allApiService.dart';
import 'package:todoappusingapi/utils/Snackbarhelper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({super.key,this.todo});


  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  bool isEdit=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo=widget.todo;
    if( todo != null){
      isEdit=true;
      final title=todo['title'];
      final description=todo['description'];
      titleController.text=title;
      descriptionController.text=description;

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isEdit ?'Edit Todo':'Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: isEdit ? updateData: createData,
              child: Text(
                  isEdit? 'Update':'Submit')),
        ],
      ),
    );
  }


  //Create Data=http post:
  Future <void> createData() async{

    //Submit data to the server:

    final isSuccess=await ApiService.create(body);

    //Show success or fail massage based on status:
    if(isSuccess) {
      titleController.text='';
      descriptionController.text='';
      showSuccessMessage(context,massage: 'Creation Success');
    }
    else{
      showErrorMessage(context,massage: 'Creation Failed');
    }



  }

  //Update
  Future <void> updateData() async{

    final todo=widget.todo;
    if(todo==null) return;
    final id=todo['_id'];

    //Submit updata to the server:
    final isSuccess=await ApiService.update(id,body);


    //Show success or fail massage based on status:
    if(isSuccess) {
      showSuccessMessage(context,massage: 'Updation Success');
    }
    else{
      showErrorMessage(context,massage:'Updation Failed');
    }

  }

  //Get the data from the form:
  Map get body{
    final title=titleController.text;
    final description=descriptionController.text;

    return {
      "title": title,
      "description": description,
      //"is_completed": false,
    };
}

}
