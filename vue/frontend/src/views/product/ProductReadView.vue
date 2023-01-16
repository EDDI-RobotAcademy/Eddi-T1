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
        'requestProductFromSpring',
        'requestProductRatingAvgToSpring'
    ]),
  },
  async mounted() {
    console.log(this.productNo)
    console.log(this.product)

    const productNo = this.productNo
    //상품 별점 평균
    await this.requestProductRatingAvgToSpring(productNo)
  },

}
</script>

<style scoped>

</style>