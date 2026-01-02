import 'package:ecommmers_store/features/home_screen/models/product.dart';
import 'package:flutter/material.dart';
import '../widgets/sale_section.dart';
import '../widgets/new_arrivals_section.dart';
import '../../../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  
  final List<Product> _saleProducts = [
    Product(
      id: '1',
      brand: 'Dorothy Perkins',
      name: 'Evening Dress',
      imageUrl: '',
      originalPrice: 156,
      salePrice: 123,
      discount: 20,
      rating: 5,
      reviewCount: 10,
    ),
    Product(
      id: '2',
      brand: 'Sitily',
      name: 'Sport Dress',
      imageUrl: '',
      originalPrice: 226,
      salePrice: 195,
      discount: 15,
      rating: 5,
      reviewCount: 10,
    ),
    Product(
      id: '3',
      brand: 'Doro',
      name: 'Special Collection Dress',
      imageUrl: '',
      originalPrice: 149,
      salePrice: 119,
      discount: 20,
      rating: 5,
      reviewCount: 10,
    ),
  ];
  
  final List<Product> _newProducts = [
    Product(
      id: '4',
      brand: 'Summer Collection',
      name: 'Floral Maxi Dress',
      imageUrl: '',
      originalPrice: 89,
      salePrice: 89,
      discount: 0,
      rating: 4.5,
      reviewCount: 8,
      isNew: true,
    ),
    Product(
      id: '5',
      brand: 'Winter Special',
      name: 'Wool Blend Coat',
      imageUrl: '',
      originalPrice: 129,
      salePrice: 129,
      discount: 0,
      rating: 4.8,
      reviewCount: 15,
      isNew: true,
    ),
    Product(
      id: '6',
      brand: 'Casual Wear',
      name: 'Denim Jacket',
      imageUrl: '',
      originalPrice: 75,
      salePrice: 75,
      discount: 0,
      rating: 4.3,
      reviewCount: 12,
      isNew: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Siteer clothes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: _onSearchPressed,
          icon: const Icon(Icons.search),
          tooltip: 'Search',
        ),
        IconButton(
          onPressed: _onNotificationPressed,
          icon: const Icon(Icons.notifications_outlined),
          tooltip: 'Notifications',
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Sale Section
          SaleSection(
            products: _saleProducts,
            title: 'Sale',
            subtitle: 'Super summer sale',
          ),
          
          // New Arrivals Section
          NewArrivalsSection(newProducts: _newProducts),
          
          // Spacing at the bottom
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return SiteerBottomNavBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  void _onSearchPressed() {
    // Implement search functionality
    print('Search pressed');
  }

  void _onNotificationPressed() {
    // Implement notifications functionality
    print('Notifications pressed');
  }
}