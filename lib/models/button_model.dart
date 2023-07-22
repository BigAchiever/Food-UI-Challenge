class ButtonModel {
  final String text;
  bool isPressed;

  ButtonModel({required this.text, this.isPressed = false});
}

List<ButtonModel> buttons = [
  ButtonModel(text: "Salad"),
  ButtonModel(text: "Pizza"),
  ButtonModel(text: "Burger"),
  ButtonModel(text: "Pasta"),
  ButtonModel(text: "Noodle"),
  ButtonModel(text: "Soup"),
  ButtonModel(text: "Steak"),
  ButtonModel(text: "Dessert"),
];
