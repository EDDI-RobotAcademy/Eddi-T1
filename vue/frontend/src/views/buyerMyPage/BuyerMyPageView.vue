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
        'requestMyQnaListFromSpring',
        'requestMyReviewListToSpring'
    ])
  },
  async created() {
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname
    await this.requestMyOrderInfoListFromSpring(nickname)

    const writer = nickname
    await this.requestMyQnaListFromSpring(writer)

    await this.requestMyReviewListToSpring(writer)
  }
}
</script>

<style scoped>

</style>