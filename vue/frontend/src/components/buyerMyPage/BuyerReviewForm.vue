<template>
  <div>
    <buyer-nav/>

    <v-container style="width: 1400px">
      <buyer-my-page-top-nav :countByInfo="countByInfo"/>

      <v-container style="width: 1200px"
                   v-if="!myReviewList || (Array.isArray(myReviewList) && myReviewList.length === 0)">
        <div align="center">
          <h2>작성된 후기가 없습니다.</h2>
        </div>
      </v-container>

      <v-container style="width: 1000px" v-else>
        <h2 style="margin-bottom: 50px;">나의 후기</h2>
        <div class="reviewView"
             v-for="(review, index) in myReviewList" :key="index">
          <v-card style="width: 1000px; margin: 15px 0px 30px 0px;" flat>
            <v-layout style="padding: 0px 10px 10px 10px">
              <h4>{{ review.productTitle }}</h4>
              <v-spacer></v-spacer>
              <v-layout justify-end>
                <v-dialog
                    @click:outside="fn_cancel"
                    v-model="dialog"
                    persistent
                    max-width="568px"
                    :retain-focus="false"
                >
                  <template v-slot:activator="{on, attrs}">
                    <v-btn
                        plain
                        small
                        style="font-weight: bold"
                        v-bind="attrs"
                        v-on="on"
                        @click="reviewModify(index)"
                    >
                      수정
                    </v-btn>
                  </template>

                  <v-card height="780px">
                    <v-layout style="margin-left: 35px;">
                      <h3 style="padding: 20px 10px 10px 10px">후기 수정</h3>
                      <v-spacer></v-spacer>
                    </v-layout>

                    <v-divider style="margin: 0px 38px 0px 38px"></v-divider>

                    <v-layout style="margin-left: 35px;">
                      <v-card max-width="100"
                              style="padding: 15px 15px 15px 15px"
                              flat
                      >
                      </v-card>

                      <v-card width="400px"
                              flat
                              tile
                      >
                        <v-card-title style="font-weight: bold; font-size: 15px">
                          <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: reviewProductNo.toString(), checkValue: true } }"
                                       style="text-decoration: none; color: black">
                            {{ reviewProductTitle }}
                          </router-link>
                        </v-card-title>
                      </v-card>
                    </v-layout>

                    <v-divider style="margin: 10px 38px 10px 38px;"></v-divider>


                    <div align="center">
                      <v-card height="500" width="500" flat style="border: 1px solid black">
                        <v-card height="120px" tile>
                          <v-rating
                              color="#2F4F4F"
                              background-color="#2F4F4F"
                              style="padding-top: 22px"
                              empty-icon="mdi-star-outline"
                              full-icon="mdi-star"
                              hover
                              length="5"
                              size="50"
                              v-model="ratingValue"
                          >
                          </v-rating>
                          <div>
                            <h6>별표를 클릭하여 평가해주세요!</h6>
                          </div>
                        </v-card>

                        <v-card height="200" flat>
                          <v-textarea
                              v-model="reviewContent"
                              style="padding: 5px 5px 0px 5px;" height="200px" outlined/>
                        </v-card>

                        <v-layout align="start"
                                  style="padding: 15px 0px 0px 5px"
                                  class="justify-center"
                        >
                          <div v-if="files.length === 0">
                            <input type="file" id="imageFile" ref="imageFile"
                                   accept="image/png, image/jpeg, image/jpg"
                                   @change="handleImgFile" hidden/>
                            <label for="imageFile" width="100px" height="100px" plain>
                              <v-hover

                                  v-slot="{ hover }"
                              >
                                <v-card
                                    :elevation="hover ? 16 : 0"
                                    :class="{'on-hover' : hover}"
                                    width="100px" height="100px"
                                    style="border: 1px solid black">
                                  <v-icon style="margin-top: 37px;">
                                    mdi-camera
                                  </v-icon>
                                </v-card>
                              </v-hover>
                            </label>
                            <div style="margin-top: 10px; margin-left: 5px;" align="start">
                              <h6>▪사진 등록 후 재등록시 클릭해서 등록할 수 있습니다.</h6>
                              <h6>▪사진은 jpg, jpeg, png 형식으로 1개만 등록가능합니다.</h6>
                            </div>
                          </div>

                          <div v-else>
                            <input type="file" id="imageFile" ref="imageFile"
                                   @change="handleImgFile" hidden/>
                            <label for="imageFile" width="100px" height="100px" plain>
                              <v-card
                                  class="justify-center"
                                  width="100px" height="100px" elevation="0" style="border: 1px solid black"
                                  align="center"
                              >
                                <v-img
                                    height="100px"
                                    :src="files.preview"
                                >
                                </v-img>
                              </v-card>
                            </label>

                            <div style="margin-top: 10px; margin-left: 5px;">
                              <h6 style="margin-right: 19px;">사진 등록 후 재등록시 클릭해서 등록할 수 있습니다.</h6>
                              <h6>사진은 jpg, jpeg, png 형식으로 1개까지 등록가능합니다.</h6>
                            </div>
                          </div>
                        </v-layout>
                      </v-card>

                      <v-btn class="white--text" style="margin-top: 20px; background-color: #2F4F4F" plain
                             @click="modifyReview(index)"
                      >
                        수정하기
                      </v-btn>
                    </div>
                  </v-card>

                </v-dialog>

                <h3>|</h3>

                <v-dialog
                    @click:outside="deleteDialogClose"
                    v-model="deleteDialog"
                    persistent
                    max-width="368px"
                    :retain-focus="false"
                >
                  <template v-slot:activator="{on, attrs}">
                    <v-btn plain small style="font-weight: bold"
                           v-bind="attrs"
                           v-on="on"
                           @click="setDeleteReviewIndex(index)"
                    >
                      삭제
                    </v-btn>
                  </template>
                  <v-card style="height: 170px">
                    <div align="center">
                      <h2 style="padding-top: 30px;">후기를 삭제하시겠습니까?</h2>
                    </div>
                    <div align="center">
                      <v-btn @click="deleteReview()"
                             style="margin: 30px 10px 20px 0px; background-color: #2F4F4F; color: white">
                        확인
                      </v-btn>

                      <v-btn
                          @click="deleteDialog = false"
                          style="margin: 30px 0px 20px 0px; background-color: #2F4F4F; color: white"
                      >
                        취소
                      </v-btn>
                    </div>
                  </v-card>

                </v-dialog>

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


              <div class="reviewContent">
                <h5 style="font-weight: normal;">{{ review.regDate }}</h5>
              </div>
            </v-layout>

            <v-img
                style="height: 100px; width: 100px; margin: 5px 0px 0px 10px"
                :src="getMyReviewImg(index).reviewImage"
            >
            </v-img>

            <div style="margin: 30px 0px 0px 10px">
              <h4 style="font-size: 14px">{{ review.content }}</h4>
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
import {mapActions, mapState} from "vuex";

export default {
  name: "BuyerReviewForm",
  components: {
    BuyerMyPageTopNav,
    BuyerNav
  },
  props:{
    countByInfo:{
      type: Array
    }
  },
  computed: {
    ...mapState([
      'myQnaList',
      'myOrderInfoList',
      'myReviewList',
      'reviewImage',
      'recentlyViewedProductList'
    ])
  },
  data() {
    return {
      reviewIndex: 0,
      reviewModifyCheck: false,
      dialog: false,
      deleteDialog: false,
      reviewProductImg: [],
      reviewProductTitle: "",
      reviewProductQuantity: 0,
      ratingValue: 0,
      reviewContent: '',
      files: '',
      reviewProductNo: 0,
    }
  },
  methods: {
    ...mapActions([
      'requestModifyReviewFromSpring',
      'requestDeleteReviewToSpring',
      // 'requestReviewImageFromSpring'
    ]),
    deleteDialogClose() {
      this.deleteDialog = false
    },
    handleImgFile(e) {
      this.files = {
        file: e.target.files[0],
        preview: URL.createObjectURL(e.target.files[0])
      }
    },
    async modifyReview() {
      const starRating = this.ratingValue
      const content = this.reviewContent
      const files = this.files
      const reviewNo = this.reviewNo

      await this.requestModifyReviewFromSpring({reviewNo, starRating, content, files})
    },
    reviewModify(index) {
      this.reviewProductTitle = this.myReviewList[index].productTitle
      this.ratingValue = this.myReviewList[index].starRating
      this.reviewContent = this.myReviewList[index].content
      this.reviewNo = this.myReviewList[index].reviewNo

      console.log(this.reviewContent)
      console.log(this.reviewNo)
      console.log(this.ratingValue)
      console.log(this.reviewProductTitle)

      this.currentSelectedReviewProductNumber = index
      this.reviewProductNo = this.myReviewList[this.currentSelectedReviewProductNumber].productNo
    },
    getMyReviewImg(index) {
      return {
        ...this.reviewImage,
        reviewImage: this.reviewImage[index].editedName && require(`@/assets/reviewImg/${this.reviewImage[index].editedName}`)
      }
    },
    fn_cancel() {
      this.dialog = false
    },
    async deleteReview() {
      const reviewNo = this.myReviewList[this.reviewIndex].reviewNo

      await this.requestDeleteReviewToSpring(reviewNo)
      history.go(0)

      this.deleteDialog = false
    },
    setDeleteReviewIndex(index) {
      this.reviewIndex = index
    }
  },
  // async mounted() {
  //   this.reviewImage.splice(0)
  //   for (let i = 0; i < this.myReviewList.length; i++) {
  //     let reviewNo = this.myReviewList[i].reviewNo
  //
  //     await this.requestReviewImageFromSpring(reviewNo)
  //   }
  // }
}
</script>

<style scoped>
.reviewView {
  border-top: 1px solid black;
  border-bottom: 1px solid black;
  margin-top: 10px
}

.reviewContent {
  margin: 5px 0px 0px 5px;
}
</style>