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
        'recentlyViewedProductList'
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
        'requestMyReviewListToSpring'
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

    this.countByInfo = infoNum
  }
}
</script>

<style scoped>

</style>