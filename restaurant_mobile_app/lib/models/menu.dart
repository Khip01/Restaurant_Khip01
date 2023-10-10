class Menu {
  final int Id;
  final String MenuName;
  final String Description;
  final double Price;

  Menu({
    required this.Id,
    required this.MenuName,
    required this.Description,
    required this.Price,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      Id: json['id'],
      MenuName: json['menu_name'],
      Description: json['description'],
      Price: json['price'].toDouble(),
    );
  }
}
