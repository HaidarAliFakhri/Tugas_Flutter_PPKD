import 'package:haidar_ppkd/tugas/day_32/tugas14.dart/model/fakestore.dart';

class CartItem {
  final ListStore product;
  int quantity;
  bool isSelected;

  CartItem({required this.product, this.quantity = 1, this.isSelected = true});

  double get totalPrice => (product.price ?? 0) * quantity;
}
