<template>
  <order-manage-form :number-of-payment-complete="NumberOfPaymentComplete"
                     :number-of-in-delivery="NumberOfInDelivery"
                     :number-of-delivery-completed="NumberOfDeliveryCompleted"
                     :number-of-canceled="NumberOfCanceled"
                     :number-of-exchanged="NumberOfExchanged"
                     :number-of-returned="NumberOfReturned"
  />
</template>

<script>
import OrderManageForm from "@/components/seller/OrderManageForm";
import {mapActions} from "vuex";
export default {
  name: "OrderManageView",
  components: {OrderManageForm},

  async mounted() {

    const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
    await this.requestSellerOrderListCountFromSpring(nickname)

    this.NumberOfPaymentComplete = this.$store.state.sellerOrderListCount[0];
    this.NumberOfInDelivery = this.$store.state.sellerOrderListCount[1];
    this.NumberOfDeliveryCompleted = this.$store.state.sellerOrderListCount[2];
    this.NumberOfCanceled = this.$store.state.sellerOrderListCount[3];
    this.NumberOfExchanged = this.$store.state.sellerOrderListCount[4];
    this.NumberOfReturned = this.$store.state.sellerOrderListCount[5];


  },

  data() {
    return{
      paymentComplete:"결제 완료",
      NumberOfPaymentComplete: 0,
      inDelivery: "배송중",
      NumberOfInDelivery: 0,
      deliveryCompleted: "배송 완료",
      NumberOfDeliveryCompleted: 0,
      canceled: "취소",
      NumberOfCanceled: 0,
      exchanged: "교환",
      NumberOfExchanged: 0,
      returned: "환불",
      NumberOfReturned: 0,
      // orderStatus: [
      //   {status: "결제 완료"},
      //   {status: "배송중"},
      //   {status: "배송 완료"},
      //   {status: "취소"},
      //   {status: "교환"},
      //   {status: "환불"},
      // ],
    }
  },
  methods: {
    ...mapActions([
      'requestSellerOrderListCountFromSpring'
    ])
  },

}


</script>

<style scoped>

</style>