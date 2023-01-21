<template>
  <div>
    <buyer-nav/>

    <v-container style="width: 1400px">
      <buyer-my-page-top-nav :countByInfo="countByInfo"/>

      <v-container style="width: 1000px"
                   v-if="!recentlyViewedProductList || (Array.isArray(recentlyViewedProductList) && recentlyViewedProductList.length === 0)">
        <h2 style="margin-bottom: 50px;">최근 본 상품</h2>
        <div align="center">
          <h2>최근 본 상품이 없습니다.</h2>
        </div>
      </v-container>

      <v-container v-else style="width: 1200px">
        <h2 style="margin-bottom: 50px;">최근 본 상품</h2>
        <v-layout style="margin-top: 50px;">
          <v-row class="justify-start">
            <div v-for="(item, index) in recentlyViewedProductList" :key="index">
              <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString(), checkValue: true} }"
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
                        :src="getProductThumbnail(index).productThumbnail"
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
                              v-model="productRatingValue[index]"
                              readonly
                          >
                          </v-rating>
                        </div>

                        <div style="padding-top: 9px;">
                          <h5>( {{ productRatingValue[index].toFixed(1) }} )</h5>
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
  name: "RecentlyViewedProductFrom",
  components: {BuyerNav, BuyerMyPageTopNav},
  computed: {
    ...mapState([
      'myOrderInfoList',
      'myQnaList',
      'myReviewList',
      'recentlyViewedProductList',
      'productRatingValue',
        'favoriteProductList'
    ])
  },
  data() {
    return {
      countByInfo: [],
    }
  },
  methods: {
    ...mapActions([
      'requestProductRatingValueToSpring'
    ]),
    getProductThumbnail(index) {
      return {
        ...this.recentlyViewedProductList,
        productThumbnail: this.recentlyViewedProductList[index].productImages[0].editedName && require(`@/assets/productImg/${this.recentlyViewedProductList[index].productImages[0].editedName}`)
      }
    },
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
  async created() {
    const infoNum = new Array
    infoNum.push(this.myOrderInfoList.length)
    infoNum.push(this.myQnaList.length)
    infoNum.push(this.myReviewList.length)
    infoNum.push(this.recentlyViewedProductList.length)
    infoNum.push(this.favoriteProductList.length)

    this.countByInfo = infoNum

    console.log(this.recentlyViewedProductList)
    const category = "리뷰"

    this.productRatingValue.splice(0)
    for (let i = 0; i < this.recentlyViewedProductList.length; i++) {
      let productNo = this.recentlyViewedProductList[i].productNo
      await this.requestProductRatingValueToSpring({productNo, category})
    }

    console.log(this.productRatingValue)
  },

}
</script>

<style scoped>

</style>