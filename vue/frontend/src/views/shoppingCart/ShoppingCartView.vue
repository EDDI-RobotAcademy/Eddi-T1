<template>
  <div>
    <shopping-cart-form/>
  </div>
</template>

<script>

import ShoppingCartForm from "@/components/ShoppingCart/ShoppingCartForm";
import {mapActions} from "vuex";

export default {
  name: "ShoppingCartView",
  components: {ShoppingCartForm},
  methods:{
    ...mapActions([
      'requestShoppingBucketItemListToSpring',
    ]),
  },
  async mounted() {
    const memberToken = this.$store.state.userToken

    await this.requestShoppingBucketItemListToSpring(memberToken)
  }
}
</script>

<style scoped>

</style>