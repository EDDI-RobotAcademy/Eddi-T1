<template>
  <v-container>
    <CommonSignUpForm v-bind:sign-up-type-title="signUpTypeTitle"
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
      memberType: "일반회원",
    }
  },
  methods: {
    ...mapActions(['requestBuyerRegisterToSpring']),
    async onSubmit(payload) {
      const { memberId, password, nickname, memberType } = payload
      await this.requestBuyerRegisterToSpring({ memberId, password, nickname, memberType } )
    }
  }
}
</script>

<style scoped>

</style>