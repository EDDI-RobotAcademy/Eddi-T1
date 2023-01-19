<template>
  <div>
    <buyer-nav/>

    <v-container style="width: 1400px">
      <buyer-my-page-top-nav :countByInfo="countByInfo"/>

      <v-container style="width: 1000px"
                   v-if="!favoriteProductList || (Array.isArray(favoriteProductList) && favoriteProductList.length === 0)">
        <h2 style="margin-bottom: 50px;">찜한 상품</h2>
        <div align="center">
          <h2>찜한 상품이 없습니다.</h2>
        </div>
      </v-container>

      <v-container v-else style="width: 1200px">
        <h2 style="margin-bottom: 50px;">찜한 상품</h2>
        <v-layout style="margin-top: 50px;">
          <v-row class="justify-start">
            <div v-for="(item, index) in favoriteProductInfoList" :key="index">
              <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString(), checkValue: true } }"
                           style="text-decoration: none; color: black"
              >
                <v-hover
                    v-slot="{ hover } "
                >
                  <v-card
                      :elevation="hover ? 16 : 0"
                      :class="{'on-hover' : hover}"
                      class="ma-4"
                      max-width="265"
                      flat
                  >
                    <v-img
                        class="white--text align-end"
                        height="265px"
                        :src="require(`@/assets/productImg/${item.productImages[0].editedName}`)"
                    >
                    </v-img>
                    <div style="padding: 10px 10px 10px 10px">
                      <div style="margin-top: 3px; color: darkgray;">
                        <h6>{{ item.nickname }}</h6>
                      </div>

                      <v-layout>
                        <div style="padding: 5px 0px 5px 5px;">
                          <v-rating
                              color="#DAA520"
                              background-color="#DAA520"
                              empty-icon="mdi-star-outline"
                              full-icon="mdi-star"
                              hover
                              dense
                              length="5"
                              size="18"
                              v-model="favoriteProductRatingValue[index]"
                              readonly
                          >
                          </v-rating>
                        </div>

                        <div style="padding-top: 9px;">
                          <h5>( {{favoriteProductRatingValue[index].toFixed(1)}} )</h5>
                        </div>
                      </v-layout>

                      <div style="padding: 5px 10px 10px 5px; height: 60px;">
                        <h4>{{ item.title }}</h4>
                      </div>

                      <div align="end">
                        <h5>{{ item.price | comma }}원</h5>
                      </div>
                    </div>

                  </v-card>
                </v-hover>
              </router-link>
            </div>
          </v-row>
        </v-layout>
      </v-container>
    </v-container>
  </div>
</template>

<script>

import BuyerNav from "@/components/buyerMyPage/BuyerNav";
import BuyerMyPageTopNav from "@/components/buyerMyPage/BuyerMyPageTopNav";
import {mapActions, mapState} from "vuex";
export default {
  name: "BuyerFavoriteProductForm",
  components:{
    BuyerNav,
    BuyerMyPageTopNav
  },
  computed:{
    ...mapState([
        'favoriteProductList',
        'favoriteProductInfoList',
        'favoriteProductRatingValue'
    ])
  },
  props:{
    countByInfo:{
      type: Array
    }
  },
  methods:{
    ...mapActions([
        'requestFavoriteProductInfoToSpring',
        'requestProductRatingValueToSpring'
    ])
  },
  async mounted(){
    const category = "찜"
    this.favoriteProductInfoList.splice(0)
    this.favoriteProductRatingValue.splice(0)
    for (let i = 0; i < this.favoriteProductList.length; i++) {
      console.log(this.favoriteProductList[i].productNo)
      let productNo = this.favoriteProductList[i].productNo
      await this.requestFavoriteProductInfoToSpring(productNo)
      await this.requestProductRatingValueToSpring({productNo, category})
    }
  }
}
</script>

<style scoped>

</style>