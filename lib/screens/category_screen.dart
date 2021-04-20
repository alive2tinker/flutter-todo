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
  var _categoryNameEditController = new TextEditingController();
  var _categoryDescriptionEditController = new TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = [];

  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.getCategories();
    categories.forEach((category) {
      setState(() {
        var cat = Category();
        cat.name = category['name'];
        cat.id = category['id'];
        cat.description = category['description'];
        _categoryList.add(cat);
      });
    });
  }
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
                  if(result != null){
                    Navigator.pop(context);
                    getAllCategories();
                  }
                }, child: Text("Save")),
                TextButton(onPressed: () {
                  Navigator.pop(context);
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

  _showEditDialog(BuildContext context, category) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
              actions: <Widget>[
                TextButton(onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = _categoryNameEditController.text;
                  _category.description = _categoryDescriptionEditController.text;
                  var result = await _categoryService.update(_category);
                  if(result != null){
                    Navigator.pop(context);
                    getAllCategories();
                  }
                }, child: Text("Update")),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Cancel"))
              ],
              title: Text("Category Edit Form"),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _categoryNameEditController,
                      decoration: InputDecoration(
                          labelText: "Category Name",
                          hintText: "write text name"),
                    ),
                    TextField(
                      controller: _categoryDescriptionEditController,
                      decoration: InputDecoration(
                          labelText: "Category Description",
                          hintText: "write text description"),
                    ),
                  ],
                ),
              ));
        });
  }

  _showDeleteDialog(BuildContext context, category) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
              actions: <Widget>[
                TextButton(onPressed: () async {
                  var result =  await _categoryService.destroy(category);
                  if(result > 0){
                    Navigator.pop(context);
                  }
                  getAllCategories();
                }, child: Text("Delete", style: TextStyle(color: Colors.white),), style: TextButton.styleFrom(
                  backgroundColor: Colors.red
                ),),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Cancel", style: TextStyle(color: Colors.white),), style: TextButton.styleFrom(
                  backgroundColor: Colors.green
                ),)
              ],
              title: Text("Are you sure you want to delete?"),);
        });
  }

  _deleteCategory(BuildContext context, category) async {

        _showDeleteDialog(context, category);
  }

  _editCategory(BuildContext context, categoryId) async{
    var category = await _categoryService.getSingleCategory(categoryId);

    setState(() {
      _categoryNameEditController.text = category[0]['name'];
      _categoryDescriptionEditController.text = category[0]['description'];
    });

    _showEditDialog(context, category);
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
      body: ListView.builder(itemCount: _categoryList.length,itemBuilder: (context, index){
        return Card(child: ListTile(
            leading: IconButton(icon: Icon(Icons.edit), onPressed: (){
              _editCategory(context, _categoryList[index].id);
            },),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_categoryList[index].name),
                IconButton(icon: Icon(Icons.delete), onPressed: () async{
                  _deleteCategory(context, _categoryList[index].id);
                })
              ],
            )
        ),);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
