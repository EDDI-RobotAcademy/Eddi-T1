<template>
  <product-read-form :productNo="productNo" :product="product"/>
</template>

<script>
import ProductReadForm from "@/components/product/ProductReadForm";
import {mapActions, mapState} from "vuex";
import _ from 'lodash'
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
    },
  },
  computed: {
    ...mapState([
      'product',
      'recentlyViewedProductListTmp',
      'recentlyViewedProductList',
      'hobbyFavoriteProductCheck',
      'knowhowFavoriteProductCheck',
      'handmadeFavoriteProductCheck',

    ])
  },
  created() {
    this.requestProductFromSpring(this.productNo)
  },
  methods: {
    ...mapActions([
      'requestProductFromSpring',
      'requestProductRatingValueToSpring'
    ]),
  },
  async mounted() {
    console.log(this.productNo)
    console.log(this.product)

    if (this.checkValue === true) {
      await this.requestProductFromSpring(this.productNo)

      this.recentlyViewedProductListTmp.push(this.product)
    }
    console.log(this.recentlyViewedProductListTmp)
    let recentlyViewed = _.uniqBy(this.recentlyViewedProductListTmp, "productNo")
    this.$store.state.recentlyViewedProductList = recentlyViewed
    console.log(this.recentlyViewedProductList)

    const productNo = this.productNo
    let category = "상세페이지"
    await this.requestProductRatingValueToSpring({productNo, category})
  },
}
</script>

<style scoped>

</style>