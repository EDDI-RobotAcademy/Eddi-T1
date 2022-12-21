<template>
  <div>
    <product-register-form @submit="onSubmit"/>
  </div>
</template>

<script>
import ProductRegisterForm from "@/components/product/ProductRegisterForm";
import {mapActions} from "vuex";
export default {
  name: "ProductRegisterView",
  components: { ProductRegisterForm },
  methods: {
    ...mapActions([
        'requestRegisterProductToSpring'
    ]),
    async onSubmit (payload) {
      await this.requestRegisterProductToSpring(payload)
    }
  }
}
</script>

<style scoped>

</style>