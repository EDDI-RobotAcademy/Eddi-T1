<template>
  <div>
    <buyer-nav/>

    <v-container style="width: 1400px">
      <buyer-my-page-top-nav :myPageCategoryItems="myPageCategoryItems"
                             :countByInfo="countByInfo"
      />


      <!--최근 주문내역-->
      <v-container style="width: 1200px; margin-top: 80px">
        <v-layout>
          <h3>최근 주문내역</h3>
          <v-spacer></v-spacer>
        </v-layout>

        <v-container style="width: 850px; margin-top: 30px">

          <!--최근 주문상품 주문번호/주문일자로 분류-->
          <div v-for="(orderNo, index) in this.orderNoList" :key="index">
            <v-card flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 20px" >
              <v-card-subtitle style="border-bottom: 1px solid #eaebee">
                <v-layout>
                  {{ orderNo }} | {{ orderDateList[index] }}
                  <v-spacer></v-spacer>

                  <!--최근 주문상품 상세페이지로 이동-->
                  <router-link :to="{name: 'OrderDetailView', params: {orderNo: index}}" style="text-decoration: none; color: black">
                    <h5 style="text-decoration: none; color: black">주문상세보기 ></h5>
                  </router-link>
                </v-layout>
              </v-card-subtitle>


              <!--한 주문 건에 따른 상품 개수-->
              <div v-for="(itemList, i) in myOrderInfoList" :key="i">
                <div v-if="orderNoList[index] === itemList.orderNo" style="border-bottom: 1px solid #eaebee">

                  <!--상품대표이미지-->
                  <v-layout>
                    <v-card max-width="100"
                        style="padding: 15px 15px 15px 15px"
                        flat>
                  <v-img
                      height="75px"
                      :src="require('@/assets/productImg/' + itemList.product.productImages[0].editedName)">
                  </v-img>
                </v-card>

                <v-card width="450px"
                        flat
                        style="border-right: 1px solid #eaebee;"
                        tile
                >
                  <v-card-title style="font-weight: bold; font-size: 15px" >
                    <!--주문상태 chip-->
                    <div style="margin-right: 100%">
                    <v-chip outlined style="float: right;" color="#DAA520" x-small v-if="itemList.orderStatus == 'PAYMENT_COMPLETE'">결제 완료</v-chip>
                    <v-chip outlined style="float: right;" color="#44a4fc" x-small v-if="itemList.orderStatus == 'DELIVERING'">배송 중</v-chip>
                    <v-chip outlined style="float: right;" color="green" x-small v-if="itemList.orderStatus == 'DELIVERED'">배송 완료</v-chip>
                    <v-chip outlined style="float: right;" color="warning" x-small v-if="itemList.orderStatus == 'EXCHANGE'">교환</v-chip>
                    <v-chip outlined style="float: right;" color="grey" x-small v-if="itemList.orderStatus == 'CANCEL'">취소</v-chip>
                    <v-chip outlined style="float: right;" color="red" x-small v-if="itemList.orderStatus == 'REFUND'">환불</v-chip>
                    </div>

                    <div style="overflow: hidden">
                    <!--상품명(상세페이지연결)-->
                      <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: itemList.product.productNo.toString() } }" style="text-decoration: none; color: black;" >
                        {{ itemList.product.title }}
                      </router-link>
                    </div>

                  </v-card-title>

                  <v-card-subtitle style="font-size: 12px">
                    {{ itemList.product.productInfo.category }} | {{ itemList.product.price | comma }}원 | {{ itemList.quantity }}개
                  </v-card-subtitle>
                </v-card>

                <v-card flat
                        style="border-right: 1px solid #eaebee;"
                        tile
                        width="200px"
                >
                  <v-layout justify-center style="padding: 1px; margin-bottom: -13px;  margin-top: 8px">
                    <v-card-title style="font-size: 15px">
                      <h5>{{ itemList.product.nickname }}</h5>
                    </v-card-title>
                  </v-layout>

                  <v-card-subtitle align="center">

                    <!--문의하기 버튼 / 문의 등록 dialog-->
                    <v-dialog
                        v-model="dialogQna"
                        @click:outside="fn_cancel2"
                        persistent
                        max-width="568px"
                        :retain-focus="false"
                    >
                      <template v-slot:activator="{on, attrs}">
                        <v-btn
                            small
                            v-bind="attrs"
                            v-on="on"
                            width="98px"
                            elevation="0"
                            style="background-color: #2F4F4F; color: white; margin-top: -35px;"
                            @click="setProductQna(i)"
                        >
                          문의하기
                        </v-btn>
                      </template>
                      <v-card height="auto">
                        <v-layout style="margin-left: 35px">
                          <h3 style="padding: 20px 10px 10px 10px">문의 작성</h3>
                          <v-spacer></v-spacer>
                        </v-layout>

                        <v-divider style="margin: 0px 38px 0px 38px"></v-divider>

                        <v-layout style="margin-left: 35px">
                          <v-card max-width="100"
                                  style="padding: 15px 15px 15px 15px"
                                  flat
                          >
                            <v-img
                                height="75px"
                                :src="require(`@/assets/productImg/${qnaProductImg}`)">
                            </v-img>
                          </v-card>

                          <v-card width="400px"
                                  flat
                                  tile
                          >
                            <v-card-title style="font-weight: bold; font-size: 15px">
                              <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: qnaProductNo.toString() } }"
                                           style="text-decoration: none; color: black">
                                {{ qnaProductTitle }}
                              </router-link>
                            </v-card-title>

                            <v-card-subtitle style="font-size: 12px">
                              {{ qnaProductQuantity }}개
                            </v-card-subtitle>
                          </v-card>
                        </v-layout>

                        <v-divider style="margin: 10px 38px 10px 38px;"></v-divider>

                        <div align="center">
                          <v-card height="auto" width="500" flat style="border: 1px solid transparent">

                            <v-select
                                v-model="qnaCategory" label="카테고리" color="#2F4F4F" :items="categoryList" required
                                :rules="categoryRule"/>

                            <v-text-field
                                v-model="qnaTitle" label="제목" color="#2F4F4F" required
                                :rules="titleRule"/>

                            <v-text-field
                                :value="writer" label="작성자" color="#2F4F4F" readonly required/>

                            <v-textarea
                                v-model="qnaContent" label="내용" counter outlined clearable
                                row-height="60" clear-icon="mdi-close-circle" color="#2F4F4F" auto-grow required
                                :rules="contentRule"/>

                            <v-checkbox v-model="checkStatus" row style="margin-top: -20px; color: #DAA520"
                                        label="비밀글로 작성하기">
                            </v-checkbox>

                          </v-card>

                          <v-btn style="margin-top: -90px; background-color: #2F4F4F; color: white" plain
                                 @click="registerQna()"
                          >
                            등록하기
                          </v-btn>
                        </div>
                      </v-card>
                    </v-dialog>

                  </v-card-subtitle>
                </v-card>

                    <v-card flat align="center">
                      <div style="margin-top: 35px;">
                        <v-dialog
                            v-model="dialog"
                            @click:outside="fn_cancel"
                            persistent
                            max-width="568px"
                            :retain-focus="false"
                        >
                          <template v-slot:activator="{on, attrs}">
                            <v-btn x-small
                                   v-bind="attrs"
                                   v-on="on"
                                   :disabled="itemList.orderStatus == 'PAYMENT_COMPLETE' || itemList.orderStatus == 'DELIVERING' || itemList.orderStatus == 'CANCEL'"
                                   width="98px"
                                   elevation="0"
                                   style="background-color: #DAA520;
                                   margin-top: -15px;
                                   color: white"
                                   @click="setProductReview(i)"
                            >
                              <h3 style="font-weight: normal">구매후기 작성</h3>
                            </v-btn>
                          </template>
                          <v-card height="780px">
                            <v-layout style="margin-left: 35px;">
                              <h3 style="padding: 20px 10px 10px 10px">리뷰 작성</h3>
                              <v-spacer></v-spacer>
                            </v-layout>

                            <v-divider style="margin: 0px 38px 0px 38px"></v-divider>

                            <v-layout style="margin-left: 35px;">
                              <v-card max-width="100"
                                      style="padding: 15px 15px 15px 15px"
                                      flat
                              >
                                <v-img
                                    height="75px"
                                    :src="require(`@/assets/productImg/${reviewProductImg}`)">
                                </v-img>
                              </v-card>

                              <v-card width="400px"
                                      flat
                                      tile
                              >
                                <v-card-title style="font-weight: bold; font-size: 15px">
                                  <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: reviewProductNo.toString() } }"
                                               style="text-decoration: none; color: black">
                                    {{ reviewProductTitle }}
                                  </router-link>
                                </v-card-title>

                                <v-card-subtitle style="font-size: 12px">
                                  {{ reviewProductQuantity }}개
                                </v-card-subtitle>
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
                                     @click="registerReview()"
                              >
                                등록하기
                              </v-btn>
                            </div>
                          </v-card>
                        </v-dialog>


                    <v-btn x-small
                           :disabled="itemList.orderStatus == 'PAYMENT_COMPLETE'|| itemList.orderStatus == 'CANCEL'"
                           outlined class="#2F4F4F"
                           width="98px"
                           elevation="0"
                           onclick="window.open('https://m.search.daum.net/search?w=tot&year=2022&q=%ED%83%9D%EB%B0%B0%EB%B0%B0%EC%86%A1%EC%A1%B0%ED%9A%8C+')"
                    >
                      <h3 style="font-weight: normal">배송 조회</h3>
                    </v-btn>

                  </div>
                </v-card>
              </v-layout>
                </div>
              </div>
            </v-card>
          </div>
        </v-container>
      </v-container>


<!--      &lt;!&ndash;취소 및 반품 내역&ndash;&gt;-->
<!--      <v-container style="width: 1200px; margin-top: 80px">-->
<!--        <v-layout>-->
<!--          <h3>취소/반품 내역</h3>-->
<!--          <v-spacer></v-spacer>-->
<!--          <router-link to="null" style="text-decoration: none; color: black">-->
<!--            <h4 style="font-size: 13px">더보기></h4>-->
<!--          </router-link>-->
<!--        </v-layout>-->

<!--        <v-container style="width: 800px; margin-top: 30px">-->
<!--          <div>-->
<!--            <v-card style="border: 1px solid black; margin-top: 10px;">-->
<!--              <v-card-subtitle style="border-bottom: 1px solid black">-->
<!--                <v-layout>-->
<!--                    취소 접수일: <h4>2022-12-20</h4> &nbsp;| 주문일: <h4>2022-12-20</h4> &nbsp;| 주문번호: <h4>202212200000001</h4>-->
<!--                  <v-spacer></v-spacer>-->

<!--                  <router-link to="null" style="text-decoration: none; color: black">-->
<!--                    &lt;!&ndash;                  <h5>{{ itemList.price }} ></h5>&ndash;&gt;-->
<!--                    <h5>35,000원</h5>-->
<!--                  </router-link>-->
<!--                </v-layout>-->
<!--              </v-card-subtitle>-->

<!--              <v-layout>-->
<!--                <v-card max-width="100"-->
<!--                        style="padding: 15px 15px 15px 15px"-->
<!--                        flat-->
<!--                >-->
<!--                  <v-img-->
<!--                      height="75px"-->
<!--                      src="@/assets/productImg/상품이미지1.jpg"-->
<!--                  >-->
<!--                  </v-img>-->
<!--                </v-card>-->

<!--                <v-card width="400px"-->
<!--                        flat-->
<!--                        style="border-right: 1px solid black"-->
<!--                        tile-->
<!--                >-->
<!--                  <v-card-title style="font-weight: bold; font-size: 15px">-->
<!--                    <router-link to="null" style="text-decoration: none; color: black">-->
<!--                      &lt;!&ndash;                    {{ itemList.productTitle }}&ndash;&gt;-->
<!--                      핸드메이드 상품-->
<!--                    </router-link>-->
<!--                  </v-card-title>-->

<!--                  <v-card-subtitle style="font-size: 12px">-->
<!--                    &lt;!&ndash;                  {{ itemList.optionsList }} : {{ itemList.quantity }}개&ndash;&gt;-->
<!--                    수제 케익 : 1개-->
<!--                  </v-card-subtitle>-->
<!--                </v-card>-->

<!--                <v-card flat-->
<!--                        style="border-right: 1px solid black"-->
<!--                        tile-->
<!--                        width="200px"-->
<!--                >-->
<!--                  <v-layout justify-center style="padding: 1px">-->
<!--                    <v-card-title style="font-size: 15px">-->
<!--                      &lt;!&ndash;                    <h5>{{ itemList.seller }}</h5>&ndash;&gt;-->
<!--                      <h5> 핸드메이드 판매자 </h5>-->
<!--                    </v-card-title>-->
<!--                  </v-layout>-->

<!--                  <v-card-subtitle align="center">-->
<!--                    <v-btn-->
<!--                        small-->
<!--                        elevation="0"-->
<!--                        style="background-color: #2F4F4F; color: white; margin-top: -35px;"-->
<!--                    >-->
<!--                      문의하기-->
<!--                    </v-btn>-->
<!--                  </v-card-subtitle>-->
<!--                </v-card>-->

<!--                <v-card flat align="center">-->
<!--                  <div style="margin: 50px 0px 0px 5px">-->
<!--                    <h4>취소완료</h4>-->
<!--                  </div>-->
<!--                </v-card>-->
<!--              </v-layout>-->
<!--            </v-card>-->
<!--          </div>-->
<!--        </v-container>-->
<!--      </v-container>-->

<!--      <v-container style="width: 1200px; margin-top: 80px">-->
<!--        <v-layout>-->
<!--          <h3>최근 본 상품</h3>-->
<!--          <v-spacer></v-spacer>-->
<!--          <router-link to="null" style="text-decoration: none; color: black">-->
<!--            <h4 style="font-size: 13px">더보기></h4>-->
<!--          </router-link>-->
<!--        </v-layout>-->
<!--      </v-container>-->

<!--      <v-container style="width: 1000px; margin-top: 80px">-->
<!--        <v-layout>-->
<!--          <v-row class="justify-start">-->
<!--            <v-card-->
<!--                    class="ma-4"-->
<!--                    max-width="210"-->
<!--                    style="margin-right: 20px"-->
<!--            >-->
<!--              <v-img-->
<!--                  class="white&#45;&#45;text align-end"-->
<!--                  height="200px"-->
<!--                  src="@/assets/productImg/상품이미지1.jpg"-->
<!--              >-->
<!--              </v-img>-->
<!--              <v-card-subtitle class="pb-0">-->
<!--&lt;!&ndash;                {{ item.sellerNickname }}&ndash;&gt;-->
<!--                핸드메이드 판매자-->
<!--              </v-card-subtitle>-->
<!--              <v-card-title>-->
<!--&lt;!&ndash;                <h4>{{ item.commodityTitle }}</h4>&ndash;&gt;-->
<!--                <h4>핸드메이드 상품</h4>-->
<!--              </v-card-title>-->
<!--              <v-divider></v-divider>-->

<!--              <v-card-text class="text&#45;&#45;primary">-->
<!--&lt;!&ndash;                {{ item.contents }}&ndash;&gt;-->
<!--                핸드메이드 상품 설명-->
<!--              </v-card-text>-->

<!--            </v-card>-->
<!--            <v-card-->
<!--                class="ma-4"-->
<!--                max-width="210"-->
<!--            >-->
<!--              <v-img-->
<!--                  class="white&#45;&#45;text align-end"-->
<!--                  height="200px"-->
<!--                  src="@/assets/productImg/상품이미지1.jpg"-->
<!--              >-->
<!--              </v-img>-->
<!--              <v-card-subtitle class="pb-0">-->
<!--                &lt;!&ndash;                {{ item.sellerNickname }}&ndash;&gt;-->
<!--                핸드메이드 판매자-->
<!--              </v-card-subtitle>-->
<!--              <v-card-title>-->
<!--                &lt;!&ndash;                <h4>{{ item.commodityTitle }}</h4>&ndash;&gt;-->
<!--                <h4>핸드메이드 상품</h4>-->
<!--              </v-card-title>-->
<!--              <v-divider></v-divider>-->

<!--              <v-card-text class="text&#45;&#45;primary">-->
<!--                &lt;!&ndash;                {{ item.contents }}&ndash;&gt;-->
<!--                핸드메이드 상품 설명-->
<!--              </v-card-text>-->

<!--            </v-card><v-card-->
<!--              class="ma-4"-->
<!--              max-width="210"-->
<!--          >-->
<!--            <v-img-->
<!--                class="white&#45;&#45;text align-end"-->
<!--                height="200px"-->
<!--                src="@/assets/productImg/상품이미지1.jpg"-->
<!--            >-->
<!--            </v-img>-->
<!--            <v-card-subtitle class="pb-0">-->
<!--              &lt;!&ndash;                {{ item.sellerNickname }}&ndash;&gt;-->
<!--              핸드메이드 판매자-->
<!--            </v-card-subtitle>-->
<!--            <v-card-title>-->
<!--              &lt;!&ndash;                <h4>{{ item.commodityTitle }}</h4>&ndash;&gt;-->
<!--              <h4>핸드메이드 상품</h4>-->
<!--            </v-card-title>-->
<!--            <v-divider></v-divider>-->

<!--            <v-card-text class="text&#45;&#45;primary">-->
<!--              &lt;!&ndash;                {{ item.contents }}&ndash;&gt;-->
<!--              핸드메이드 상품 설명-->
<!--            </v-card-text>-->

<!--          </v-card>-->
<!--            <v-card-->
<!--                class="ma-4"-->
<!--                max-width="210"-->
<!--            >-->
<!--              <v-img-->
<!--                  class="white&#45;&#45;text align-end"-->
<!--                  height="200px"-->
<!--                  src="@/assets/productImg/상품이미지1.jpg"-->
<!--              >-->
<!--              </v-img>-->
<!--              <v-card-subtitle class="pb-0">-->
<!--                &lt;!&ndash;                {{ item.sellerNickname }}&ndash;&gt;-->
<!--                핸드메이드 판매자-->
<!--              </v-card-subtitle>-->
<!--              <v-card-title>-->
<!--                &lt;!&ndash;                <h4>{{ item.commodityTitle }}</h4>&ndash;&gt;-->
<!--                <h4>핸드메이드 상품</h4>-->
<!--              </v-card-title>-->
<!--              <v-divider></v-divider>-->

<!--              <v-card-text class="text&#45;&#45;primary">-->
<!--                &lt;!&ndash;                {{ item.contents }}&ndash;&gt;-->
<!--                핸드메이드 상품 설명-->
<!--              </v-card-text>-->

<!--            </v-card>-->
<!--          </v-row>-->
<!--        </v-layout>-->
<!--      </v-container>-->
    </v-container>
  </div>
</template>

<script>
import BuyerNav from "@/components/buyerMyPage/BuyerNav";
import {mapActions, mapState} from "vuex";
import buyerMyPageTopNav from "@/components/buyerMyPage/buyerMyPageTopNav";
import BuyerMyPageTopNav from "@/components/buyerMyPage/buyerMyPageTopNav";

export default {
  name: "BuyerMyPageForm",
  components: {BuyerMyPageTopNav, buyerMyPageTopNav, BuyerNav},
  computed: {
    ...mapState([
        'myOrderInfoList',
        'myQnaList'
    ])
  },
  data() {
    return {
      dialog: false,
      reviewContent: '',
      ratingValue: 0,
      files: '',
      totalPrice: 3000,
      orderListCount: 0,
      orderListBtnName:[
        {name: '구매후기 작성'},
        {name: '배송 조회'},
      ],
      myPageCategoryItems: [
        {title: "최근 주문내역"},
        {title: "문의 내역"},
        {title: "작성한 리뷰 내역"},
        {title: "최근 본 상품 내역"},
      ],

      orderNoList: [],
      orderDateList: [],
      reviewProductTitle: "",
      reviewProductQuantity: 0,
      reviewProductImg: [],
      currentSelectedReviewProductNumber: 0,
      reviewProductNo: 0,


      qnaProductImg: [],
      qnaProductTitle: '',
      currentSelectedQnaProductNumber: 0,
      qnaProductNo: 0,
      qnaProductQuantity: 0,

      dialogQna: false,
      writer: this.$store.state.memberInfoAfterSignIn.nickname,
      qnaCategory: '',
      categoryList : ['상품 문의', '배송 문의', '환불/취소 문의','교환 문의','기타'],
      qnaTitle: '',
      qnaContent: '',
      checkStatus: '',
      categoryRule: [
        v => !!v || '카테고리를 선택해주세요.'
      ],
      titleRule: [
        v => !(v.length >= 70) || '70자 이상 입력할 수 없습니다.'
      ],
      contentRule: [
        v => !(v.length >= 500) || '500자 이상 입력할 수 없습니다.'
      ],
      countByInfo: []
    }
  },
  //숫자 콤마
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
  methods: {
    ...mapActions([
      'requestRegisterQnaFromSpring',
      'requestRegisterReviewFromSpring'
    ]),
    handleImgFile(e) {
      this.files = {
        file: e.target.files[0],
        preview: URL.createObjectURL(e.target.files[0])
      }
    },
    async registerQna() {

      const productNo = this.myOrderInfoList[this.currentSelectedQnaProductNumber].product.productNo
      const writer = this.$store.state.memberInfoAfterSignIn.nickname
      const questionCategory = this.qnaCategory
      const questionTitle = this.qnaTitle
      const questionContent = this.qnaContent
      const openStatus =  this.checkStatus == true ? false : true

      await this.requestRegisterQnaFromSpring({productNo, writer, questionCategory, questionTitle, questionContent, openStatus})
      this.dialogQna = false
    },
    async registerReview() {

      const productNo = this.myOrderInfoList[this.currentSelectedReviewProductNumber].product.productNo
      const writer = this.$store.state.memberInfoAfterSignIn.nickname
      const starRating = this.ratingValue
      const content = this.reviewContent
      const files = this.files

      await this.requestRegisterReviewFromSpring({productNo, writer, starRating, content, files})
      this.dialog = false
    },
    fn_cancel() {
      this.dialog = false
    },
    fn_cancel2() {
      this.dialogQna = false
    },
    setProductReview(i) {
      this.reviewProductTitle = this.myOrderInfoList[i].product.title
      this.reviewProductQuantity = this.myOrderInfoList[i].quantity

      this.reviewProductImg = this.myOrderInfoList[i].product.productImages[0].editedName
      this.currentSelectedReviewProductNumber = i
      this.reviewProductNo = this.myOrderInfoList[this.currentSelectedReviewProductNumber].product.productNo
    },
    setProductQna(i) {
      this.qnaProductTitle = this.myOrderInfoList[i].product.title
      this.qnaProductQuantity = this.myOrderInfoList[i].quantity

      this.qnaProductImg = this.myOrderInfoList[i].product.productImages[0].editedName
      this.currentSelectedQnaProductNumber = i
      this.qnaProductNo = this.myOrderInfoList[this.currentSelectedReviewProductNumber].product.productNo
    },
  },
  async mounted(){
    //주문상품의 orderNo 리스트
    const orderNoList = new Array()
    for (let i = 0; i < this.myOrderInfoList.length; i++) {
      orderNoList.push(this.myOrderInfoList[i].orderNo)
    }
    this.orderNoList = [...new Set(orderNoList)]


    const orderDateList = new Array()
    for (let i = 0; i < this.myOrderInfoList.length; i++) {
      orderDateList.push(this.myOrderInfoList[i].orderDate)
    }
    this.orderDateList = [...new Set(orderDateList)]

    const handmadeListLength = this.orderListCategoryItems[0].contentList.length;
    const knowHowListLength = this.orderListCategoryItems[1].contentList.length;
    const hobbyListLength = this.orderListCategoryItems[2].contentList.length;

    const orderListTotalCount = handmadeListLength + knowHowListLength + hobbyListLength

    this.$set(this.myPageCategoryItems[0], 'count', orderListTotalCount)

  },
  async created() {
    //리뷰페이지 상품 이미지 받는 로직
    //상품 이미지 받기전 상품 이미지 받을 변수 초기화작업
    this.reviewProductImg.push(this.myOrderInfoList[0].product.productImages[0].editedName)
    console.log(this.myQnaList.length)

    //문의페이지 상품 이미지 받는 로직
    //문의 이미지 받기전 받을 변수 초기화
    this.qnaProductImg.push(this.myOrderInfoList[0].product.productImages[0].editedName)

    const infoNum = new Array
    infoNum.push(this.myOrderInfoList.length)
    infoNum.push(this.myQnaList.length)

    this.countByInfo = infoNum
  }
}
</script>

<style scoped>

</style>