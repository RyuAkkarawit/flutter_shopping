import 'package:flutter/material.dart';
import 'package:shopping_cart/item.dart';

class CartItem extends StatefulWidget {
  final Item items;
  final VoidCallback onQuantityChanged; // เพิ่มพารามิเตอร์ onQuantityChanged

  const CartItem({
    super.key,
    required this.items,
    required this.onQuantityChanged, // กำหนดในคอนสตรักเตอร์
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.items.amount;
  }

  void _updateQuantity(int change) {
    setState(() {
      quantity = (quantity + change).clamp(0, double.infinity).toInt();
      widget.items.amount = quantity;
    });
    widget.onQuantityChanged(); // เรียก callback เพื่ออัปเดตยอดรวม
  }

  @override
  void didUpdateWidget(covariant CartItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      quantity = widget.items.amount; // อัปเดตค่า quantity จาก item
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.items.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Price: ${widget.items.price}',
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => _updateQuantity(-1),
            ),
            Text(
              '$quantity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _updateQuantity(1),
            ),
          ],
        ),
      ],
    );
  }
}
