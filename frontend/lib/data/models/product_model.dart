class Product {
  String? id;
  String? name;
  String? description;
  String? brand;
  num? price;

  Product({
    this.id,
    this.name,
    this.description,
    this.brand,
    this.price,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    brand = json['brand'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "brand": brand,
      "price": price,
    };
  }

  Product copy() {
    return Product(
      id: id,
      description: description,
      name: name,
      brand: brand,
      price: price,
    );
  }
}
