<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="80" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        ๐ Order Manage
      </v-toolbar-title>
    </v-app-bar>

    <v-simple-table>
      <template v-slot:default>
        <thead>
        <tr>
          <th class="text-center">
            <h2>ํ๋งค์ {{ nickname }} ๋์ ์ฃผ๋ฌธ์ฒ๋ฆฌ ํํฉ</h2>
          </th>
        </tr>
        </thead>
      </template>
    </v-simple-table>


    <v-expansion-panels focusable>


      <!--๊ฒฐ์  ์๋ฃ-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestPaymentCompletedList">{{ paymentComplete }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm :order-status="paymentComplete" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--๋ฐฐ์ก ์ค-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestInDeliveryList">{{ inDelivery }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm :order-status="inDelivery" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--๋ฐฐ์ก ์๋ฃ-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestDeliveryCompletedList">{{ deliveryCompleted }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm :order-status="deliveryCompleted" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--์ทจ์-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestDeliveryCanceledList">{{ Canceled }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm :order-status="Canceled" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--๊ตํ-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestExchangedList">{{ exchanged }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm  :order-status="exchanged" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--๋ฐํ-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestReturnedList">{{ returned }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm  :order-status="returned" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

    </v-expansion-panels>

  </v-container>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";
import OrderStatusForm from "@/components/orderStatus/OrderStatusForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "OrderManageForm",
  components: {OrderStatusForm, SellerNavi},
  props: {},
  computed: {
    ...mapState([
      'sellerOrderList'
    ]),

  },



  methods: {
    ...mapActions([
      'requestSellerOrderListFromSpring'
    ]),

   async requestPaymentCompletedList() {
      console.log("requestPaymentCompleteList()")

        const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
        const orderStatus = this.paymentComplete;

         console.log(nickname)

        await this.requestSellerOrderListFromSpring({nickname, orderStatus})

    },


    async requestInDeliveryList() {
      console.log("requestInDeliveryList()")

      const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
      const orderStatus = this.inDelivery;

      console.log(nickname)
      await this.requestSellerOrderListFromSpring({nickname, orderStatus})
    },


    async requestDeliveryCompletedList() {
      console.log("requestDeliveryCompletedList()")

      const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
      const orderStatus = this.deliveryCompleted;

      console.log(nickname)
      await this.requestSellerOrderListFromSpring({nickname, orderStatus})
    },


    async requestDeliveryCanceledList() {
      console.log("requestDeliveryCanceledList()")

      const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
      const orderStatus = this.Canceled;

      console.log(nickname)
      await this.requestSellerOrderListFromSpring({nickname, orderStatus})
    },


    async requestExchangedList() {
      console.log("requestExchangedList()")

      const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
      const orderStatus = this.exchanged;

      console.log(nickname)
      await this.requestSellerOrderListFromSpring({nickname, orderStatus})
    },


    async requestReturnedList() {
      console.log("requestReturnedList()")

      const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
      const orderStatus = this.returned;

      console.log(nickname)
      await this.requestSellerOrderListFromSpring({nickname, orderStatus})
    },


  },

  data() {
    return {
      nickname: this.$store.state.memberInfoAfterSignIn.nickname,


      paymentComplete: "๊ฒฐ์  ์๋ฃ",
      inDelivery: "๋ฐฐ์ก์ค",
      deliveryCompleted: "๋ฐฐ์ก ์๋ฃ",
      Canceled: "์ทจ์",
      exchanged: "๊ตํ",
      returned: "ํ๋ถ",

    }
  },

}
</script>

<style scoped>

</style>