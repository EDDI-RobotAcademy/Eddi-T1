<template>
 <buyer-review-form :countByInfo="countByInfo"/>
</template>

<script>
import BuyerReviewForm from "@/components/buyerMyPage/BuyerReviewForm";
import {mapActions, mapState} from "vuex";
export default {
  name: "BuyerReviewView",
  components: {BuyerReviewForm},
  computed:{
    ...mapState([
        'myReviewList',
        'reviewImage',
        'myOrderInfoList',
        'myQnaList',
        'recentlyViewedProductList',
        'favoriteProductList'
    ])
  },
  data(){
    return{
      countByInfo: []
    }
  },
  methods:{
    ...mapActions([
        'requestReviewImageFromSpring',
        'requestMyReviewListToSpring',

    ])
  },
  async mounted(){
    const writer = this.$store.state.memberInfoAfterSignIn.nickname

    await this.requestMyReviewListToSpring(writer)
    const infoNum = new Array
    console.log(this.myOrderInfoList.length)
    infoNum.push(this.myOrderInfoList.length)
    infoNum.push(this.myQnaList.length)
    infoNum.push(this.myReviewList.length)
    infoNum.push(this.recentlyViewedProductList.length)
    infoNum.push(this.favoriteProductList.length)

    this.countByInfo = infoNum

    this.reviewImage.splice(0)
    for (let i = 0; i < this.myReviewList.length; i++) {
      let reviewNo = this.myReviewList[i].reviewNo

      await this.requestReviewImageFromSpring(reviewNo)
    }
  }
}
</script>

<style scoped>

</style>