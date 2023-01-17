<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="81" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Order Manage
      </v-toolbar-title>
    </v-app-bar>

    <v-simple-table>
      <template v-slot:default>
        <thead>
        <tr>
          <th class="text-center">
            <h2>실시간 주문 현황</h2>
          </th>
        </tr>
        </thead>
      </template>
    </v-simple-table>

    <v-simple-table>
      <template v-slot:default>
        <thead>
        <tr>
          <th class="text-center">
            {{ paymentComplete }}
          </th>
          <th class="text-center">
            {{inDelivery}}
          </th>
          <th class="text-center">
            {{deliveryCompleted}}
          </th>
          <th class="text-center">
            {{Canceled}}
          </th>
          <th class="text-center">
            {{exchanged}}
          </th>
          <th class="text-center">
            {{returned}}
          </th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td class="text-center">{{ NumberOfPaymentComplete }}</td>
          <td class="text-center">{{ NumberOfInDelivery }}</td>
          <td class="text-center">{{NumberOfDeliveryCompleted}}</td>
          <td class="text-center">{{ NumberOfCanceled }}</td>
          <td class="text-center">{{ NumberOfExchanged }}</td>
          <td class="text-center">{{ NumberOfReturned }}</td>
        </tr>
        </tbody>
      </template>
    </v-simple-table><br/><br/>


    <v-expansion-panels focusable>


      <!--결제 완료-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestPaymentCompletedList">{{ paymentComplete }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm :order-status="paymentComplete" :order-info-list="sellerOrderList" ></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--배송 중-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestInDeliveryList">{{ inDelivery }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm :order-status="inDelivery" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--배송 완료-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestDeliveryCompletedList">{{ deliveryCompleted }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm :order-status="deliveryCompleted" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--취소-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestDeliveryCanceledList">{{ Canceled }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm :order-status="Canceled" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--교환-->
      <v-expansion-panel>
        <v-expansion-panel-header @click="requestExchangedList">{{ exchanged }}</v-expansion-panel-header>
        <v-expansion-panel-content>
          <OrderStatusForm  :order-status="exchanged" :order-info-list="sellerOrderList"></OrderStatusForm>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <!--반품-->
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
  props: {
    NumberOfPaymentComplete: {
      type: Number
    },
    NumberOfInDelivery: {
      type: Number
    },
    NumberOfDeliveryCompleted: {
      type: Number
    },
    NumberOfCanceled: {
      type: Number
    },
    NumberOfExchanged: {
      type: Number
    },
    NumberOfReturned: {
      type: Number
    },
  },
  computed: {
    ...mapState([
      'sellerOrderList'
    ]),

  },



  methods: {
    ...mapActions([
      'requestSellerOrderListFromSpring'
    ]),

    // async mounted() {
    //
    //   const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
    //   const orderStatus = this.paymentComplete;
    //   await this.requestSellerOrderListCountFromSpring(nickname, orderStatus)
    //
    //   console.log(this.$store.state.sellerOrderList);
    //
    //   this.NumberOfPaymentComplete = this.$store.state.sellerOrderList.length;
    //
    //   console.log(this.NumberOfPaymentComplete);
    //
    // },

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

      // NumberOfPaymentComplete: 0,
      // NumberOfInDelivery: 0,
      // NumberOfDeliveryCompleted: 0,
      // NumberOfCanceled: 0,
      // NumberOfExchanged: 0,
      // NumberOfReturned: 0,



      paymentComplete: "결제 완료",
      inDelivery: "배송중",
      deliveryCompleted: "배송 완료",
      Canceled: "취소",
      exchanged: "교환",
      returned: "환불",

    }
  },

}
</script>

<style scoped>

</style>