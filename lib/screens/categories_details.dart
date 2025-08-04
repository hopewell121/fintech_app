import 'package:flutter/material.dart';
import 'package:online_shop_app/appstyles/app_colors.dart';

class CategoriesDetails extends StatelessWidget {
  const CategoriesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
    );
  }
}