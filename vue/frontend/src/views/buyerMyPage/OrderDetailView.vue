<template>
  <order-detail-form :orderNo="orderNo"/>
</template>

<script>
import OrderDetailForm from "@/components/buyerMyPage/OrderDetailForm";
import {mapActions} from "vuex";
export default {
  name: "OrderDetailView",
  components: {OrderDetailForm},
  props: {
    orderNo: {
      type: Number,
    }
  },
  methods: {
    ...mapActions([
      'requestMyOrderInfoListFromSpring'
    ])
  },
  mounted() {
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname
    this.requestMyOrderInfoListFromSpring(nickname)
    console.log(nickname)
  }
}
</script>

<style scoped>

</style>