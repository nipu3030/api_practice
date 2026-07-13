class ReviewModel {
  int? rating;
  String? comment, date, reviewerName, reviewerEmail;

  ReviewModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerEmail,
    required this.reviewerName
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json){
    return ReviewModel(
        rating: json["rating"],
        comment: json["comment"],
        date: json["date"],
        reviewerEmail: json["reviewerEmail"],
        reviewerName: json["reviewerName"]);
  }
}

class MetaModel {
  String? barcode, createdAt, qrCode, updatedAt;

  MetaModel({
    required this.barcode,
    required this.createdAt,
    required this.qrCode,
    required this.updatedAt
  });

  factory MetaModel.fromJson(Map<String, dynamic> json){
    return MetaModel(
        barcode: json["barcode"],
        createdAt: json["createdAt"],
        qrCode: json["qrCode"],
        updatedAt: json["updatedAt"]);
  }
}

class DimensionsModel {
  num? depth, height, width;

  DimensionsModel({
    required this.depth,
    required this.height,
    required this.width
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json){
    return DimensionsModel(
        depth: json["depth"],
        height: json["height"],
        width: json["width"]);
  }
}

class ProductModel {
  String? availabilityStatus, brand, category, description,
      returnPolicy, shippingInformation, sku, thumbnail, title,
      warrantyInformation;
  DimensionsModel? dimensions;
  num? discountPercentage, price, rating;
  int? id, minimumOrderQuantity, stock, weight;
  List<dynamic>? images;
  MetaModel? meta;
  List<ReviewModel>? reviews;
  List<dynamic>? tags;

  ProductModel({
    required this.availabilityStatus,
    required this.brand,
    required this.category,
    required this.description,
    required this.returnPolicy,
    required this.shippingInformation,
    required this.sku,
    required this.thumbnail,
    required this.title,
    required this.warrantyInformation,
    required this.dimensions,
    required this.discountPercentage,
    required this.price,
    required this.rating,
    required this.id,
    required this.minimumOrderQuantity,
    required this.stock,
    required this.weight,
    required this.images,
    required this.meta,
    required this.reviews,
    required this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){

    List<ReviewModel> mReview = [];
    for(Map<String,dynamic> eachReview in json['reviews']){
      mReview.add(ReviewModel.fromJson(eachReview));
    }

    return ProductModel(
        availabilityStatus: json["availabilityStatus"],
        brand: json["brand"],
        category: json["category"],
        description: json["description"],
        returnPolicy: json["returnPolicy"],
        shippingInformation: json["shippingInformation"],
        sku: json["sku"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        warrantyInformation: json["warrantyInformation"],
        dimensions: DimensionsModel.fromJson(json["dimensions"]),
        discountPercentage: json["discountPercentage"],
        price: json["price"],
        rating: json["rating"],
        id: json["id"],
        minimumOrderQuantity: json["minimumOrderQuantity"],
        stock: json["stock"],
        weight: json["weight"],
        images: json["images"],
        meta: MetaModel.fromJson(json["meta"]),
        reviews: mReview,
        tags: json["tags"]);
  }
}