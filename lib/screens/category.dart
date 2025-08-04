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

  void fetchCategory() async {
    Provider.of<ProductProvider>(context, listen: false).getCategories();
  }

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }
  @override
  Widget build(BuildContext context) {
    final Categories1 = context.watch<ProductProvider>().categories;
    print('List of categoris: $Categories1');
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
                  Navigator.pop(context);
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
      body: Column(
        children: [
          Text('Choose your brand', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          Expanded(
                                
            child: Categories1==null? Center(
              child: CircularProgressIndicator(),):
              ListView.builder(
                itemCount: Categories1.length,
                itemBuilder: (context, index){
            final  Categories2 = Categories1[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesDetails()));
                },
                child: ListTile(
                  subtitle: Text('${Categories2.slug}'),
                  trailing: Text('${Categories2.id}'),
                  leading: Image.network(Categories2.image.toString()),
                  title: Text('${Categories2.name}'),
                ),
              ),
            );
                })
              )
        ],
      )
    );
  }
}