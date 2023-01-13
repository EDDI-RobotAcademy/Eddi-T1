<template>
  <div>
    <buyer-nav/>

    <v-container style="width: 1400px">
      <buyer-my-page-top-nav :countByInfo="countByInfo"/>

      <v-container style="width: 1000px">
        <h2 style="margin-bottom: 50px;">마이 리뷰</h2>
        <div class="reviewView"
             v-for="(review, index) in buyerReViewList" :key="index">
          <v-card style="width: 1000px; margin: 15px 0px 30px 0px;" flat>
            <v-layout style="padding: 0px 10px 10px 10px">
              <h4>{{review.productTitle}}</h4>
              <v-spacer></v-spacer>
              <v-layout justify-end>
                <v-btn
                    plain
                    small
                    style="font-weight: bold"
                    @click="reviewModify(index)"
                >
                  수정
                </v-btn>
                <h3>|</h3>
                <v-btn plain small style="font-weight: bold">
                  삭제
                </v-btn>
              </v-layout>
            </v-layout>

            <v-divider></v-divider>

            <v-layout style="padding: 10px 10px 10px 10px;">
              <v-rating
                  color="#DAA520"
                  background-color="#DAA520"
                  empty-icon="mdi-star-outline"
                  full-icon="mdi-star"
                  hover
                  dense
                  length="5"
                  size="18"
                  v-model="review.starRating"
                  readonly
              >
              </v-rating>


              <div v-if="!reviewModifyCheck" class="reviewContent">
                <h5 style="font-weight: normal;">{{review.regDate}}</h5>
              </div>
              <div v-else class="reviewContent">
                <h5 style="font-weight: normal;">{{review.upDate}} 수정</h5>
              </div>
            </v-layout>

            <v-img
                style="height: 100px; width: 100px; margin: 5px 0px 0px 10px"
                :src="require('@/assets/reviewImg/' + buyerReviewImgList[index].editedName)"
            >
            </v-img>

            <div style="margin: 30px 0px 0px 10px">
              <h4 style="font-size: 14px">{{ review.content}}</h4>
            </div>

          </v-card>
        </div>
      </v-container>
    </v-container>
  </div>
</template>

<script>
import BuyerNav from "@/components/buyerMyPage/BuyerNav";
import BuyerMyPageTopNav from "@/components/buyerMyPage/BuyerMyPageTopNav";
import {mapState} from "vuex";

export default {
  name: "BuyerReviewForm",
  components:{
    BuyerMyPageTopNav,
    BuyerNav
  },
  computed: {
    ...mapState([
      'myQnaList',
      'myOrderInfoList',
    ])
  },
  data(){
    return{
      reviewModifyCheck: false,
      countByInfo: [],
      buyerReViewList: [
        {
          reviewNo: 1,
          writer: "gggg",
          starRating: 5,
          content: "리뷰테스트 데이터",
          regDate: "2023-01-13",
          upDate: "2023-01-20",
          productNo: 1,
          productTitle: "🪐리뉴얼 [커스텀] colorful day 이니셜 집게핀🪐"
        }
      ],
      buyerReviewImgList: [
        {
          reviewImageId: 1,
          editedName: "2e88e4cb-8a59-422c-9251-21a8f7d51bcc자몽8.jpg"
        }
      ]
    }
  },
  methods:{
    reviewModify(index){
      console.log(index)
      this.reviewModifyCheck = true
    }
  },
  async created() {
    const infoNum = new Array
    infoNum.push(this.myOrderInfoList.length)
    infoNum.push(this.myQnaList.length)
    infoNum.push(this.buyerReViewList.length)

    this.countByInfo = infoNum


  },
}
</script>

<style scoped>
.reviewView{
  border-top: 1px solid black;
  border-bottom: 1px solid black;
  margin-top: 10px
}
.reviewContent{
  margin: 5px 0px 0px 5px;
}
</style>