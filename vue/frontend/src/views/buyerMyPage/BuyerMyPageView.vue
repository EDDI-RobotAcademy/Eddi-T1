<template>
  <div>
    <buyer-order-info-page-form :countByInfo="countByInfo"/>
  </div>
</template>

<script>

import {mapActions, mapState} from "vuex";
import BuyerOrderInfoPageForm from "@/components/buyerMyPage/BuyerOrderInfoPageForm";

export default {
  name: "buyerMyPageView",
  components: {BuyerOrderInfoPageForm},
  computed: {
    ...mapState([
      'myOrderInfoList',
      'myQnaList',
      'myReviewList',
      'recentlyViewedProductList',
      'favoriteProductList'
    ])
  },
  data(){
    return{
      countByInfo: []
    }
  },
  methods: {
    ...mapActions([
      'requestMyOrderInfoListFromSpring',
      'requestMyQnaListFromSpring',
      'requestMyReviewListToSpring'
    ])
  },
  async created() {
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname
    await this.requestMyOrderInfoListFromSpring(nickname)

    const writer = nickname
    await this.requestMyQnaListFromSpring(writer)

    await this.requestMyReviewListToSpring(writer)

    const infoNum = new Array
    console.log(this.myOrderInfoList.length)
    infoNum.push(this.myOrderInfoList.length)
    infoNum.push(this.myQnaList.length)
    infoNum.push(this.myReviewList.length)
    infoNum.push(this.recentlyViewedProductList.length)
    infoNum.push(this.favoriteProductList.length)

    this.countByInfo = infoNum
  }
}
</script>

<style scoped>

</style>