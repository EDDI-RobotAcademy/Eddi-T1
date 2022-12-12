<template>
  <v-container>
    <sign-in-form @submit="onSubmit"/>
  </v-container>
</template>

<script>
import SignInForm from "@/components/account/SignInForm";
import {mapActions} from "vuex";
export default {
  name: "SignInView",
  components: {SignInForm},
  methods: {
    ...mapActions(['requestBuyerSignInToSpring']),
    async onSubmit(payload) {
      const { memberId, password, memberType } = payload
      console.log(payload)
      console.log(memberId)
      console.log(password)
      console.log(memberType)
      await this.requestBuyerSignInToSpring({ memberId, password, memberType })

      if (localStorage.getItem("userToken") != null){
        await this.$router.push({name: "HomeView"})
        this.$store.state.signInCheckValue = true
      }
    }
  },
}
</script>

<style scoped>

</style>