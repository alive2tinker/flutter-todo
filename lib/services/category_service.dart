import 'package:todo_list_sqlite/models/Category.dart';
import 'package:todo_list_sqlite/repositories/repository.dart';

class CategoryService{

  Repository _repository;

  CategoryService(){
    _repository = Repository();
  }
  save(Category category) async
  {
   return await _repository.save("categories", category.categoryMap());
  }

  getCategories() async{
    return await _repository.getAll('categories');
  }

  getSingleCategory(categoryId) async{
    return await _repository.get('categories', categoryId);
  }

  update(Category category) async{
    return await _repository.update("categories", category.categoryMap());
  }

  destroy(int id) async{
    return await _repository.destroy("categories", id);
  }
}