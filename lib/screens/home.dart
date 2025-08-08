// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:online_shop_app/appstyles/app_colors.dart';
import 'package:online_shop_app/provider/product_provider.dart';
import 'package:online_shop_app/screens/product_details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  int? _currentIndex; // Allow null to represent no category selected (show all products)
  // ignore: unused_field
  bool _isLoading = true; 
  bool _isloading2 = false;

  

  void fetchData() async {
    setState(() {
       _isLoading = true;
    });
    await Provider.of<ProductProvider>(context, listen: false).getProduct();
    await Provider.of<ProductProvider>(context, listen: false).getCategories();
    setState(() {
      _isLoading = false;
      _currentIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
     
  }

@override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final filterProduct = Provider.of<ProductProvider>(context, listen: false);
    final products = context.watch<ProductProvider>().productList;
    final categories = context.watch<ProductProvider>().categories;
    final filterbycategory = context.watch<ProductProvider>().filterbycategory;
    

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 226, 226),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          toolbarHeight: 150,
          backgroundColor: AppColors.backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('images/menu.png'),
                ),
              ),
              const Column(
                children: [
                  Text(
                    'Hello Zakie',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'Jakarta, IND',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
          Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 35),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: (value) {
                              if( value.isNotEmpty){
                                Provider.of<ProductProvider>(context, listen: false).getSearchFilter(title: value);
                              }
                            },
                            decoration: InputDecoration(
                            hintText: 'Search products...',
                              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                              suffixIcon: _isloading2
                              ? Padding(
                                padding: EdgeInsets.all(8),
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                              : IconButton(
                                onPressed: () async{
                                _searchController.clear();
                                setState(()=> _isloading2 = true);
                                await Provider.of<ProductProvider>(context, listen: false).getProduct();
                                setState(()=> _isloading2 = false);
                                
                              }
                              , icon: Icon(Icons.clear,)),

                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(color: AppColors.redColor, width: 2.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                            ),
                            onChanged: (value) {
                              // Add search functionality here if needed
                            },
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.redColor,
                          ),
                          child: Image.asset('images/filter.png'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 400,
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 150, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Big Sale',
                            style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '    Get the trendy',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            '               Fashion at a discount',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            ' of up to 50%',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    child: categories == null
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: categories.length + 1, // Add "All" category
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final isSelected = _currentIndex == index;
                              final categoryName = index == 0 ? 'All' : categories[index - 1].name.toString();
                              final categoryId = index == 0 ? null : categories[index - 1].id;
                             
                              return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                  if (index == 0) {
                                    // Clear filter to show all products
                                    filterProduct.clearFilter();
                                  } else {
                                    // Fetch filtered products by categoryId
                                    await filterProduct.getfilterByCategory(categoryId: categoryId!);
                                    setState(() {
                                    _isLoading = false;
                                  });
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  height: 56,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.redColor : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: isSelected ? AppColors.redColor : Colors.black,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      categoryName,
                                      style: TextStyle(
                                        color: isSelected ? Colors.white : Colors.black,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
              Positioned(
                top: 95,
                child: Image.asset('images/female1.png', height: 165),
              ),
            ],
          ),
          Expanded(
            child: (_currentIndex == null || _currentIndex == 0 || filterbycategory == null)
                ? (products == null
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetails(products: product),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: product.images.isEmpty
                                      ? const Text('No image')
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Hero(
                                            tag: product.id!,
                                            child: Image.network(
                                              product.images[0],
                                              fit: BoxFit.fill,
                                              height: 250,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.title ?? ''),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${product.price?.toStringAsFixed(2)}',
                                          style: const TextStyle(fontWeight: FontWeight.w900),
                                        ),
                                        const Icon(Icons.favorite, color: Colors.red),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ))
                : (filterbycategory.isEmpty
                    ? const Center(child: Text('No products found for this category'))
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                        ),
                        itemCount: filterbycategory.length,
                        itemBuilder: (context, index) {
                          final product = filterbycategory[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetails(products: product),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: product.images.isEmpty
                                      ? const Text('No image')
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Hero(
                                            tag: product.id!,
                                            child: Image.network(
                                              product.images[0],
                                              fit: BoxFit.fill,
                                              height: 250,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.title ?? ''),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${product.price?.toStringAsFixed(2)}',
                                          style: const TextStyle(fontWeight: FontWeight.w900),
                                        ),
                                        const Icon(Icons.favorite, color: Colors.red),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      )),
          ),
        ],
      ),
    );
  }
}