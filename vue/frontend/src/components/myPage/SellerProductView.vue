<template>
  <v-container>

    <seller-navi/>

    <v-row justify="center">
      <router-link style="text-decoration: none;" :to="{ name:'ProductRegisterView' }">
        <v-btn class="grey darken-3" dark>
          <v-icon small>mdi-pencil</v-icon> 상품 등록</v-btn>
      </router-link>
    </v-row>

  </v-container>
</template>

<script>
import SellerNavi from "@/components/myPage/SellerNavi";
export default {
  name: "SellerProductView",
  components: {SellerNavi}
}
</script>

<style scoped>

</style>