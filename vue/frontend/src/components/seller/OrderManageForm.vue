<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="80" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Order Manage
      </v-toolbar-title>
    </v-app-bar>

    <v-simple-table>
      <template v-slot:default>
        <thead>
        <tr>
          <th class="text-center">
            <h2>판매자 {{ Seller }} 님의 주문처리 현황</h2>
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
            입금 전
          </th>
          <th class="text-center">
            입금완료
          </th>
          <th class="text-center">
            배송 중
          </th>
          <th class="text-center">
            배송완료
          </th>
          <th class="text-center">
            취소
          </th>
          <th class="text-center">
            교환
          </th>
          <th class="text-center">
            반품
          </th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <th class="text-center">
            {{beforeDepositAmount}}
          </th>
          <th class="text-center">
            {{afterDepositAmount}}
          </th>
          <th class="text-center">
            {{inDeliveryAmount}}
          </th>
          <th class="text-center">
            {{deliveryCompletedAmount}}
          </th>
          <th class="text-center">
            {{deliveryCanceledAmount}}
          </th>
          <th class="text-center">
            {{exchangedAmount}}
          </th>
          <th class="text-center">
            {{returnedAmount}}
          </th>
        </tr>
        </tbody>
      </template>
    </v-simple-table><br/><br/>


    <v-expansion-panels focusable>

      <!--입금 전-->
      <OrderStatusForm :status="beforeDeposit" :product-lists="beforeDepositList"></OrderStatusForm>

      <!--입금 완료-->
      <OrderStatusForm :status="afterDeposit" :product-lists="afterDepositList"></OrderStatusForm>

      <!--배송 중-->
      <OrderStatusForm :status="inDelivery" :product-lists="inDeliveryList"></OrderStatusForm>

      <!--배송 완료-->
      <OrderStatusForm :status="deliveryCompleted" :product-lists="deliveryCompletedList"></OrderStatusForm>

      <!--취소-->
      <OrderStatusForm :status="deliveryCanceled" :product-lists="deliveryCanceledList"></OrderStatusForm>

      <!--교환-->
      <OrderStatusForm :status="exchanged" :product-lists="exchangedList"></OrderStatusForm>

      <!--반품-->
      <OrderStatusForm :status="returned" :product-lists="returnedList"></OrderStatusForm>

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

  },
  computed: {
    ...mapState([
      'inDeliveryList'
    ]),

  },
  data () {
    return {

      beforeDeposit: "입금 전",
      afterDeposit: "입금 완료",
      inDelivery: "배송 중",
      deliveryCompleted: "배송 완료",
      deliveryCanceled: "취소",
      exchanged: "교환",
      returned: "반품",


      Seller: "재범티비",

      beforeDepositAmount: 0,
      afterDepositAmount: 1,
      inDeliveryAmount: 2,
      deliveryCompletedAmount: 5,
      deliveryCanceledAmount: 5,
      exchangedAmount: 0,
      returnedAmount: 2,


      beforeDepositList:[],

      afterDepositList:[
        {date: "2022-12-12", buyer: "woqja123", productInformation: "핫초코", amount: 10, totalPrice: 15000, status:"입금 완료" },
      ],

      /*
      inDeliveryList: [
        {date: "2022-12-12", buyer: "ljb123", productInformation: "바닐라빈", amount: 1, totalPrice: 3700, status:"배송 중" },
        {date: "2022-12-13", buyer: "ljb8194", productInformation: "아이스라떼", amount: 1, totalPrice: 3500, status:"배송 중" },
      ],
*/
      deliveryCompletedList: [
        {date: "2022-12-12", buyer: "jbtv1", productInformation: "차카니", amount: 1, totalPrice: 500, status:"배송 완료" },
        {date: "2022-12-12", buyer: "jbtv2", productInformation: "와우", amount: 1, totalPrice: 500, status:"배송 완료" },
        {date: "2022-12-12", buyer: "jbtv3", productInformation: "자일리톨", amount: 1, totalPrice: 2000, status:"배송 완료" },
        {date: "2022-12-12", buyer: "jbtv4", productInformation: "밭두렁", amount: 1, totalPrice: 500, status:"배송 완료" },
        {date: "2022-12-12", buyer: "jbtv5", productInformation: "예감", amount: 1, totalPrice: 1800, status:"배송 완료" },
      ],

      deliveryCanceledList: [
        {date: "2022-12-12", buyer: "jbtv11", productInformation: "슬라임메론빵", amount: 1, totalPrice: 2000, status:"취소" },
        {date: "2022-12-12", buyer: "jbtv22", productInformation: "주황버섯빵", amount: 1, totalPrice: 2500, status:"취소" },
        {date: "2022-12-12", buyer: "jbtv33", productInformation: "좀비버섯빵", amount: 1, totalPrice: 3300, status:"취소" },
        {date: "2022-12-12", buyer: "jbtv44", productInformation: "루팡빵", amount: 1, totalPrice: 2500, status:"취소" },
        {date: "2022-12-12", buyer: "jbtv55", productInformation: "예티빵", amount: 1, totalPrice: 4000, status:"취소" },
      ],

      exchangedList: [],

      returnedList: [
        {date: "2022-12-12", buyer: "jbtva", productInformation: "뿔버섯샌드", amount: 1, totalPrice: 2500, status:"반품" },
        {date: "2022-12-12", buyer: "jbtvb", productInformation: "자쿰손파이", amount: 1, totalPrice: 4000, status:"반품" },
      ],


    }
  },
  mounted() {
    this.requestInDeliveryListFromSpring()
  },
  methods:{
    ...mapActions([
      'requestInDeliveryListFromSpring'
    ])
  },
}
</script>

<style scoped>

</style>