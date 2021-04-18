import 'package:todo_list_sqlite/models/Category.dart';
import 'package:todo_list_sqlite/repositories/repository.dart';

class CategoryService{

  Repository _repository;

  CategoryService(){
    _repository = Repository();
  }
  save(Category category) async
  {
    _repository.save("categories", category.categoryMap());
  }
}