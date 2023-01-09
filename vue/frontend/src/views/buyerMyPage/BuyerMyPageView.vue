<template>
  <div>
    <buyer-my-page-form/>
  </div>
</template>

<script>

import BuyerMyPageForm from "@/components/buyerMyPage/BuyerMyPageForm";
import {mapActions} from "vuex";

export default {
  name: "buyerMyPageView",
  components: {BuyerMyPageForm},
  methods: {
    ...mapActions([
        'requestMyOrderInfoListFromSpring'
    ])
  },
  async mounted() {
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname
    await this.requestMyOrderInfoListFromSpring(nickname)
  }
}
</script>

<style scoped>

</style>