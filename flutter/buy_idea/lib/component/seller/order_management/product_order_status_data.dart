class ProductOrderStatusData {
   String category;
   String productTitle;
   String productImage;
   int paymentCompleteCount;
   int deliveringCount;
   int deliveredCount;
   int cancelCount;
   int exchangeCount;
   int refundCount;

   ProductOrderStatusData({
     required this.category,
     required this.productTitle,
     required this.productImage,
     required this.paymentCompleteCount,
     required this.deliveringCount,
     required this.deliveredCount,
     required this.cancelCount,
     required this.exchangeCount,
     required this.refundCount,
});

   factory ProductOrderStatusData.fromJson(Map<String, dynamic> json) {
     return ProductOrderStatusData(
         category: json['category'],
         productTitle: json['productTitle'],
         productImage: json['productImage'],
         paymentCompleteCount: json['paymentCompleteCount'],
         deliveringCount: json['deliveringCount'],
         deliveredCount: json['deliveredCount'],
         cancelCount: json['cancelCount'],
         exchangeCount: json['exchangeCount'],
         refundCount: json['refundCount'],
     );
   }
}