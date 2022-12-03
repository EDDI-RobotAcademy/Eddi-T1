<template>
  <v-container>
    <CommonSignUpForm v-bind:sign-up-type-title="signUpTypeTitle"
                      v-bind:sign-up-type-btn="signUpTypeBtn"/>
  </v-container>
</template>

<script>
import CommonSignUpForm from "@/components/account/CommonSignUpForm";

export default {
  name: "SellerSignUpView",
  components: {CommonSignUpForm},
  data() {
    return {
      signUpTypeTitle: "판매자 회원가입",
      signUpTypeBtn: "상호명",
    }
  }
}
</script>

<style scoped>

</style>