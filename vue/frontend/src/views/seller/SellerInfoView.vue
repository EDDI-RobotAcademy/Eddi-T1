<template>
  <seller-info-form @submit="onSubmit"/>
</template>

<script>
import SellerInfoForm from "@/components/seller/SellerInfoForm";
import {mapActions} from "vuex";
export default {
  name: "SellerInfoView",
  components: {SellerInfoForm},
  methods: {
    ...mapActions([
      'requestRegisterSellerInfoToSpring'
    ]),
    async onSubmit (payload) {
      await this.requestRegisterSellerInfoToSpring(payload)
      await this.$router.push({name: 'OrderManageView'})
    },

  }

}
</script>

<style scoped>

</style>