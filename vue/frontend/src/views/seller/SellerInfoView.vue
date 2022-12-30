<template>
  <seller-info-form @submit="onSubmit"/>
</template>

<script>
import SellerInfoForm from "@/components/seller/SellerInfoForm";
import {mapActions} from "vuex";
export default {
  name: "SellerInfoView",
  components: {SellerInfoForm},
  data () {
    return {

    }
  },
  methods: {

    ...mapActions([
      'requestRegisterSellerInfoToSpring'
    ]),
    async onSubmit (payload) {
      await this.requestRegisterSellerInfoToSpring(payload)

    },

  }

}
</script>

<style scoped>

</style>