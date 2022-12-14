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
      await this.requestBuyerSignInToSpring({ memberId, password, memberType })
    }
  },
}
</script>

<style scoped>

</style>