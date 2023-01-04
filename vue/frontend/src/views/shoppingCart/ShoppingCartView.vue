<template>
  <div>
    <shopping-cart-form/>
  </div>
</template>

<script>

import ShoppingCartForm from "@/components/shoppingCart/ShoppingCartForm";
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
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname

    await this.requestShoppingBucketItemListToSpring(nickname)
  }
}
</script>

<style scoped>

</style>