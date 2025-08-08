import 'package:flutter/material.dart';
import 'package:online_shop_app/appstyles/app_colors.dart';



class CartContainer extends StatefulWidget {
  const CartContainer({super.key});

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
    int myCount = 1;
  double itemsprice = 120;
  double totalprice = 1;

  void incrementcounter(){
    setState(() {
      myCount++;
    });
  }
  
 void decrementcount(){
  setState(() {
    if (myCount>1) {
      myCount--;
    }
    
  });
 }

 void addtocartitems(){
    setState(() {
      
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You have successfully added this items')));
  }





  
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
     num totalprice = myCount * itemsprice;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
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
              Column(
                children: const [
                  Text(
                    'Cart',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              CircleAvatar(
                child: Image.asset('images/profilepics.png'),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Stack(
                    children: [
                      Container(
                        height: 135,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20, top: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Casual V-neck',
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Women Style',
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200),
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Text(
                                              '\$$itemsprice',
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 25),
                                      child: Checkbox(
                                        focusColor: AppColors.redColor,
                                        activeColor: AppColors.redColor,
                                        value: _isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isChecked = value ?? true;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Positioned(
                      //   child: Image.asset('images/female.png'),
                      // ),
                      Positioned(
                        right: 50,
                        bottom: 32,
                        child: IconButton(
                          onPressed: () {
                            decrementcount();
                          },
                          icon: Icon(Icons.minimize, size: 16),
                        ),
                      ),
                      Positioned(
                        right: 43,
                        bottom: 36,
                        child: Text(
                          '$myCount',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 27,
                        child: IconButton(
                          onPressed: () {
                            incrementcounter();
                          },
                          icon: Icon(Icons.add, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), ),
                          Text(
                      '\$$totalprice',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                      ],
                    ),
                     SizedBox(width: 180,
                            height: 70,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.redColor
                                ),
                                onPressed: (){ }, child: Text('Pay Now', style: TextStyle(color: Colors.white, fontSize: 25),)),
                            ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}