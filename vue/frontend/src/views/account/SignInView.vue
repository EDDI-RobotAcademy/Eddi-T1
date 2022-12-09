<template>
  <v-container>
    <sign-in-form @submit="onSubmit"/>
  </v-container>
</template>

<script>
import SignInForm from "@/components/account/SignInForm";
import {mapActions, mapState} from "vuex";
export default {
  name: "SignInView",
  components: {SignInForm},
  methods: {
    ...mapActions(['requestBuyerSignInToSpring']),
    ...mapState(['memberInfoAfterSignIn']),
    async onSubmit(payload) {
      const { memberId, password, memberType } = payload
      console.log(payload)
      console.log(memberId)
      console.log(password)
      console.log(memberType)
      await this.requestBuyerSignInToSpring({ memberId, password, memberType })

      if(localStorage.getItem('userToken') == null){
        localStorage.setItem("userToken", JSON.stringify(this.$store.state.memberInfoAfterSignIn.userToken))

        alert("로그인 성공")
     }else{
        alert("이미 로그인 되어있습니다.")
      }
    }
  }
}
</script>

<style scoped>

</style>