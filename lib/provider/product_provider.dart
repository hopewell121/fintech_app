// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop_app/model/product_model.dart';
import 'package:online_shop_app/services/api_services.dart';

class ProductProvider extends ChangeNotifier {


  //************GETTIG THE END POINT FOR THE USER */
// creating the user
  

//...............GETTING THE SEARCH FILTER FROM THE API...............
  // // create a getter


  Future<void> getSearchFilter({required String title}) async{ 
 final url = 'https://api.escuelajs.co/api/v1/products/?title=$title';

var response = await http.get(Uri.parse(url),
  headers: {'Content-Type': 'application/json'});
  print(response.statusCode);
  print(response.body);

if(response.statusCode== 200){
    List<dynamic> body = jsonDecode(response.body);

    final data = body.map((e) => ProductModel.fromJson(e)).toList();

   _productList = data;
    notifyListeners();

  } else {
    print('Something went wrong: ${response.statusCode}');
    throw Exception(' Failed to load data');
  }
  
  }

  //................GETTING SEACRH FILTER FROM THE TITIE ( SEARCH BAR ).........................

 void searchByTitle(String query){
  if (query.isEmpty){
    _productList;
  } else {
    _productList?.where(
      (product)=>
      product.title!.toLowerCase().contains(query.toLowerCase()),
      ).toList();
  }
  notifyListeners();
 }
//..................................................................................







//..............................GETTING A PRODUCTLIST CATEGORY FROM THE A.P.I..................

// create a setter for categories
List<Category>? _categories;

//create a getter

List<Category>? get categories => _categories;

// defining the URL

Future<void> getCategories() async{
  final url = ApiServices.categoryUrl;
  var resonse = await http.get(Uri.parse(url),
  headers: {'Contemt-type': 'application/jason'});
  print(resonse.body);

  if(resonse.statusCode == 200){
    List<dynamic>body = jsonDecode(resonse.body);

    final data = body.map((e)=> Category.fromJson(e)).toList();
    _categories = data;
    notifyListeners();

  } else {
    print('Something went wrong: ${resonse.statusCode}');
    throw Exception('failed to load data');
  }

  

}
//.....................END OF LINE........................................





//..........................GETTING THE PRODUCTS FROM THE BACK END API...................

//create setter for products


List<ProductModel>? _productList;

// create getter

List<ProductModel>? get productList => _productList;

//empty list for adding to cart

final List<ProductModel> _productCartList=[];

//get the empty list called out outside thie class

List<ProductModel> get productCartList => _productCartList;


Future<void> getProduct() async{

  //define the url
  final url = ApiServices.productsUrl;

  var response = await http.get(Uri.parse(url),
  headers: {'Content-Type': 'application/json'});
  // print(response.body);


  if(response.statusCode== 200){
    List<dynamic> body = jsonDecode(response.body);

    final data = body.map((e) => ProductModel.fromJson(e)).toList();

    _productList = data;
    notifyListeners();

  } else {
    print('Something went wrong: ${response.statusCode}');
    throw Exception(' Failed to load data');
  }

  

}
//........END OF LINE.............................











//.................method to add items to cart................................

void addToCart(ProductModel product, context){
  _productCartList.add(product);
  showDialog(context: context, builder: (context)=>
  AlertDialog(title: const Text('item add to cart'),
  actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text('Ok'))]
  ));
  notifyListeners();










}
//......................... method to delete the cart items...........................

void clearCart(ProductModel product){
  _productCartList.remove(product);
  notifyListeners();
}






// ..................GETTING FILTER BY SELECTING CATEGORY......................

// Create a setter

List<ProductModel>? _filterbycategory;

// get a setter

List<ProductModel>? get filterbycategory => _filterbycategory;





Future<void> getfilterByCategory({required int categoryId}) async{
  
  // final url = ApiServices.productsUrl;
  // define the ur/l
  final url = 'https://api.escuelajs.co/api/v1/products/?categoryId=$categoryId';
      

  var response = await http.get(Uri.parse(url),
  headers: {'Content-Type': 'application/json'});
  print(response.statusCode);
  print(response.body);


  if(response.statusCode== 200){
    List<dynamic> body = jsonDecode(response.body);

    final data = body.map((e) => ProductModel.fromJson(e)).toList();

    _filterbycategory = data;
    notifyListeners();

  } else {
    print('Something went wrong: ${response.statusCode}');
    throw Exception(' Failed to load data');
  }
}
void clearFilter() {
    _filterbycategory = null;
    notifyListeners();
  }
 
 


}