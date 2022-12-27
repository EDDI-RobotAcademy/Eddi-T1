<template>
  <v-expansion-panel>
    <v-expansion-panel-header>{{Status}}</v-expansion-panel-header>
    <v-expansion-panel-content>
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

          <tbody v-for="(item, i) in ProductLists" :key="i" >

          <tr>
            <th class="text-center">
              {{item.date}}
            </th>
            <th class="text-center">
              {{item.buyer}}
            </th>
            <th class="text-center">
              {{item.productInformation}}
            </th>
            <th class="text-center">
              {{item.amount}}
            </th>
            <th class="text-center">
              {{item.totalPrice}}
            </th>
            <th class="text-center">
              {{item.status}}
            </th>
            <th class="text-center">
              <order-status-change-button/>
            </th>
          </tr>

          </tbody>

        </template>
      </v-simple-table>
    </v-expansion-panel-content>
  </v-expansion-panel>
</template>

<script>

import OrderStatusChangeButton from "@/components/orderStatus/OrderStatusChangeButton";
export default {
  name: "orderStatusForm",
  components: {OrderStatusChangeButton},
  props:{
    Status:{
      type:String
    },

    ProductLists:{
      type:Array
    }

  }
}
</script>

<style scoped>

</style>