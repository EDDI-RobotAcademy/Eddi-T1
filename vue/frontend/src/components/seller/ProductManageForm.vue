<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="80" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        ๐ Product Manage
      </v-toolbar-title>
    </v-app-bar>

    <v-row justify="left">

      <div style="margin-left: 50px;"><h1>{{ SellerNickname }}๋์ด ํ๋งค์ค์ด์  ์ํ </h1></div>


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

              <div>๊ฐ๊ฒฉ : {{ product.price }} ์</div>
            </v-card-text>

            <v-divider class="mx-4"></v-divider>


            <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: product.productNo.toString() } }"
                         style="text-decoration: none; color: black"
            >
              <v-btn
                  color="deep-purple lighten-2"
                  text

              >
                ์ ํํ์ด์ง๋ก ์ด๋
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
      myIdea: "๋ด๊ฐ ํ๋งคํ ์ํ",
      handmadeItems: [
        {
          commodityTitle: 'ํธ๋๋ฉ์ด๋1',
          sellerNickname: 'ํ๋งค์6',
          contents: '๋ญ ์ด๋ฐ์ ๋ฐ ๋ฌผ๊ฑด ํ๊ณ ์์ด์',
          img: '์ํ์ด๋ฏธ์ง1.jpg',
          categoryType: '๋ด๊ฐ ํ๋งคํ ์ํ'
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