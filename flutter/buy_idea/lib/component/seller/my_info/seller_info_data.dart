class SellerInfoData {
   String realName;
   String phone;
   String registrationNumber;
   String city;
   String street;
   String addressDetail;
   String zipcode;

  SellerInfoData({
    required this.realName,
    required this.phone,
    required this.registrationNumber,
    required this.city,
    required this.street,
    required this.addressDetail,
    required this.zipcode,
  });

  factory SellerInfoData.fromJson(Map<String, dynamic> json) {
    return SellerInfoData(
      realName: json['realName'],
      phone: json['phone'],
      registrationNumber: json['registrationNumber'],
      city: json['city'],
      street: json['street'],
      addressDetail: json['addressDetail'],
      zipcode: json['zipcode'],

    );
  }
}