<template>
  <product-read-form :productNo="productNo" :product="product"/>
</template>

<script>
import ProductReadForm from "@/components/product/ProductReadForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "ProductReadView",
  components: {ProductReadForm},
  props: {
    productNo: {
      type: String,
      required: true
    },
  },
  computed: {
    ...mapState([
        'product'
    ])
  },
  created() {
    this.requestProductFromSpring(this.productNo)
  },
  methods: {
    ...mapActions([
        'requestProductFromSpring'
    ]),
  },
  mounted() {
    console.log(this.productNo)
    console.log(this.product)
  },

}
</script>

<style scoped>

</style>