class ProductModel {
  final String productId,
      storeId,
      englishName,
      arabicName,
      englishDescription,
      storeName,
      arabicDescription;
  final List<String> productPictures;
  final int quantity, ordersCount;
  final double price;
  ProductModel(
      {required this.productId,
      required this.storeId,
      required this.englishName,
      required this.arabicName,
      required this.englishDescription,
      required this.storeName,
      required this.arabicDescription,
      required this.productPictures,
      required this.quantity,
      required this.ordersCount,
      required this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productId: json['id'].toString(),
        storeId: json['store_id'].toString(),
        englishName: json['en_name'],
        arabicName: json['ar_name'],
        englishDescription: json['en_description'],
        storeName: json['store_name'],
        arabicDescription: json['ar_description'],
        productPictures:
            List<String>.from(json['images'].map((image) => image['url'])),
        quantity: json['quantity'],
        ordersCount: json['orders_count'],
        price: double.parse(json['price']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'store_id': storeId,
      'en_name': englishName,
      'ar_name': arabicName,
      'en_description': englishDescription,
      'store_name': storeName,
      'ar_description': arabicDescription,
      'images': productPictures,
      'quantity': quantity,
      'orders_count': ordersCount,
      'price': price,
    };
  }
}
