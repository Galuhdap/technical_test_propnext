class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final int stock;
  final String category;
  final String thumbnail;
  final List<String> images;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  bool get isLowStock => stock <= 5;

  bool get isOutOfStock => stock == 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          stock == other.stock &&
          category == other.category &&
          thumbnail == other.thumbnail &&
          images == other.images;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      stock.hashCode ^
      category.hashCode ^
      thumbnail.hashCode ^
      images.hashCode;
}
