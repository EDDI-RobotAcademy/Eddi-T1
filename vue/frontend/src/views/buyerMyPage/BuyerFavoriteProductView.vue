<template>
  <buyer-favorite-product-form :countByInfo="countByInfo"/>
</template>

<script>
import BuyerFavoriteProductForm from "@/components/buyerMyPage/BuyerFavoriteProductForm";
import {mapState} from "vuex";
export default {
  name: "BuyerFavoriteProductView",
  components: {BuyerFavoriteProductForm},
  computed:{
    ...mapState([
      'myOrderInfoList',
      'myQnaList',
      'recentlyViewedProductList',
      'myReviewList',
    ])
  },
  data(){
    return{
      countByInfo: []
    }
  },
  async mounted(){
    const infoNum = new Array
    infoNum.push(this.myOrderInfoList.length)
    infoNum.push(this.myQnaList.length)
    infoNum.push(this.myReviewList.length)
    infoNum.push(this.recentlyViewedProductList.length)

    this.countByInfo = infoNum
  }
}
</script>

<style scoped>

</style>