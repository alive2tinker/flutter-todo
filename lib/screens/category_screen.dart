import 'package:flutter/material.dart';
import 'package:todo_list_sqlite/helpers/drawer_navigation.dart';
import 'package:todo_list_sqlite/models/Category.dart';
import 'package:todo_list_sqlite/screens/home_screen.dart';
import 'package:todo_list_sqlite/services/category_service.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _categoryNameController = new TextEditingController();
  var _categoryDescriptionController = new TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();
  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
              actions: <Widget>[
                TextButton(onPressed: () async {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;
                  var result = await _categoryService.save(_category);
                  print(result);
                }, child: Text("Save")),
                TextButton(onPressed: () {

                }, child: Text("Cancel"))
              ],
              title: Text("Category Form"),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _categoryNameController,
                      decoration: InputDecoration(
                          labelText: "Category Name",
                          hintText: "write text name"),
                    ),
                    TextField(
                      controller: _categoryDescriptionController,
                      decoration: InputDecoration(
                          labelText: "Category Description",
                          hintText: "write text description"),
                    ),
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0),
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new HomeScreen()));
          },
        ),
        title: Text('Categories'),
      ),
      body: Center(child: Text("hello world")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
