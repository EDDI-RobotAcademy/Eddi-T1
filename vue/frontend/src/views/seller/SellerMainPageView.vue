<template>
  <seller-main-page-form
  :total-product="totalProduct"
  :total-review="totalReview"
  :total-qn-a="totalQnA"
  :total-order="totalOrder"
  :total-sales="totalSales"
  />
</template>

<script>
import SellerMainPageForm from "@/components/seller/SellerMainPageForm";
import {mapActions} from "vuex";
export default {
  name: "SellerMainPageView",
  components: {SellerMainPageForm},

  data(){
    return{
      totalProduct: 0,
      totalReview: 0,
      totalQnA: 0,
      totalOrder: 0,
      totalSales: 0,
    }
  },

  async mounted(){
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname;
    await this.requestSellerTotalInfoFromSpring(nickname);
    console.log(this.$store.state.sellerTotalInfo)

    this.totalProduct = this.$store.state.sellerTotalInfo.totalProduct;
    this.totalReview = this.$store.state.sellerTotalInfo.totalReview;
    this.totalQnA = this.$store.state.sellerTotalInfo.totalQnA;
    this.totalOrder = this.$store.state.sellerTotalInfo.totalOrder;
    this.totalSales = this.$store.state.sellerTotalInfo.totalSales;

  },

  methods: {
    ...mapActions([
      'requestSellerTotalInfoFromSpring'
    ])
  },
}


</script>

<style scoped>

</style>