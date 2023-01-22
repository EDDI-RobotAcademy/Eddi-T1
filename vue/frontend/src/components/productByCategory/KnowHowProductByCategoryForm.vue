<template>
  <v-container style="width: 1200px; margin-top: 0px;">
    <v-layout style="margin-top: 5px;">
      <v-row class="justify-start">
        <div v-for="(item, index) in knowhowProductByFilter" :key="index">
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
                    :src="getProductThumbnail(index).productThumbnailListByCategory"
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
                          v-model="knowhowProductRatingValue[index]"
                          readonly
                      >
                      </v-rating>
                    </div>

                    <div style="padding-top: 9px;">
                      <h5>( {{ knowhowProductRatingValue[index]?.toFixed(1) }} )</h5>
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

</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "KnowHowProductByCategoryForm",
  props: {
    categoryName: {
      type: String
    },
  },
  computed: {
    ...mapState([
      'mainPageProductImgListByKnowHOw',
      'mainPageProductListByKnowHow',
      'knowhowProductRatingValue',
      'knowhowProductByFilter',
      'filterType'
    ])
  },
  methods: {
    ...mapActions([
      'requestProductImgListToSpring',
      'requestProductRatingValueToSpring',
      'requestProductListByFilterFromSpring'
    ]),
    getProductThumbnail(index) {
      return {
        ...this.mainPageProductImgListByKnowHOw,
        productThumbnailListByCategory: this.mainPageProductImgListByKnowHOw[index] && require(`@/assets/productImg/${this.mainPageProductImgListByKnowHOw[index]}`)
      }
    },

    async getMainPageProductImgByKnowhow() {
      this.mainPageProductImgListByKnowHOw.splice(0)
      let category = "노하우"
      // 핸드메이드 상품 받아오기
      for (let j = 0; j < this.knowhowProductByFilter.length; j++) {
        let productNo = this.knowhowProductByFilter[j].productNo;

        await this.requestProductImgListToSpring({productNo, category});
      }
    },
    async getProductRatingValue() {
      const category = this.categoryName
      this.knowhowProductRatingValue.splice(0)
      for (let i = 0; i < this.knowhowProductByFilter.length; i++) {
        let productNo = this.knowhowProductByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
  async mounted() {
    if (this.filterType === ""){
      const category = this.categoryName
      const filter = "최신순"
      const productSize = 12

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageProductImgByKnowhow()

      this.lastProductNo = this.knowhowProductByFilter[this.knowhowProductByFilter.length - 1].productNo

    } else {
      const category = this.categoryName
      const filter = this.filterType
      const productSize = 12

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageProductImgByKnowhow()

      this.lastProductNo = this.knowhowProductByFilter[this.knowhowProductByFilter.length - 1].productNo
    }
  },
  async beforeUpdate(){
    await this.getMainPageProductImgByKnowhow()
    await this.getProductRatingValue()
  }
}
</script>

<style scoped>

</style>