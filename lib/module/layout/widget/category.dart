import 'package:evently/core/const/app_assets.dart';

class Category {
  String id;
  String photo;
  String text;
  Category({required this.text, required this.photo, required this.id});
  static List<Category> items = [
    Category(text: "Sport", photo: AppAssets.byc, id: 'Sport'),
    Category(text: "Birthday", photo: AppAssets.cake, id: 'Birthday'),
    Category(text: "Book Club", photo: AppAssets.book_open, id: 'Book Club'),
    Category(text: "Eating Club", photo: AppAssets.eating, id: 'Eating Club'),
    Category(text: "Workshop Club", photo: AppAssets.workshop, id: 'Workshop Club'),
    Category(text: "Gaming Club", photo: AppAssets.gaming, id: 'Gaming Club'),
    Category(text: "Meeting Club", photo: AppAssets.meetig, id: 'Meeting Club'),
    Category(text: "exhibit Club", photo: AppAssets.exhib, id: 'exhibit Club'),
  ];
}

class CategoryCard {
  String id;
  String photo;
  String text;
  CategoryCard({required this.text, required this.photo, required this.id});
  static List<CategoryCard> items = [
    CategoryCard(text: "Sport", photo: AppAssets.sport, id: 'Sport'),
    CategoryCard(text: "Birthday", photo: AppAssets.birthday, id: 'Birthday'),
    CategoryCard(text: "Book Club", photo: AppAssets.book, id: 'Book Club'),
    CategoryCard(text: "Eating Club", photo: AppAssets.eating, id: 'Eating Club'),
    CategoryCard(text: "Workshop Club", photo: AppAssets.workshop, id: 'Workshop Club'),
    CategoryCard(text: "Gaming Club", photo: AppAssets.gaming, id: 'Gaming Club'),
    CategoryCard(text: "Meeting Club", photo: AppAssets.meetig, id: 'Meeting Club'),
    CategoryCard(text: "exhibit Club", photo: AppAssets.exhib, id: 'exhibit Club'),
  ];
}
