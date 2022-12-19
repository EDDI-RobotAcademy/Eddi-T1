<template>
  <buyer-info-form @submit="onSubmit"/>
</template>

<script>

import BuyerInfoForm from "@/components/buyerMyPage/BuyerInfoForm";
import {mapActions} from "vuex";

export default {
  name: "BuyerInfoView",
  components: {BuyerInfoForm},
  methods:{
    ...mapActions([
        'requestNicknameModifyFromSpring'
    ]),
    async onSubmit(payload){
      const nickname = payload
      const currentNickname = this.$store.state.memberInfoAfterSignIn.nickname
      await this.requestNicknameModifyFromSpring({nickname, currentNickname})
      await this.$router.push({name: "BuyerMyPageView"})
    }
  }
}
</script>

<style scoped>

</style>