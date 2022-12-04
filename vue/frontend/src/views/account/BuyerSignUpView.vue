<template>
  <v-container>
    <CommonSignUpForm v-bind:sign-up-type-title="signUpTypeTitle"
                      v-bind:sign-up-type-btn="signUpTypeBtn"/>
  </v-container>
</template>

<script>
import CommonSignUpForm from "@/components/account/CommonSignUpForm";

export default {
  name: "BuyerSignUpView",
  components: {CommonSignUpForm},
  data() {
    return {
      signUpTypeTitle: "일반회원 회원가입",
      signUpTypeBtn: "닉네임",
    }
  }
}
</script>

<style scoped>

</style>