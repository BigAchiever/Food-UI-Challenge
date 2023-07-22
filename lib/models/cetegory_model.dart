final List<SauceItem> sauceItems = [
  SauceItem(
      imagePath: 'assets/banana.png', name: 'Banana', price: '\$72.52/Kg'),
  SauceItem(
      imagePath: 'assets/banana.png', name: 'Banana', price: '\$72.52/Kg'),
  SauceItem(
      imagePath: 'assets/banana.png', name: 'Banana', price: '\$72.52/Kg'),
];

class SauceItem {
  final String imagePath;
  final String name;
  final String price;

  SauceItem({required this.imagePath, required this.name, required this.price});
}
