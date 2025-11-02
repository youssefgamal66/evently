import 'package:evently/core/routes/app_route_name.dart';
import 'package:evently/module/layout/widget/category.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final Category item;

  CategoryList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        child: SizedBox(
          child: Row(
            children: [
              Image.asset(
                item.photo!,
                color: Colors.white,
                width: 12,
              ),
              const SizedBox(width: 5),
              Text(
                item.text ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 8),
              ),
            ],
          ),
        ),

    );
  }
}
