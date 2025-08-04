import 'package:flutter/material.dart';
import 'package:online_shop_app/appstyles/app_colors.dart';
import 'package:online_shop_app/model/product_model.dart';
import 'package:online_shop_app/provider/product_provider.dart';
import 'package:online_shop_app/screens/cart_screen.dart';
import 'package:provider/provider.dart';





class ProductDetails extends StatelessWidget {
  final ProductModel products;
  const ProductDetails({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  // boxShadow: [BoxShadow(
                  //   color: AppColors.redColor,
                  //   blurRadius: 5,
                  //   offset: Offset(0, -2)
                  // )]
                ),
                height: 550,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Hero(
                    tag: products.id!,
                    child: Image.network(products.images[0], fit: BoxFit.cover,))),),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${products.category!.name}',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                            Text("\$${products.price}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                           
                          ],
                        ),
                         Text('${products.title}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),),
                         SizedBox(height: 20,),
                         Text('${products.description}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                         SizedBox(height: 80,),
      
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 220,
                            height: 70,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.redColor
                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                                }, child: Text('Buy Now', style: TextStyle(color: Colors.white, fontSize: 25),)),
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 101, 101, 101),
                                shape: BoxShape.circle
                              ),
                              child: IconButton(onPressed: (){
                                context.read<ProductProvider>().addToCart(products, context);
                              }, icon: Icon(Icons.shopping_cart, color: AppColors.redColor,),)
                            )
                          ],
                         )
                      ],
                    ),
                  )
      
      
            ],
          ),
          Positioned(
            top: 50,
            left: 30,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios, color: AppColors.redColor,)),
            )),
            Positioned(
            top: 50,
            right: 30,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite, color: Colors.red,)),
            )),
        ],
      ),
    );
  }
}