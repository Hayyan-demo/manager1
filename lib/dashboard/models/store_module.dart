class StoreModel {
  final String storeId, storeName, logo;
  final int productCount;

  StoreModel(
      {required this.storeId,
      required this.storeName,
      required this.logo,
      required this.productCount});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
        storeId: json['id'].toString(),
        storeName: json['name'],
        logo: json['logo'],
        productCount: json['product_count']);
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'store_name': storeName,
      'logo': logo,
      'product_count': productCount
    };
  }
}
