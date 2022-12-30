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
    const memberId = this.$store.state.memberInfoAfterSignIn.memberId

    await this.requestShoppingBucketItemListToSpring(memberId)
  }
}
</script>

<style scoped>

</style>