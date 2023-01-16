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
    // const orderStatus = this.paymentComplete;
    for (let i = 0; i < 6; i++) {
      if(i==0){
        const orderStatus = this.paymentComplete
        await this.requestSellerOrderListCountFromSpring({nickname, orderStatus})
        this.NumberOfPaymentComplete = this.$store.state.sellerOrderListCount;
      } else if(i==1){
        const orderStatus = this.inDelivery
        await this.requestSellerOrderListCountFromSpring({nickname, orderStatus})
        this.NumberOfInDelivery = this.$store.state.sellerOrderListCount;
      } else if(i==2){
        const orderStatus = this.deliveryCompleted
        await this.requestSellerOrderListCountFromSpring({nickname, orderStatus})
        this.NumberOfDeliveryCompleted = this.$store.state.sellerOrderListCount;
      } else if(i==3){
        const orderStatus = this.canceled
        await this.requestSellerOrderListCountFromSpring({nickname, orderStatus})
        this.NumberOfCanceled = this.$store.state.sellerOrderListCount;
      } else if(i==4){
        const orderStatus = this.exchanged
        await this.requestSellerOrderListCountFromSpring({nickname, orderStatus})
        this.NumberOfExchanged = this.$store.state.sellerOrderListCount;
      } else if(i==5){
        const orderStatus = this.returned
        await this.requestSellerOrderListCountFromSpring({nickname, orderStatus})
        this.NumberOfReturned = this.$store.state.sellerOrderListCount;
      }
    }

    // for (let i = 0; i < this.orderStatus.length; i++) {
    //   let orderStatus = this.orderStatus[i].status
    //   await this.requestSellerOrderListCountFromSpring({nickname, orderStatus})
    //   this.NumberOfPaymentComplete = this.$store.state.sellerOrderListCount;
    // }


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