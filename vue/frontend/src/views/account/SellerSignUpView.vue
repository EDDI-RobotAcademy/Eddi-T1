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
  name: "SellerSignUpView",
  components: {CommonSignUpForm},
  data() {
    return {
      signUpTypeTitle: "판매자 회원가입",
      signUpTypeBtn: "상호명",
      memberType: "판매자",
    }
  },
  methods: {
    ...mapActions(['requestSellerRegisterToSpring']),
    async onSubmit(payload) {
      const { memberId, password, nickname, memberType } = payload
      await this.requestSellerRegisterToSpring({ memberId, password, nickname, memberType } )
    }
  }
}
</script>

<style scoped>

</style>