import 'package:flutter/material.dart';
import 'package:online_shop_app/appstyles/app_colors.dart';
import 'package:online_shop_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> itemQuantities = []; // Store quantities for each item
  double totalprice = 0;
  List<bool> checkboxStates = []; // Store checkbox states for each item

  void incrementCounter(int index) {
    setState(() {
      itemQuantities[index]++;
      updateTotalPrice();
    });
  }

  void decrementCount(int index) {
    setState(() {
      if (itemQuantities[index] > 1) {
        itemQuantities[index]--;
        updateTotalPrice();
      }
    });
  }

  void updateTotalPrice() {
    final cartlist = Provider.of<ProductProvider>(context, listen: false);
    totalprice = 0;
    for (int i = 0; i < cartlist.productCartList.length; i++) {
      if (checkboxStates[i]) {
        totalprice += itemQuantities[i] * (cartlist.productCartList[i].price ?? 0);
      }
    }
  }

  void addToCartItems() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have successfully added this item')),
    );
  }

  bool isAnyCheckboxChecked() {
    return checkboxStates.any((state) => state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartlist = Provider.of<ProductProvider>(context, listen: false);
      setState(() {
        checkboxStates = List<bool>.filled(cartlist.productCartList.length, true);
        itemQuantities = List<int>.filled(cartlist.productCartList.length, 1);
        updateTotalPrice();
      });
    });
  }

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
                  // Navigator.pop(context);
                },
                icon: Image.asset('images/menu.png'),
              ),
            ),
            const Column(
              children: [
                Text(
                  'Cart List',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            CircleAvatar(
              child: Image.asset('images/profilepics.png'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, cartlist, child) {
                if (checkboxStates.length != cartlist.productCartList.length) {
                  checkboxStates = List<bool>.filled(cartlist.productCartList.length, true);
                  itemQuantities = List<int>.filled(cartlist.productCartList.length, 1);
                  updateTotalPrice();
                }
                return ListView.builder(
                  itemCount: cartlist.productCartList.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartlist.productCartList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: SizedBox(
                        height: 140,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.network(
                                            cartItem.images[0],
                                            height: 120,
                                            width: 90,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10, right: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      cartItem.title ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                  Transform.scale(
                                                    scale: 1.4,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 20),
                                                      child: Checkbox(
                                                        focusColor: AppColors.redColor,
                                                        activeColor: AppColors.redColor,
                                                        value: checkboxStates[index],
                                                        onChanged: (bool? value) {
                                                          setState(() {
                                                            checkboxStates[index] = value ?? true;
                                                            updateTotalPrice();
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 30),
                                              Text(
                                                '\$${(cartItem.price ?? 0).toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                    fontSize: 20, fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 60,
                              bottom: 10,
                              child: IconButton(
                                onPressed: () => decrementCount(index),
                                icon: const Icon(Icons.minimize, size: 18),
                              ),
                            ),
                            Positioned(
                              right: 50,
                              bottom: 20,
                              child: Text('${itemQuantities[index]}'),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 5,
                              child: IconButton(
                                onPressed: () => incrementCounter(index),
                                icon: const Icon(Icons.add, size: 18),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 40,
                              child: IconButton(
                                onPressed: () {
                                  context.read<ProductProvider>().clearCart(cartItem);
                                  setState(() {
                                
                                    updateTotalPrice();
                                  });
                                },
                                icon: Icon(Icons.delete, size: 25, color: AppColors.redColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (isAnyCheckboxChecked())
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
                          const Text(
                            'Total',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            '\$${totalprice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 180,
                        height: 75,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: AppColors.redColor,
                          ),
                          onPressed: addToCartItems,
                          child: const Text(
                            'Pay Now',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
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