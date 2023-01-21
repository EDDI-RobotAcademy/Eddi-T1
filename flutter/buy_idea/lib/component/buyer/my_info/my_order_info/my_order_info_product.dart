List<MyOrderInfoProduct> myOrderInfoList = [];
List<DeliveryAddress> myOrderAddressList = [];

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

class DeliveryAddress {
  String orderNo, recipient, phone, zipcode, city, street, addressDetail;

  DeliveryAddress({
    required this.orderNo,
    required this.recipient,
    required this.phone,
    required this.zipcode,
    required this.city,
    required this.street,
    required this.addressDetail,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
        orderNo: json['orderNo'],
        recipient: json['deliveryAddress']['recipient'],
        phone: json['deliveryAddress']['phone'],
        zipcode: json['deliveryAddress']['zipcode'],
        city: json['deliveryAddress']['city'],
        street: json['deliveryAddress']['street'],
        addressDetail: json['deliveryAddress']['addressDetail']);
  }
}