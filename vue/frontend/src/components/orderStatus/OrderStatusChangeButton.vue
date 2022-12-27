<template>
  <div>
    <v-row justify="center">
      <v-menu transition="slide-x-transition">
        <template v-slot:activator="{ on, attrs }">
          <v-btn
              color="primary"
              class="ma-2"
              v-bind="attrs"
              v-on="on"
          >
            주문 상태 변동
          </v-btn>
        </template>
        <v-list>
          <v-list-item
              v-for="(orderStatus, index) in orderStatusList" :key="index"
              link
          >
            <v-list-item-title>
              {{ orderStatus.title }}
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-row>
  </div>
</template>

<script>
export default {
  name: "OrderStatusChangeButton",
  data (){
    return{
      orderStatusList: [

        { title: '입금 완료'},
        { title: '배송 중'},
        { title: '배송 완료'},
        { title: '취소'},
        { title: '교환'},
        { title: '환불'},
      ]
    }
  }
}
</script>

<style scoped>

</style>