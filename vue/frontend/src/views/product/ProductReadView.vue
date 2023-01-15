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
    checkValue: {
      type: Boolean
    }
  },
  computed: {
    ...mapState([
        'product',
        'recentlyViewedProductListTmp',
        'recentlyViewedProductList'

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
  async mounted() {
    console.log(this.productNo)
    console.log(this.product)

    if (this.checkValue === true){
      await this.requestProductFromSpring(this.productNo)

      this.recentlyViewedProductListTmp.push(this.product)
    }
    console.log(this.recentlyViewedProductListTmp)
    let recentlyViewed = [...new Set(this.recentlyViewedProductListTmp.map(JSON.stringify))].map(JSON.parse)
    this.$store.state.recentlyViewedProductList = recentlyViewed
    console.log(this.recentlyViewedProductList)

  },

}
</script>

<style scoped>

</style>