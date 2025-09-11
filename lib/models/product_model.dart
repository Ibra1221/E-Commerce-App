import 'package:hive/hive.dart';

part 'product_model.g.dart';


@HiveType(typeId: 0)
class Dimensions {
  @HiveField(0)
  num? width;
  @HiveField(1)
  num? height;
  @HiveField(2)
  num? depth;

  Dimensions({this.width, this.height, this.depth});
  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json['width'],
      height: json['height'],
      depth: json['depth'],
    );
  }
}

@HiveType(typeId: 1)
class Review {
  @HiveField(0)
  num? rating;
  @HiveField(1)
  String? comment;
  @HiveField(2)
  String? date;
  @HiveField(3)
  String? reviewerName;
  @HiveField(4)
  String? reviewerEmail;
  Review({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
}

@HiveType(typeId: 2)
class Meta {
  @HiveField(0)
  String? createdAt;
  @HiveField(1)
  String? updatedAt;
  @HiveField(2)
  String? barcode;
  @HiveField(3)
  String? qrCode;
  Meta({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta (
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    barcode: json['barcode'],
    qrCode: json['qrCode'],
    );
  }
}

@HiveType(typeId: 3)
class ProductModel {
  @HiveField(0)
  num? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? category;
  @HiveField(4)
  num? price;
  @HiveField(5)
  num? discountPercentage;
  @HiveField(6)
  num? rating;
  @HiveField(7)
  int? stock;
  @HiveField(8)
  List<String>? tags;
  @HiveField(9)
  String? brand;
  @HiveField(10)
  String? sku;
  @HiveField(11)
  num? weight;
  @HiveField(12)
  Dimensions? dimensions;
  @HiveField(13)
  String? warrantyInformation;
  @HiveField(14)
  String? shippingInformation;
  @HiveField(15)
  String? availabilityStatus;
  @HiveField(16)
  List<Review>? reviews;
  @HiveField(17)
  String? returnPolicy;
  @HiveField(18)
  int? minimumOrderQuantity;
  @HiveField(19)
  Meta? meta;
  @HiveField(20)
  String? thumbnail;
  @HiveField(21)
  List<String>? images;
  
  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.thumbnail,
    this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var tagList = json['tags'] as List?;
    List<String> tags = tagList != null ? List<String>.from(tagList) : [];

    var reviewList = json['reviews'] as List?;
    List<Review> reviews = reviewList != null
        ? reviewList.map((i) => Review.fromJson(i)).toList()
        : [];

    var imageList = json['images'] as List?;
    List<String> images = imageList != null ? List<String>.from(imageList) : [];

    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      stock: json['stock'],
      tags: tags,
      brand: json['brand'],
      sku: json['sku'],
      weight: json['weight'],
      dimensions: json['dimensions'] != null
          ? Dimensions.fromJson(json['dimensions'])
          : null,
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews: reviews,
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      thumbnail: json['thumbnail'],
      images: images,
    );
  }
}
