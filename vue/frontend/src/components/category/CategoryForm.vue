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
                  <v-expand-transition>
                    <div v-if="hover"
                         align="center"
                         class="transition-fast-in-fast-out darken-2 v-card--reveal"
                         style="height: 40px; background-color: rgba(255, 255, 255, 0.6)"
                    >
                      <!-- 장바구니 -->
                      <v-btn
                          class="cartIconColor"
                          icon
                          align="end"
                          @click="addShoppingBucketProduct(item)"
                      >
                        <v-icon size="30px">
                          mdi-cart-outline
                        </v-icon>
                      </v-btn>

                      <!-- 찜 -->
                      <v-tooltip
                          v-model="showTooltip"
                          top
                      >
                        <template v-slot:activator="{ on, attrs }">
                          <v-btn
                              class="iconColor"
                              icon
                              v-bind="attrs"
                              v-on="on"
                              align="end"
                              @click="favoriteProductManagement(index, '핸드메이드', item)"
                          >
                            <v-icon size="30px" v-if="!handmadeFavoriteProductCheck[index].checkValue">
                              mdi-lightbulb-variant-outline
                            </v-icon>
                            <v-icon v-else size="30px" style="color: #DAA520">
                              mdi-lightbulb-on
                            </v-icon>
                          </v-btn>
                        </template>
                      </v-tooltip>
                    </div>
                  </v-expand-transition>
                </v-img>

                <div style="padding: 5px 10px 5px 10px;">
                  <v-layout>
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
                    <h5 style="margin-top: 4px;">({{ handmadeReviewCnt[index] }} 개)</h5>
                  </v-layout>

                </div>
                <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString(), checkValue: true } }"
                             style="text-decoration: none; color: black"
                >
                  <div style="padding: 10px 10px 10px 10px; height: 60px;">
                    <h4>{{ item.title }}</h4>
                  </div>
                </router-link>
              </v-card>
            </v-hover>
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
                  <v-expand-transition>
                    <div v-if="hover"
                         align="center"
                         class="transition-fast-in-fast-out darken-2 v-card--reveal"
                         style="height: 40px; background-color: rgba(255, 255, 255, 0.6)"
                    >
                      <!-- 장바구니 -->
                      <v-btn
                          class="cartIconColor"
                          icon
                          align="end"
                          @click="addShoppingBucketProduct(item)"
                      >
                        <v-icon size="30px">
                          mdi-cart-outline
                        </v-icon>
                      </v-btn>


                      <!-- 찜 -->
                      <v-tooltip v-model="showTooltip" top>
                        <template v-slot:activator="{ on, attrs }">
                          <v-btn
                              class="iconColor"
                              icon
                              v-bind="attrs"
                              v-on="on"
                              align="end"
                              @click="favoriteProductManagement(index, '노하우', item)"
                          >
                            <v-icon size="30px" v-if="!knowhowFavoriteProductCheck[index].checkValue">
                              mdi-lightbulb-variant-outline
                            </v-icon>
                            <v-icon v-else size="30px" style="color: #DAA520">
                              mdi-lightbulb-on
                            </v-icon>
                          </v-btn>
                        </template>
                        <span>찜하기</span>
                      </v-tooltip>
                    </div>
                  </v-expand-transition>
                </v-img>

                <div style="padding: 5px 10px 5px 10px;">
                  <v-layout>
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
                    <h5 style="margin-top: 4px;">({{ knowhowReviewCnt[index] }} 개)</h5>
                  </v-layout>

                </div>

                <router-link
                    :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString(), checkValue: true} }"
                    style="text-decoration: none; color: black"
                >
                  <div style="padding: 5px 10px 10px 10px; height: 60px;">

                    <h4>{{ item.title }}</h4>
                  </div>
                </router-link>
              </v-card>
            </v-hover>

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

                  <v-expand-transition>
                    <div v-if="hover"
                         align="center"
                         class="transition-fast-in-fast-out darken-2 v-card--reveal"
                         style="height: 40px; background-color: rgba(255, 255, 255, 0.6)"
                    >
                      <!-- 장바구니 -->
                      <v-btn
                          class="cartIconColor"
                          icon
                          align="end"
                          @click="addShoppingBucketProduct(item)"
                      >
                        <v-icon size="30px">
                          mdi-cart-outline
                        </v-icon>
                      </v-btn>

                      <!-- 찜 -->
                      <v-tooltip
                          v-model="showTooltip"
                          top
                      >
                        <template v-slot:activator="{ on, attrs }">
                          <v-btn
                              class="iconColor"
                              v-bind="attrs"
                              v-on="on"
                              icon
                              align="end"
                              @click="favoriteProductManagement(index, '취미/특기', item)"
                          >
                            <v-icon size="30px" v-if="!hobbyFavoriteProductCheck[index].checkValue">
                              mdi-lightbulb-variant-outline
                            </v-icon>
                            <v-icon v-else size="30px" style="color: #DAA520">
                              mdi-lightbulb-on
                            </v-icon>
                          </v-btn>
                        </template>
                        <span>찜하기</span>
                      </v-tooltip>
                    </div>
                  </v-expand-transition>
                </v-img>
                <div style="padding: 5px 10px 5px 10px;">
                  <v-layout>
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
                    <h5 style="margin-top: 4px;">({{ hobbyReviewCnt[index] }} 개)</h5>
                  </v-layout>

                </div>

                <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString(), checkValue: true } }"
                             style="text-decoration: none; color: black"
                >
                  <div style="padding: 5px 10px 10px 10px; height: 60px;">
                    <h4>{{ item.title }}</h4>
                  </div>
                </router-link>
              </v-card>
            </v-hover>
          </div>

        </v-row>
      </v-layout>
    </v-container>
  </v-container>
</template>

<script>
import {mapActions, mapState} from "vuex";

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
      'hobbyProductRatingValue',
      'handmadeReviewCnt',
      'knowhowReviewCnt',
      'hobbyReviewCnt',
      'hobbyFavoriteProductCheck',
      'handmadeFavoriteProductCheck',
      'knowhowFavoriteProductCheck',
      'favoriteProductList'
    ]),
  },
  data() {
    return {
      showTooltip: false
    }
  },
  methods: {
    ...mapActions([
      'requestRegisterShoppingBucketProduct',
      'requestFavoriteProductCheckValue'
    ]),
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

    async addShoppingBucketProduct(item) {
      if (this.$store.state.signInCheckValue === false) {
        alert("로그인 후 사용가능합니다.")
        await this.$router.push({name: 'SignInView'})

      } else {
        const productId = item.productNo
        const nickname = this.$store.state.memberInfoAfterSignIn.nickname
        const productAmountValue = 1

        await this.requestRegisterShoppingBucketProduct({nickname, productId, productAmountValue})
      }
    },
    async favoriteProductManagement(index, category, item) {
      if (this.$store.state.signInCheckValue === false) {
        alert("로그인 후 사용가능합니다.")
        await this.$router.push({name: 'SignInView'})

      } else {
        if (category === '취미/특기') {
          await this.requestFavoriteProductCheckValue({index, category, item})
        } else if (category == "노하우") {
          await this.requestFavoriteProductCheckValue({index, category, item})
        } else {
          await this.requestFavoriteProductCheckValue({index, category, item})
        }
      }
    }
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
}
</script>

<style scoped>
.iconColor {
  margin: 0px 3px 3px 0px;
}

.iconColor:hover {
  margin: 0px 3px 3px 0px;
  color: #DAA520;
}

.cartIconColor {
  margin: 0px 3px 3px 0px;
}

.cartIconColor:hover {
  margin: 0px 3px 3px 0px;
  color: #2F4F4F;
}
</style>