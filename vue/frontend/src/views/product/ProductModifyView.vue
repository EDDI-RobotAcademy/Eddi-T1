<template>
  <div>
    <product-modify-form :productNo="productNo" :product="product" @submit="onSubmit"/>
  </div>
</template>

<script>
import ProductModifyForm from "@/components/product/ProductModifyForm";
import {mapActions, mapState} from "vuex";
export default {
  name: "ProductModifyView",
  components: {ProductModifyForm},
  props: {
    productNo: {
      type: String,
      required: true
    }
  },
  computed: {
    ...mapState(['product'])
  },
  methods: {
    ...mapActions([
        'requestProductFromSpring',
        'requestModifyProductToSpring'
    ]),
    async onSubmit (payload) {
      await this.requestModifyProductToSpring(payload)
    }
  },
  created() {
    this.requestProductFromSpring(this.productNo)
  }
}
</script>

<style scoped>

</style>