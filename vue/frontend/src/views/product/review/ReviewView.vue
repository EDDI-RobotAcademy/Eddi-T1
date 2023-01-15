<template>
  <review-form :productNo="productNo"/>
</template>

<script>
import ReviewForm from "@/components/product/review/ReviewForm";
import {mapActions, mapState} from "vuex";
export default {
  name: "ReviewView",
  components: {ReviewForm},
  props: {
    productNo: {
      type: String,
      required: true,
    },
  },
  computed: {
    ...mapState([
      'productReviewList',
      'reviewImage',
      'productReviewCnt'
    ])
  },
  methods: {
    ...mapActions([
      'requestReviewImageFromSpring',
    ])
  },
  async created() {
    this.reviewImage.splice(0)
    for (let i = 0; i < this.productReviewList.length; i++) {
      const reviewNo = this.productReviewList[i].reviewNo

      await this.requestReviewImageFromSpring(reviewNo)
    }
  },

}
</script>

<style scoped>

</style>