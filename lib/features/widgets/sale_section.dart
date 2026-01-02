import 'package:ecommmers_store/models/product.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class SaleSection extends StatelessWidget {
  final List<Product> products;
  final String title;
  final String subtitle;

  const SaleSection({
    super.key,
    required this.products,
    this.title = 'Sale',
    this.subtitle = 'Super summer sale',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: _buildBackgroundDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          _buildSectionHeader(),
          
          const SizedBox(height: 30),
          
          // Products Grid
          _buildProductsGrid(),
        ],
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFE8EC), Color(0xFFFFF6F8)],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildProductsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}