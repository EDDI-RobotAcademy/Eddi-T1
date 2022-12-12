<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="80" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Product Manage
      </v-toolbar-title>
    </v-app-bar>

    <category-form :categoryName="myIdea" :category-items="handmadeItems"/>

    <v-row justify="end">
      <router-link style="text-decoration: none;" :to="{ name:'ProductRegisterView' }">
        <v-btn class="grey darken-3" dark>
          <v-icon small>mdi-pencil</v-icon> 상품 등록</v-btn>
      </router-link>
    </v-row>




  </v-container>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";
import CategoryForm from "@/components/category/CategoryForm";
export default {
  name: "ProductManageForm",
  components: {CategoryForm, SellerNavi},
  data() {
    return {
      imgItems: [
        {path: 'advertisement1.jpg'},
        {path: 'advertisement2.jpg'},
        {path: 'advertisement3.jpg'},
      ],
      myIdea: "내가 판매한 상품",
      handmadeItems:[
        {commodityTitle: '핸드메이드1', sellerNickname: '판매자6', contents: '뭐 이런저런 물건 팔고있어요', img: '상품이미지1.jpg',categoryType: '내가 판매한 상품'},
      ]
    }
  }
}
</script>

<style scoped>

</style>