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

    <h2>{{ SellerNickname }}님이 판매중이신 상품</h2><br/>

    <v-container>
      <v-layout>
        <v-row class="justify-center">
          <div v-for="(product, index) in productList" :key="index">
            <v-card
                class="mx-auto"
                max-width="400"
            >
              <v-img
                  class="white--text align-end"
                  height="200px"
                  :src="require('@/assets/productImg/' + productList[index].productImages[0].editedName)"
              >
                <v-card-title>{{ product.title }}</v-card-title>
              </v-img>

              <v-card-subtitle class="pb-0">
                판매자 : {{ product.nickname }} 님
              </v-card-subtitle>


              <v-card-text class="text--primary">
                가격 : {{ product.price }} 원
              </v-card-text>

              <v-card-actions>

                <v-btn
                    color="orange"
                    text
                >
                  상세페이지로 이동
                </v-btn>

              </v-card-actions>
            </v-card>

          </div>

        </v-row>
      </v-layout>
    </v-container>
    <!--
        <div>
          <h3>{{SellerNickname}}님의 판매상품 목록</h3>
          <table border="1">
            <tr>
              <th align="center" width="70">상품번호</th>
              <th align="center" width="150">판매자</th>
              <th align="center" width="100">가격</th>
              <th align="center" width="600">제목</th>
              <th align="center" width="200">사진</th>
              <th align="center" width="200">상품정보</th>
            </tr>

            <tr v-if="!productList || (Array.isArray(productList) && productList.length === 0)">
              <td colspan="4">
                현재 등록된 게시물이 없습니다!
              </td>
            </tr>

            <tr v-else v-for="product in productList" :key="product.productNo">
              <td align="center">
                {{ product.productNo }}
              </td>
              <td align="left">
                  {{ product.nickname }}
              </td>
              <td align="right">
                {{ product.price }}
              </td>
              <td align="center">
                {{product.title }}
              </td>
            </tr>

          </table>
        </div>
        !-->


    <v-row justify="end">
      <router-link style="text-decoration: none;" :to="{ name:'ProductRegisterView' }">
        <v-btn class="grey darken-3" dark>
          <v-icon small>mdi-pencil</v-icon>
          상품 등록
        </v-btn>
      </router-link>
    </v-row>


  </v-container>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";

export default {
  name: "ProductManageForm",
  components: {SellerNavi},

  props: {
    productList: {
      type: Array
    },

  },
  data() {
    return {
      show: false,
      SellerNickname: this.$store.state.memberInfoAfterSignIn.nickname,

      imgItems: [
        {path: 'advertisement1.jpg'},
        {path: 'advertisement2.jpg'},
        {path: 'advertisement3.jpg'},
      ],
      myIdea: "내가 판매한 상품",
      handmadeItems: [
        {
          commodityTitle: '핸드메이드1',
          sellerNickname: '판매자6',
          contents: '뭐 이런저런 물건 팔고있어요',
          img: '상품이미지1.jpg',
          categoryType: '내가 판매한 상품'
        },
      ]
    }
  },
  methods:{
    checkProduct(product){
      console.log(product.productImages[0].editedName)
    }
  }
}
</script>

<style scoped>

</style>