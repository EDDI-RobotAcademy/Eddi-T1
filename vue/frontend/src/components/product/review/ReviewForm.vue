<template>
  <div>
<!--    총 개수 : {{ productReviewCnt }}-->

    <v-card flat style="margin-left: 25px; margin-top: 20px" width="95%">

      <v-layout
          v-for="(itemList, index) in paginatedOrders" :key="index"
      >

        <v-card max-width="230px"
                style="padding: 25px 25px 25px 25px; border-bottom: 1px solid #eaebee;"
                flat
        >
          <v-img
              height="180px" flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 10px;"
              :src="getReviewImg(index).reviewImgList">
          </v-img>
        </v-card>

        <v-card width="100%"
                flat
                style="border-bottom: 1px solid #eaebee; margin-top: 15px"
                tile
        >
          <v-card-title style="font-weight: bold; font-size: 15px">
            <router-link to="null" style="text-decoration: none; color: black">
              {{ itemList.writer }}
            </router-link>

            <v-spacer></v-spacer>
            <v-rating
                :value="itemList.starRating"
                background-color="orange lighten-3"
                color="orange"
                small
                dense hover readonly>
            </v-rating>

          </v-card-title>

          <v-card-subtitle style="font-size: 12px; font-weight: bold">
            {{ itemList.regDate | date }}
          </v-card-subtitle>

          <v-card-title style="padding-top: 0px; font-weight: normal; font-size: 16px; color: black">
            {{itemList.content}}
          </v-card-title>
        </v-card>

      </v-layout>

      <v-btn
          @click="loadMore()"
          block
          large
          dense
          outlined
          v-bind="attrs"
          v-on="on"
          width="140px"
          elevation="0"
          style="color: #2F4F4F; margin-top: 10px; margin-right: 10px;"
          v-if="currentPage * maxPerPage < productReviewList.length"
      >
        더보기 <v-icon size="25" color="#2F4F4F">mdi-chevron-down</v-icon>
      </v-btn>

    </v-card>

  </div>

</template>


<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "ReviewForm",
  props: {
    productNo: {
      type: String,
      required: true,
    },
  },
  computed: {
    ...mapState([
        'productReviewList',
        'productNextReviewList',
        'reviewImage',
        'productReviewCnt'
    ]),
    totalResults() {
      return Object.keys(this.productReviewList).length;
    },
    pageCount() {
      return Math.ceil(this.totalResults / this.maxPerPage);
    },
    pageOffest() {
      return this.maxPerPage * this.currentPage;
    },
    paginatedOrders() {
      return this.productReviewList.slice(0, this.currentPage * this.maxPerPage);
    }
  },
  data() {
    return {
      page: 1,
      /*pageCount: 0,*/
      productReviewCnt: this.$store.state.productReviewCnt,

      currentPage: 1,
      maxPerPage: 3,
      showReadMore: true
    }
  },
  filters: {
    date : function(data){
      const reqdString = data.split("").slice(0, 10).join("");
      if (data.length < 10) {
        return reqdString
      } else {
        return reqdString ;
      }
    },
    nameFormat(val){
      return String(val).replace(/(?<=.{2})./gi,"*");
    }
  },
  methods: {
    ...mapActions([
        'requestProductReviewListFromSpring',
       /* 'requestNextReviewListFromSpring',*/
        'requestReviewImageFromSpring',
        'requestReviewCntFromSpring',
    ]),
    getReviewImg(index) {
     return {
       ...this.reviewImage,
       reviewImgList: this.reviewImage[index] && require(`@/assets/reviewImg/${this.reviewImage[index].editedName}`)
     }
    },

    loadMore() {
      this.currentPage += 1;
    },
  },

  async mounted() {
    //리뷰 총 개수
    const productNo = this.productNo
    await this.requestReviewCntFromSpring(productNo)
    console.log("productReviewCnt: " + this.productReviewCnt)


    //리뷰리스트 불러오기
    console.log("productNo: "+ this.productNo)
    /*const productNo = this.productNo*/
    const reviewSize = Number(this.productReviewCnt)

    await this.requestProductReviewListFromSpring({productNo, reviewSize})


    //쌓인 이미지 초기화
    this.reviewImage.splice(0)
    //리뷰 이미지 가져오기
    for (let i = 0; i < this.productReviewList.length; i++) {
      const reviewNo = this.productReviewList[i].reviewNo

      await this.requestReviewImageFromSpring(reviewNo)
    }
    console.log("reviewImage: " + this.reviewImage)

  },

}
</script>

<style scoped>

</style>