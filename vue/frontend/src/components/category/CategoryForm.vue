<template>
  <v-container style="width: 1400px">
    <v-row style="margin-top: 30px">
      <v-layout>
        <div style="margin-top: 30px; margin-bottom: 30px; margin-left: 110px">
          <h2 style="font-weight: bold">핸드메이드</h2>
        </div>
        <v-spacer></v-spacer>
        <div style="margin-top: 35px; margin-right: 110px;">
          <v-btn
              elevation="0"
              small
              style="background-color: #FAEBD7"
              :to="{name: 'HandmadeCategoryView'}"
          >
            <span style="font-size: 12px; font-weight: bold">핸드메이드 더보기</span>
          </v-btn>
        </div>
      </v-layout>
    </v-row>

    <v-container>
      <v-layout>
        <v-row class="justify-center">
          <div v-for="(item, index) in mainPageProductListByHandmade" :key="index">
            <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString() } }"
                         style="text-decoration: none; color: black"
            >
              <v-hover
                  v-slot="{ hover }"
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
                      :src="getHandmadeProductImg(index).mainPageProductImgListByHandmade"
                  >
                  </v-img>

                  <div style="padding: 5px 10px 5px 10px;">
                    <v-rating
                        color="#DAA520"
                        background-color="#DAA520"
                        empty-icon="mdi-star-outline"
                        full-icon="mdi-star"
                        hover
                        dense
                        length="5"
                        size="18"
                        v-model="handmadeProductRatingValue[index]"
                        readonly
                    >
                    </v-rating>
                  </div>
                  <div style="padding: 10px 10px 10px 10px; height: 60px;">
                    <h4>{{ item.title }}</h4>
                  </div>
                </v-card>
              </v-hover>
            </router-link>
          </div>

        </v-row>
      </v-layout>
    </v-container>


    <!-- 노하우 -->
    <v-row style="margin-top: 30px">
      <v-layout>
        <div style="margin-top: 30px; margin-bottom: 30px; margin-left: 110px">
          <h2 style="font-weight: bold">노하우</h2>
        </div>
      </v-layout>
      <v-spacer></v-spacer>
      <div style="margin-top: 35px; margin-right: 110px;">
        <v-btn
            elevation="0"
            small
            style="background-color: #FAEBD7"
            :to="{name: 'KnowhowCategoryView'}"
        >
          <span style="font-size: 12px; font-weight: bold">노하우 더보기</span>
        </v-btn>
      </div>

    </v-row>

    <v-container>
      <v-layout>
        <v-row class="justify-center">
          <div v-for="(item, index) in mainPageProductListByKnowHow" :key="index">
            <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString() } }"
                         style="text-decoration: none; color: black"
            >
              <v-hover
                  v-slot="{ hover }"
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
                      :src="getKnowhowProductImg(index).mainPageProductImgListByKnowHOw"
                  >
                  </v-img>

                  <div style="padding: 5px 10px 5px 10px;">
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
                  <div style="padding: 5px 10px 10px 10px; height: 60px;">
                    <h4>{{ item.title }}</h4>
                  </div>
                </v-card>
              </v-hover>

            </router-link>
          </div>
        </v-row>
      </v-layout>
    </v-container>

    <!-- 취미/특기 -->
    <v-row style="margin-top: 30px">
      <v-layout>
        <div style="margin-top: 30px; margin-bottom: 30px; margin-left: 110px">
          <h2 style="font-weight: bold">취미/특기</h2>
        </div>
      </v-layout>
      <v-spacer></v-spacer>
      <div style="margin-top: 35px; margin-right: 110px;">
        <v-btn
            elevation="0"
            small
            style="background-color: #FAEBD7"
            :to="{name: 'HobbyCategoryView'}"
        >
          <span style="font-size: 12px; font-weight: bold">취미/특기 더보기</span>
        </v-btn>
      </div>

    </v-row>

    <v-container>
      <v-layout>
        <v-row class="justify-center">
          <div v-for="(item, index) in mainPageProductListByHobby" :key="index">
            <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString() } }"
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
                      :src="getHobbyProductImg(index).mainPageProductImgListByHobby"
                  >
                  </v-img>
                  <div style="padding: 5px 10px 5px 10px;">
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
                  <div style="padding: 5px 10px 10px 10px; height: 60px;">
                    <h4>{{ item.title }}</h4>
                  </div>
                </v-card>
              </v-hover>
            </router-link>
          </div>

        </v-row>
      </v-layout>
    </v-container>
  </v-container>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: "CategoryForm",
  computed: {
    ...mapState([
      'mainPageProductListByHandmade',
      'mainPageProductListByKnowHow',
      'mainPageProductListByHobby',
      'mainPageProductImgListByHobby',
      'mainPageProductImgListByKnowHOw',
      'mainPageProductImgListByHandmade',
      'handmadeProductRatingValue',
      'knowhowProductRatingValue',
      'hobbyProductRatingValue'
    ]),
  },
  methods: {
    check(index){
      console.log(index)
    },
    getHobbyProductImg(index) {
      return {
        ...this.mainPageProductImgListByHobby,
        mainPageProductImgListByHobby: this.mainPageProductImgListByHobby[index] && require(`@/assets/productImg/${this.mainPageProductImgListByHobby[index]}`)
      }
    },
    getKnowhowProductImg(index) {
      return {
        ...this.mainPageProductImgListByKnowHOw,
        mainPageProductImgListByKnowHOw: this.mainPageProductImgListByKnowHOw[index] && require(`@/assets/productImg/${this.mainPageProductImgListByKnowHOw[index]}`)
      }
    },
    getHandmadeProductImg(index) {
      return {
        ...this.mainPageProductImgListByHandmade,
        mainPageProductImgListByHandmade: this.mainPageProductImgListByHandmade[index] && require(`@/assets/productImg/${this.mainPageProductImgListByHandmade[index]}`)
      }
    },
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
}
</script>

<style scoped>

</style>