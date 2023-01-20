<template>
  <v-container style="width: 1200px; margin-top: 50px;">
    <h2>{{ categoryName }}</h2>

    <v-layout style="margin-top: 50px;">
      <v-row class="justify-start">
        <div v-for="(item, index) in productListByFilter" :key="index">
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
                          v-model="hobbyProductRatingValue[index]"
                          readonly
                      >
                      </v-rating>
                    </div>

                    <div style="padding-top: 9px;">
                      <h5>( {{hobbyProductRatingValue[index].toFixed(1)}} )</h5>
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
  name: "HobbyProductByCategoryForm",
  props: {
    categoryName: {
      type: String
    },
    productListByCategory: {
      type: Array
    },
  },
  computed: {
    ...mapState([
      'mainPageProductImgListByHobby',
      'mainPageProductListByHobby',
      'hobbyProductRatingValue',
      'productListByFilter'

    ])
  },
  methods: {
    ...mapActions([
      'requestProductImgListToSpring',

    ]),
    getProductThumbnail(index) {
      return {
        ...this.mainPageProductImgListByHobby,
        productThumbnailListByCategory: this.mainPageProductImgListByHobby[index] && require(`@/assets/productImg/${this.mainPageProductImgListByHobby[index]}`)
      }
    },
    getMainPageProductImgByHobby() {

      const category = this.categoryName
      //상품 받아오기
      this.mainPageProductImgListByHobby.splice(0)
      for (let j = 0; j < this.productListByFilter.length; j++) {
        let productNo = this.productListByFilter[j].productNo;

        this.requestProductImgListToSpring({productNo, category});
      }
    },
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
  mounted() {
    this.getMainPageProductImgByHobby()
  },
}
</script>

<style scoped>

</style>