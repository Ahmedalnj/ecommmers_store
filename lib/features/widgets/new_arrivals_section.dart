import 'package:ecommmers_store/models/product.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';

class NewArrivalsSection extends StatelessWidget {
  final List<Product> newProducts;

  const NewArrivalsSection({
    super.key,
    required this.newProducts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          _buildSectionHeader(),
          
          const SizedBox(height: 10),
          
          // Subtitle
          _buildSectionSubtitle(),
          
          const SizedBox(height: 20),
          
          // New Products Horizontal List
          _buildNewProductsList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'New Arrivals',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'NEW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionSubtitle() {
    return const Text(
      "You've never seen it before!",
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildNewProductsList() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newProducts.length,
        itemBuilder: (context, index) {
          return Container(
            width: 180,
            margin: EdgeInsets.only(
              right: index < newProducts.length - 1 ? 16 : 0,
            ),
            child: ProductCard(product: newProducts[index]),
          );
        },
      ),
    );
  }
}