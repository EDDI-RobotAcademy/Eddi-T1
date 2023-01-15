<template>
 <buyer-review-form/>
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
        'reviewImage'
    ])
  },
  methods:{
    ...mapActions([
        'requestReviewImageFromSpring'
    ])
  },
  async created(){
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