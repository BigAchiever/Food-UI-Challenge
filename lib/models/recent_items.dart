final List<DrinkItem> drinkItems = [
  DrinkItem(imagePath: 'assets/honey4.png', name: 'ORANGE'),
  DrinkItem(imagePath: 'assets/honey2.png', name: 'ORANGE'),
  DrinkItem(imagePath: 'assets/honey3.png', name: 'ORANGE'),
];

class DrinkItem {
  final String imagePath;
  final String name;

  DrinkItem({required this.imagePath, required this.name});
}
