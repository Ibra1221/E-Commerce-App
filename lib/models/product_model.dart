class Dimensions {
  num? width;
  num? height;
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

class Review {
  num? rating;
  String? comment;
  String? date;
  String? reviewerName;
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

class Meta {
  String? createdAt;
  String? updatedAt;
  String? barcode;
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

class ProductModel {
  num? id;
  String? title;
  String? description;
  String? category;
  num? price;
  num? discountPercentage;
  num? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  num? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Review>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  Meta? meta;
  String? thumbnail;
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
