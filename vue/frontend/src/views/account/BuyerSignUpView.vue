<template>
  <v-container>
    <CommonSignUpForm @submit="onSubmit" v-bind:sign-up-type-title="signUpTypeTitle"
                      v-bind:sign-up-type-btn="signUpTypeBtn"/>
  </v-container>
</template>

<script>
import CommonSignUpForm from "@/components/account/CommonSignUpForm";
import {mapActions} from "vuex";

export default {
  name: "BuyerSignUpView",
  components: {CommonSignUpForm},
  data() {
    return {
      signUpTypeTitle: "일반회원 회원가입",
      signUpTypeBtn: "닉네임",
    }
  },
  methods: {
    ...mapActions(['requestBuyerSignUpToSpring']),
    async onSubmit(payload) {
      const { memberId, nickname, password, memberType } = payload
      await this.requestBuyerSignUpToSpring({ memberId, nickname, password, memberType })
    }
  }
}
</script>

<style scoped>

</style>