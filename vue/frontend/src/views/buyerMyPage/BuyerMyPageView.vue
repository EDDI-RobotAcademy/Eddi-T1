<template>
  <div>
    <buyer-order-info-page-form/>
  </div>
</template>

<script>

import {mapActions} from "vuex";
import BuyerOrderInfoPageForm from "@/components/buyerMyPage/BuyerOrderInfoPageForm";

export default {
  name: "buyerMyPageView",
  components: {BuyerOrderInfoPageForm},
  methods: {
    ...mapActions([
        'requestMyOrderInfoListFromSpring',
        'requestMyQnaListFromSpring'
    ])
  },
  async mounted() {
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname
    await this.requestMyOrderInfoListFromSpring(nickname)

    const writer = nickname
    await this.requestMyQnaListFromSpring(writer)
  }
}
</script>

<style scoped>

</style>