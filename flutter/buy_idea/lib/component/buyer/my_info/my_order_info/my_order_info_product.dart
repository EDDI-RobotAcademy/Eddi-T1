List<MyOrderInfoProduct> myOrderInfoList = [];

class MyOrderInfoProduct {
  String title, image, nickname, orderStatus, orderNo, orderDate;
  int productNo, price, deliveryFee, quantity;

  MyOrderInfoProduct({
    required this.title,
    required this.image,
    required this.nickname,
    required this.orderStatus,
    required this.productNo,
    required this.price,
    required this.deliveryFee,
    required this.orderDate,
    required this.quantity,
    required this.orderNo,
  });

  factory MyOrderInfoProduct.fromJson(Map<String, dynamic> json) {
    return MyOrderInfoProduct(
        title: json['product']['title'],
        image: json['product']['productImages'][0]['editedName'],
        nickname: json['product']['nickname'],
        productNo: json['product']['productNo'],
        orderStatus: json['orderStatus'],
        price: json['product']['price'],
        deliveryFee: json['product']['productInfo']['deliveryFee'],
        orderDate: json['orderDate'],
        quantity: json['quantity'],
        orderNo: json['orderNo']);
  }
}

class Address {
  String orderNo, recipient, phone, zipcode, city, street, addressDetail;

  Address({
    required this.orderNo,
    required this.recipient,
    required this.phone,
    required this.zipcode,
    required this.city,
    required this.street,
    required this.addressDetail,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        orderNo: json['orderNo'],
        recipient: json['recipient'],
        phone: json['phone'],
        zipcode: json['zipcode'],
        city: json['city'],
        street: json['street'],
        addressDetail: json['addressDetail']);
  }
}