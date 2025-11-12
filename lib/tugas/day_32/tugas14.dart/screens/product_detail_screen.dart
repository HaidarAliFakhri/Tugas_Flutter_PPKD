import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/day_19/model/cart_model.dart';

import '../model/fakestore.dart';
import '../model/review_model.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final ListStore product;
  static List<CartItem> cart = [];
  const ProductDetailScreen({required this.product, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool addedToCart = false;
  final List<Review> _reviews = [
    Review(
      username: 'Haidar',
      rating: 4.5,
      comment: 'Kualitas bagus banget, sesuai deskripsi!',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Review(
      username: 'Ali',
      rating: 5.0,
      comment: 'Cepat sampai dan barang ori 💯',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  final _commentController = TextEditingController();
  double _newRating = 5.0;

  void _addToCart() {
    setState(() {
      ProductDetailScreen.cart.add(CartItem(product: widget.product));
      addedToCart = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Berhasil ditambahkan ke keranjang 🛒'),
        backgroundColor: Colors.green.shade400,
      ),
    );
  }

  void _addReview() {
    if (_commentController.text.trim().isEmpty) return;

    setState(() {
      _reviews.insert(
        0,
        Review(
          username: "User",
          rating: _newRating,
          comment: _commentController.text.trim(),
          date: DateTime.now(),
        ),
      );
      _commentController.clear();
      _newRating = 5.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? ''),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CartScreen(cartItems: ProductDetailScreen.cart),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'product_image_${widget.product.id}',
                child: Image.network(
                  widget.product.image ?? '',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.product.title ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "\$${widget.product.price?.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    "${widget.product.rating?.rate ?? 0} "
                    "(${widget.product.rating?.count ?? 0} ratings)",
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(widget.product.description ?? ''),
              const SizedBox(height: 24),

              // 🛒 Tombol Add to Cart
              Center(
                child: ElevatedButton.icon(
                  onPressed: addedToCart ? null : _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: Text(
                    addedToCart ? 'Sudah di Keranjang' : 'Tambah ke Keranjang',
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Divider(),

              // 🧾 Bagian Ulasan
              const Text(
                "Ulasan Produk",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // ✍️ Form Tambah Ulasan
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text("Rating: "),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Slider(
                              value: _newRating,
                              min: 1,
                              max: 5,
                              divisions: 4,
                              label: _newRating.toString(),
                              activeColor: Colors.amber,
                              onChanged: (value) {
                                setState(() => _newRating = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          labelText: 'Tulis ulasan kamu...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _addReview,
                        icon: const Icon(Icons.send),
                        label: const Text("Kirim Ulasan"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 📋 Daftar Ulasan
              ..._reviews.map((review) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      review.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < review.rating.round()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(review.comment),
                        Text(
                          "${review.date.toLocal()}".split(' ')[0],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
