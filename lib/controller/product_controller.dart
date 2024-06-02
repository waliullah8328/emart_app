import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var subCat = [];

  getSubCategories(title)async{
    subCat.clear();
    var data = await rootBundle.loadString("lib/Services/category_model.json");

    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();

    for(var e in s[0].subcategory){
      subCat.add(e);

    }

  }



}