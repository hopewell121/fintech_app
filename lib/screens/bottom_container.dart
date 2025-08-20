

import 'package:flutter/material.dart';
import 'package:online_shop_app/appstyles/app_colors.dart';
import 'package:online_shop_app/provider/product_provider.dart';

import 'package:online_shop_app/screens/cart_screen.dart';
import 'package:online_shop_app/screens/category.dart';
import 'package:online_shop_app/screens/home.dart';
import 'package:online_shop_app/screens/profile/profile.dart';
import 'package:provider/provider.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer({super.key});

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  int _selectedIndex = 0;
 static const List<Widget> _bottomNavCategories = [
  HomePage(), Categories(), CartPage(),
  ProfilePage(),
 ];

 void _onItemTapped(int index){
  setState(() {
    _selectedIndex =index;
  });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavCategories.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [BoxShadow(
            color: AppColors.redColor,
            blurRadius: 10,
            offset: Offset(0, -5),
            
          )],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItems(Icons.home, 'Home', 0),
            _buildNavItems(Icons.category, 'Categories', 1),
            _buildNavItems(Icons.shopping_cart, 'Cart', 2),
            _buildNavItems(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }


// ignore: unused_element
Widget _buildNavItems(IconData icon, String label, int index){
  return GestureDetector(
    onTap: () => _onItemTapped(index),

    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      
      Consumer<ProductProvider>(
        builder: (context, cart, _) {
          return Stack(
            children: [
              Icon(icon, color: _selectedIndex==index? AppColors.redColor: Colors.grey),
              CircleAvatar(radius: 8, backgroundColor: index==2? AppColors.redColor: Colors.transparent,
              child: Text(index==2? cart.productCartList.length.toString(): '', style: 
              TextStyle(color: Colors.white, fontSize: 12),)
              )
            ],
          );
        }
      ),
      SizedBox(height: 4,),
      Text(label, style: TextStyle(fontSize: 13, color: _selectedIndex==index? AppColors.redColor: Colors.grey),)
      ],
    ),
  );
}
}


