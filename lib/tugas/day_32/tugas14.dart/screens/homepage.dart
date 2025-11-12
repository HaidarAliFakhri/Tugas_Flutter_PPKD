import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/day_32/tugas14.dart/apiService/api_service.dart';
import 'package:haidar_ppkd/tugas/day_32/tugas14.dart/model/fakestore.dart';
import 'package:haidar_ppkd/tugas/day_32/tugas14.dart/screens/cart_screen.dart';

import '../widgets/product_card.dart' as card_widget;
import 'product_detail_screen.dart' as detail_screen;

class HomeScreenTugas14 extends StatefulWidget {
  const HomeScreenTugas14({super.key});

  @override
  State<HomeScreenTugas14> createState() => _HomeScreenTugas14State();
}

class _HomeScreenTugas14State extends State<HomeScreenTugas14>
    with SingleTickerProviderStateMixin {
  final ApiService apiService = ApiService();
  late Future<List<ListStore>> _futureProducts;
  List<ListStore> _allProducts = [];
  List<ListStore> _filteredProducts = [];
  Set<String> _categories = {};
  String _selectedCategory = 'Semua';
  String searchQuery = '';

  // Banner slider
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _futureProducts = _loadProducts();

    // setup banner auto slide
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<List<ListStore>> _loadProducts() async {
    final products = await apiService.getProducts();
    setState(() {
      _allProducts = products;
      _filteredProducts = products;
      _categories = {
        'Semua',
        ...products.map((p) => p.category.toString().split('.').last),
      };
    });
    return products;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await _loadProducts();
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'Semua') {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts = _allProducts
            .where(
              (p) =>
                  p.category.toString().split('.').last.toLowerCase() ==
                  category.toLowerCase(),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        elevation: 0,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() => searchQuery = value.toLowerCase());
            },
            decoration: const InputDecoration(
              hintText: 'Search Produc...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartScreen(
                    cartItems: detail_screen.ProductDetailScreen.cart,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<ListStore>>(
          future: _futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Tidak ada produk'));
            }

            // 🔹 Filter berdasarkan kategori + pencarian
            final products = _filteredProducts
                .where((p) => p.title!.toLowerCase().contains(searchQuery))
                .toList();

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🏷️ Banner promo
                  _buildPromoBanner(),

                  // 🔘 Dots indicator
                  _buildDots(),

                  // 🧭 Kategori dinamis
                  _buildDynamicCategories(colorScheme),

                  // 🧱 Grid produk
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return card_widget.ProductCard(
                          product: product,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    detail_screen.ProductDetailScreen(
                                      product: product,
                                    ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 🟢 Banner promo
  Widget _buildPromoBanner() {
    return SizedBox(
      height: 180,
      child: PageView(
        controller: _pageController,
        children: [
          _bannerItem("assets/images/banner1.png"),
          _bannerItem("assets/images/banner2.png"),
          _bannerItem("assets/images/banner3.png"),
        ],
      ),
    );
  }

  Widget _bannerItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          width: _currentPage == index ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Colors.orangeAccent
                : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  // 🧭 Kategori dinamis dari API
  Widget _buildDynamicCategories(ColorScheme colorScheme) {
    final categoryIcons = {
      "electronics": Icons.devices_other,
      "jewelery": Icons.diamond_outlined,
      "men_s_clothing": Icons.male,
      "women_s_clothing": Icons.female,
    };

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: _categories.map((category) {
          final icon =
              categoryIcons[category.toLowerCase()] ?? Icons.category_outlined;

          final bool isSelected = _selectedCategory == category;

          return GestureDetector(
            onTap: () => _filterByCategory(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 90,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.primary : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: isSelected ? Colors.white : colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category == 'Semua'
                        ? 'Semua'
                        : category.replaceAll('_', ' ').capitalize(),
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ✨ Helper extension
extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
