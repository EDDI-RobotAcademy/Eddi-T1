<template>
  <v-container style="width: 1400px">
    <v-row style="margin-top: 30px">
      <v-layout>
        <div style="margin-top: 30px; margin-bottom: 30px"

        >
          <h2 style="font-weight: bold">핸드메이드</h2>
        </div>
      </v-layout>
      <v-spacer></v-spacer>

    </v-row>

    <v-container>
      <v-layout>
        <v-row class="justify-center">
          <a href="/product-read" v-for="(item, index) in mainPageProductListByHandmade" :key="index"
             style="text-decoration: none; color: black"
          >
            <v-card
                class="ma-4"
                max-width="210"
            >
              <v-img
                  class="white--text align-end"
                  height="200px"
                  :src="require('@/assets/productImg/' + mainPageProductImgListByHandmade[index])"
              >
              </v-img>
              <div>
                <v-card-subtitle>
                  <h4>{{ item.nickname }}</h4>
                </v-card-subtitle>
              </div>

              <v-divider></v-divider>

              <div style="padding: 5px 10px 10px 5px; height: 60px;">
                <h5>{{ item.title }}</h5>
              </div>

              <v-divider></v-divider>
              <v-card-text class="text--primary" align="end" style="padding: 3px 3px 3px 3px;">
                {{ item.price | comma }}원
              </v-card-text>

            </v-card>
          </a>
        </v-row>
      </v-layout>
    </v-container>
    <div align="center" style="margin-top: 10px">
      <v-btn
          rounded
          elevation="1"
          color="#2F4F4F"
          large
      >
        <span style="font-size: 16px; color: white">핸드메이드 더보기</span>
      </v-btn>
    </div>

    <!-- 노하우 -->

    <v-row style="margin-top: 30px">
      <v-layout>
        <div style="margin-top: 30px; margin-bottom: 30px"

        >
          <h2 style="font-weight: bold">노하우</h2>
        </div>
      </v-layout>
      <v-spacer></v-spacer>

    </v-row>

    <v-container>
      <v-layout>
        <v-row class="justify-center">
          <a href="/product-read" v-for="(item, index) in mainPageProductListByKnowHow" :key="index"
             style="text-decoration: none; color: black"
          >
            <v-card
                class="ma-4"
                max-width="210"
            >
                            <v-img
                                class="white--text align-end"
                                height="200px"
                                :src="require('@/assets/productImg/' + mainPageProductImgListByKnowHOw[index])"
                            >
                            </v-img>
              <div>
                <v-card-subtitle>
                  <h4>{{ item.nickname }}</h4>
                </v-card-subtitle>
              </div>

              <v-divider></v-divider>

              <div style="padding: 5px 10px 10px 5px; height: 60px;">
                <h5>{{ item.title }}</h5>
              </div>

              <v-divider></v-divider>
              <v-card-text class="text--primary" align="end" style="padding: 3px 3px 3px 3px;">
                {{ item.price | comma }}원
              </v-card-text>


            </v-card>
          </a>
        </v-row>
      </v-layout>
    </v-container>
    <div align="center" style="margin-top: 10px">
      <v-btn
          rounded
          elevation="1"
          color="#2F4F4F"
          large
      >
        <span style="font-size: 16px; color: white">노하우 더보기</span>
      </v-btn>
    </div>

    <!-- 취미/특기 -->
    <v-row style="margin-top: 30px">
      <v-layout>
        <div style="margin-top: 30px; margin-bottom: 30px"

        >
          <h2 style="font-weight: bold">취미/특기</h2>
        </div>
      </v-layout>
      <v-spacer></v-spacer>

    </v-row>

    <v-container>
      <v-layout>
        <v-row class="justify-center">
          <a href="/product-read" v-for="(item, index) in mainPageProductListByHobby" :key="index"
             style="text-decoration: none; color: black"
          >
            <v-card
                class="ma-4"
                max-width="210"
            >
                            <v-img
                                class="white--text align-end"
                                height="200px"
                                :src="require('@/assets/productImg/' + mainPageProductImgListByHobby[index])"
                            >
                            </v-img>
              <div>
                <v-card-subtitle>
                  <h4>{{ item.nickname }}</h4>
                </v-card-subtitle>
              </div>

              <v-divider></v-divider>

              <div style="padding: 5px 10px 10px 5px; height: 60px;">
                <h5>{{ item.title }}</h5>
              </div>

              <v-divider></v-divider>
              <v-card-text class="text--primary" align="end" style="padding: 3px 3px 3px 3px;">
                {{ item.price | comma }}원
              </v-card-text>
            </v-card>
          </a>
        </v-row>
      </v-layout>
    </v-container>
    <div align="center" style="margin-top: 10px">
      <v-btn
          rounded
          elevation="1"
          color="#2F4F4F"
          large
      >
        <span style="font-size: 16px; color: white">취미/특기 더보기</span>
      </v-btn>
    </div>
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
      'mainPageProductImgListByHandmade'
    ]),
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