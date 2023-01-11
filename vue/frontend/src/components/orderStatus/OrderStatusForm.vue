<template>

  <!--<v-expansion-panel>-->
  <!--    <v-expansion-panel-header @click="checkRegistrationNumber">{{Status}}</v-expansion-panel-header>-->
  <!--    <v-expansion-panel-content>-->
  <v-simple-table>
    <template v-slot:default>
      <thead>
      <tr>
        <th class="text-center">
          주문일자
        </th>
        <th class="text-center">
          구매자 닉네임
        </th>
        <th class="text-center">
          카테고리
        </th>
        <th class="text-center">
          상품정보
        </th>
        <th class="text-center">
          수량
        </th>
        <th class="text-center">
          총액
        </th>
        <th class="text-center">
          상태
        </th>
        <th class="text-center">
          주문 상태 변동
        </th>
      </tr>
      </thead>

      <tbody v-for="(item, i) in OrderInfoList" :key="i">

      <tr>
        <th class="text-center">
          {{ item.orderDate }}
        </th>
        <th class="text-center">
          {{ item.buyer }}
        </th>
        <th class="text-center">
          {{ item.product.productInfo.category }}
        </th>
        <th class="text-center">
          {{ item.product.title }}
        </th>
        <th class="text-center">
          {{ item.quantity }}
        </th>
        <th class="text-center">
          {{ item.quantity * item.product.price | comma }}
        </th>
        <th class="text-center">
          {{ orderStatus }}
        </th>
        <th class="text-center">
          <div>
            <v-row justify="center">
              <v-menu transition="slide-x-transition">
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                      color="#FAEBD7"
                      class="ma-2"
                      v-bind="attrs"
                      v-on="on"
                      @click="returnOrderInfo(i)"
                  >
                    주문 상태 변동
                  </v-btn>
                </template>

                <v-list>
                  <v-list-item
                      v-for="(orderStatus, index) in orderStatusList" :key="index"
                      link
                  >
                    <v-list-item-title @click="orderStatusModify(index)">
                      {{ orderStatus.title }}
                    </v-list-item-title>

                  </v-list-item>
                </v-list>

              </v-menu>
            </v-row>
          </div>
        </th>
      </tr>

      </tbody>

    </template>
  </v-simple-table>
  <!--    </v-expansion-panel-content>-->
  <!--</v-expansion-panel>-->

</template>

<script>


import {mapActions} from "vuex";

export default {
  name: "orderStatusForm",
  components: {},
  props: {
    orderStatus: {
      type: String
    },

    OrderInfoList: {
      type: Array
    }

  },
  data() {
    return {
      orderStatusList: [

        {title: '결제 완료'},
        {title: '배송중'},
        {title: '배송 완료'},
        {title: '취소'},
        {title: '교환'},
        {title: '환불'},
      ],

      orderInfoId: 0
    }
  },

  methods: {
    ...mapActions([
      'requestOrderStatusModifyToSpring'
    ]),

    returnOrderInfo(i) {
      //orderInfoList.id를 가져오는 로직.
      this.orderInfoId = this.OrderInfoList[i].id
    },
    async orderStatusModify(index){
      //orderStatusList 배열에 적힌 상태값을 가져오는 로직.
      const orderStatus = this.orderStatusList[index].title
      const orderInfoId = this.orderInfoId
      console.log("orderStatusModify()")

      //const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
      //const orderStatus = this.paymentComplete;

      console.log("변경 후의 주문상태 :" + orderStatus)

      await this.requestOrderStatusModifyToSpring({orderInfoId, orderStatus})

    },
  },

  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },


}
</script>

<style scoped>

</style>