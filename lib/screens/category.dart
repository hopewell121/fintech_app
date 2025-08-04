import 'package:flutter/material.dart';
import 'package:online_shop_app/appstyles/app_colors.dart';
import 'package:online_shop_app/provider/product_provider.dart';
import 'package:online_shop_app/screens/categories_details.dart';

import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  // void fetchCategory() async {
  //   Provider.of<ProductProvider>(context, listen: false).getCategories();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchCategory();
  // }
  @override
  Widget build(BuildContext context) {
    final categories = context.watch<ProductProvider>().categories;
    print('List of categoris: $categories');
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                icon: Image.asset('images/menu.png'),
              ),
            ),
            const Column(
              children: [
                Text(
                  'Category',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            CircleAvatar(
              child: Image.asset('images/profilepics.png'),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,

      body: Consumer<ProductProvider>(
        builder: (context, categories, child){
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesDetails()));
            },
            child: GridView.builder(
              itemCount: categories.categories!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              
              childAspectRatio: 0.75),
               itemBuilder: (context, index){
                final newCateries = categories.categories![index];
                return categories.categories == null?
                Center(child: CircularProgressIndicator(),):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(30),
                      child: Image.network(newCateries.image.toString())),
                    Text(newCateries.name.toString())
                    ],
                  ),
                );
               }),
          );
        })

    );
  }
}