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
  mounted() {
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname
    this.requestMyOrderInfoListFromSpring(nickname)
    console.log(nickname)
  }
}
</script>

<style scoped>

</style>