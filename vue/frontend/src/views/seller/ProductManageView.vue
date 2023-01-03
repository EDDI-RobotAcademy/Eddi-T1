<template>
  <product-manage-form :product-list="productList"/>
</template>

<script>
import ProductManageForm from "@/components/seller/ProductManageForm";
import {mapActions, mapState} from "vuex";
export default {
  name: "ProductManageView",
  components: {ProductManageForm},

  computed: {
    ...mapState([
      'productList',
    ]),
  },



  async mounted() {

    const sellerId = this.$store.state.memberInfoAfterSignIn.nickname;
    await this.requestProductListFromSpring(sellerId)
    console.log(this.$store.state.productList)
  },
  methods: {
    ...mapActions([
      'requestProductListFromSpring'
    ])
  },
}
</script>

<style scoped>

</style>