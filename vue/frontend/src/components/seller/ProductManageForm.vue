<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="81" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Product Manage
      </v-toolbar-title>
    </v-app-bar>

    <v-row justify="left">

      <div style="margin-left: 50px;"><h1>{{ SellerNickname }}님이 판매중이신 상품 </h1></div>


    </v-row>
    <br/>


    <v-layout>
      <v-row class="justify-center">
        <div v-for="(product, index) in productList" :key="index"
             style="margin-left: 20px;"
        >

          <v-card
              class="mx-auto my-12"
              max-width="374"

          >
            <template slot="progress">
              <v-progress-linear
                  color="deep-purple"
                  height="10"
                  indeterminate
              ></v-progress-linear>
            </template>

            <v-img
                height="250"
                :src="require('@/assets/productImg/' + productList[index].productImages[0].editedName)"
            ></v-img>

            <v-card-title
                style="height: 80px"
            >{{ product.title }}
            </v-card-title>

            <v-card-text>

              <div class="my-4 text-subtitle-1">
                {{ product.productInfo.category }}
              </div>

              <div>가격 : {{ product.price }} 원</div>
            </v-card-text>

            <v-divider class="mx-4"></v-divider>


            <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: product.productNo.toString(), checkValue: true } }"
                         style="text-decoration: none; color: black"
            >
              <v-btn
                  color="deep-purple lighten-2"
                  text

              >
                제품페이지로 이동
              </v-btn>
            </router-link>

          </v-card>


        </div>
      </v-row>
    </v-layout>

    <div class="floating">
      <router-link style="text-decoration: none;" :to="{ name:'ProductRegisterView' }">
        <v-btn
            fab
            dark
            color="#2F4F4F"
            width="100"
            height="100"
        >
          <v-icon
              style="width: 300px"
              size="50"
          >
            mdi-plus
          </v-icon>

        </v-btn>
      </router-link>
    </div>
    :

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
      scTimer: 0,
      scY: 0,
      value: 1,
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
  methods: {
    checkProduct(product) {
      console.log(product.productImages[0].editedName)
    },
    onScroll() {

    },
  }
}
</script>

<style scoped>
.floating {
  position: fixed;
  right: 45%;
  top: 32%;
  bottom: 20%;
  margin-top: 500px;
  margin-right: -820px;
  text-align: center;
  width: 120px;
}
</style>