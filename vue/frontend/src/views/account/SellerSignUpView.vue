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
  name: "SellerSignUpView",
  components: {CommonSignUpForm},
  data() {
    return {
      signUpTypeTitle: "판매자 회원가입",
      signUpTypeBtn: "상호명",
    }
  },
  methods: {
    ...mapActions(['requestSellerSignUpToSpring']),
    async onSubmit(payload) {
      const {memberId, nickname, password, memberType} = payload
      await this.requestSellerSignUpToSpring({memberId, nickname, password, memberType})
    }
  }
}
</script>

<style scoped>

</style>