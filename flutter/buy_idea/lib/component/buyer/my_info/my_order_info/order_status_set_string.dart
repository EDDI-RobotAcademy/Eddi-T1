class OrderStatusTypeChange{

  setString(String statusValue){
    switch (statusValue) {
      case 'PAYMENT_COMPLETE':
        return '결제 완료';
      case 'DELIVERING':
        return '배송중';
      case 'DELIVERED':
        return '배송 완료';
      case 'CANCEL':
        return '취소';
      case 'EXCHANGE':
        return '교환';
      case 'REFUND':
        return '환불';
    }
  }

}