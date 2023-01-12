<template>
<div>
  <buyer-qna-form/>
</div>
</template>

<script>
import BuyerQnaForm from "@/components/buyerMyPage/BuyerQnaForm";
import {mapActions} from "vuex";
export default {
  name: "BuyerQnaView",
  components: {BuyerQnaForm},
  methods: {
    ...mapActions([
        'requestMyQnaListFromSpring'
    ])
  },
  async mounted() {
    const writer = this.$store.state.memberInfoAfterSignIn.nickname
    await  this.requestMyQnaListFromSpring(writer)
  }
}
</script>

<style scoped>

</style>