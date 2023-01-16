<template>
  <v-container>
    <form @submit.prevent="onSubmit" >

      <div id="content">

        <!--판매자 수정/삭제 버튼-->
        <v-row v-if="product.nickname == this.$store.state.memberInfoAfterSignIn.nickname">
          <v-menu offset-y bottom>
            <template v-slot:activator="{ attrs, on }">
              <v-btn
                  class="ectBtn"
                  color="white"
                  dark
                  elevation="0"
                  v-bind="attrs"
                  v-on="on"
              >
                <v-icon style="color: #2F4F4F" size="50"> mdi-dots-horizontal </v-icon>
              </v-btn>
            </template>
            <v-list class="white" dark>
              <v-list-item>
                <v-dialog persisten max-width="400">
                  <template v-slot:activator="{ on }">
                    <a v-on="on" style="color:#2F4F4F">Modify</a>
                  </template>
                  <template v-slot:default="dialog">
                    <v-card>
                      <v-card-title class="headline">
                        이 상품을 수정하시겠습니까?
                      </v-card-title>
                      <v-card-text >
                        * 새로운 상품 사진 등록이 필요합니다
                      </v-card-text>
                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn text color="#DAA520" @click="dialog.value=false">
                          수정 취소
                        </v-btn>
                        <v-btn text @click="onModify()">
                          수정
                        </v-btn>
                      </v-card-actions>
                    </v-card>
                  </template>
                </v-dialog>
              </v-list-item>

              <v-list-item>
                <v-dialog persisten max-width="400">
                  <template v-slot:activator="{ on }">
                    <a v-on="on" style="color:#2F4F4F">Delete</a>
                  </template>
                  <template v-slot:default="dialog">
                    <v-card>
                      <v-card-title class="headline">
                        상품을 삭제하시겠습니까?
                      </v-card-title>
                      <v-card-text >
                        * 삭제된 상품은 복구할 수 없습니다
                      </v-card-text>
                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn text color="#DAA520" @click="dialog.value=false">
                          삭제 안 함
                        </v-btn>
                        <v-btn text @click="onDelete()">
                          삭제
                        </v-btn>
                      </v-card-actions>
                    </v-card>
                  </template>
                </v-dialog>
              </v-list-item>
            </v-list>
          </v-menu>
        </v-row>


        <!--상품사진-->
      <table>
        <div class="row">
          <div class="col-md-5 col-sm-5 col-xs-12">

            <div>
              <v-img contain width="440px" height="380px"
                     :src="require('@/assets/productImg/' + product.productImages[this.imgIdx].editedName)"></v-img>
            </div>

            <template>
                <v-tabs width="400" height="100"
                        show-arrows background-color="transparent"
                        v-model="tab2"
                >
                  <v-tab @click="selectedImg(index)"
                      v-for="(item, index) in product.productImages"
                      :key="index"
                  >

                    <v-card width="80px" height="80px">
                      <div class="image-box">
                        <v-img :src="require('@/assets/productImg/' + item.editedName)"></v-img>
                      </div>
                    </v-card>
                  </v-tab>
                </v-tabs>
            </template>
          </div>


        <div class="col-md-6 col-sm-7 col-xs-12">
            <div style="margin: 0 0 50px 50px">
            <div class="pl-6">

              <!--상호프로필이미지-->
              <h5>
                <v-avatar
                  :size="23"
                  color="grey lighten-4"
              >
                <img src="@/assets/default_profile_image.png" alt="avatar">
              </v-avatar>

                <!--상호명-->
                {{ product.nickname }}</h5>

              <!--상품명-->
              <h2 class="display-1 mb-0">{{ product.title }}</h2>

              <!--가격-->
              <v-card-actions class="pa-0">
                <p class="headline font-weight-light pt-3"> {{ product.price | comma }}원</p>
                <v-spacer></v-spacer>
              </v-card-actions>

              <!--카테고리-->
              <v-col>
                <v-row>
                  <p class="title">CATEGORY</p>
                  <col class="col-sm-2 mr-3">
                  <p class="subTitle">{{ product.productInfo.category }}</p>
                </v-row>
              </v-col>

              <!--별점-->
              <v-col>
                <v-row>
                  <p class="title">REVIEW</p>
                  <col class="col-sm-3 mr-0">
                  <v-rating
                    :value=" productRatingAvg "
                    background-color="orange lighten-3"
                    color="orange"
                    small dense hover readonly>
                  </v-rating>

                  <!--별점 평균 / 후기 수-->
                  <div v-show="this.$store.state.productRatingAvg !== 0"
                       style="font-size: 0.8em; margin-top: 2px; margin-left: 2px">
                    {{this.$store.state.productRatingAvg}}
                    </div>
                  <div style="font-size: 0.9em; font-weight: bold">
                    &nbsp; ({{ this.$store.state.productReviewCnt }})
                  </div>
                </v-row>
              </v-col>

              <!--배송비-->
              <v-col>
                <v-row>
                  <p class="title">DELIVERYFEE</p>
                  <col class="col-sm-1 mr-7">
                  <p class="subTitle">{{ deliveryFee | comma }}원</p>
                  <p class="subTitle" style="font-size: 0.6em">&nbsp;(5만원 이상 무료배송)</p>
                </v-row>
              </v-col>

              <!--개수-->
              <v-col>
                <v-row>
                  <p class="title">ITEMS</p>
                  <!--재고상태표시-->
                  <div class="stockInfo">
                    <span class="green" style="padding: 5px" v-if="product.productInfo.stock > 10"> For Sale </span>
                    <span class="amber" style="padding: 5px" v-else-if="product.productInfo.stock <= 10 && product.productInfo.stock > 0"> Only Few Left </span>
                    <span class="grey" style="padding: 5px" v-else>SOLD OUT</span>
                  </div>
                  <col class="col-sm-2">
                  <!--선택한상품개수-->
                  <v-text-field
                      class="puple-input"
                      type="number"
                      outlined color="grey darken-5"
                      dense
                      v-model="quantity"
                      :rules="[rules.min, rules.max]"
                  ></v-text-field>
                </v-row>
              </v-col>

              <!--총 가격-->
              <v-col>
                <v-row>
                  <p class="title">TOTAL PRICE</p>
                  <col class="col-sm-2">
                  <p class="subTitle">{{ totalPrice | comma }}원</p>
                </v-row>
              </v-col>

            </div>

            <!--장바구니 / 바로구매 버튼-->
            <v-row>
              <v-col cols="6" align="center">
                <v-btn
                    @click="registerShoppingBucketProduct(quantity)"
                    :disabled="product.productInfo.stock <= 0"
                    block x-large
                    class="bt1"
                    color="#DAA520"
                    style="color: white" tile
                >장바구니</v-btn>

              </v-col>
              <v-col cols="6" align="center">
                <v-btn
                    :disabled="product.productInfo.stock <= 0"
                    block x-large
                    class="bt1"
                    color="#2F4F4F"
                    style="color: white" tile
                    :to="{name: 'OrderForm', params: {product: this.product, productTotalPrice: this.totalPrice, productDeliveryFee: this.deliveryFee, productQuantity: this.quantity , productReadCheckValue:true}}"
                >바로구매</v-btn>
              </v-col>
            </v-row>

          </div>
        </div>

      </div>

        <!--상품 관련 TAP-->
        <!--상품 상세설명 / 정보 제공 / 구매후기 / 문의-->
        <div class="detail">
          <v-tabs
              v-model="tab"
              color="#2F4F4F"
              grow>

            <v-tab v-for="item in items" :key="item.tab">
              {{ item.tab }}
            </v-tab>
          </v-tabs>

          <v-tabs-items v-model="tab">

            <v-tab-item>

              <v-card flat>
                <v-card-title style="font-size: 20px; font-weight: bold; color: #2F4F4F">
                  <v-icon size="30" color="#2F4F4F" >mdi-bullhorn-variant-outline</v-icon>&nbsp;
                  상품 상세 설명
                </v-card-title>
                <v-card-text class="mt-5">
                  <v-textarea
                      solo
                      flat
                      auto-grow
                      no-resize
                      readonly
                      color="white"
                      :value="product.productInfo.content"
                  ></v-textarea>
                </v-card-text>
              </v-card>

            </v-tab-item>


            <v-tab-item>

              <v-card flat height="800px">
                <v-card-title style="font-size: 20px; font-weight: bold; color: #2F4F4F">
                  <v-icon size="30" color="#2F4F4F" >mdi-bullhorn-variant-outline</v-icon>&nbsp;
                  상품 정보 제공 고시
                </v-card-title>
                <v-card-text
                    class="mt-5"
                    style="font-weight: bold">
                  {{ product.productInfo.infoNotice }}
                </v-card-text>
              </v-card>

            </v-tab-item>

            <v-tab-item>
              <v-card flat height="auto">
                <v-card-title style="font-size: 20px; font-weight: bold; color: #2F4F4F">
                  <v-icon size="30" color="#2F4F4F" >mdi-bullhorn-variant-outline</v-icon>&nbsp;
                  상품 후기
                </v-card-title>
                <v-card-text>상품에 대한 후기를 보는 공간입니다. <br/>
                  구매한 상품의 <strong>후기는 마이페이지의 최근 주문내역에서 작성</strong> 가능합니다. <br/>
                  후기 작성은 배송완료 시점부터 가능합니다. <br/>
                  <strong>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</strong>
                </v-card-text>
                <hr color="#DAA520" width="100%">

                <!--리뷰 리스트-->
                <review-view :productNo="productNo"/>

              </v-card>
            </v-tab-item>

            <v-tab-item>
              <v-card flat height="auto">
                <v-card-title style="font-size: 20px; font-weight: bold; color: #2F4F4F">
                  <v-icon size="30" color="#2F4F4F" >mdi-bullhorn-variant-outline</v-icon>&nbsp;
                  상품 문의
                  <v-spacer></v-spacer>

                  <!--로그인하지 않은 사용자 로그인 알림창-->
                  <v-dialog
                      v-if="$store.state.signInCheckValue==false"
                      v-model="loginDialog"
                      max-width="400"
                      max-height="50"
                  >
                    <template v-slot:activator="{on, attrs}">
                      <v-btn
                          v-if="$store.state.signInCheckValue==false"
                          @click="loginAlert()"
                          large
                          dense
                          outlined
                          v-bind="attrs"
                          v-on="on"
                          width="140px"
                          elevation="0"
                          style="color: #2F4F4F; margin-top: 10px; margin-right: 10px;"
                      >
                        문의하기
                      </v-btn>
                    </template>
                    <v-card align="center">
                      <v-card-title class="justify-center" style="font-size: 16px;">
                        ⚠️ 로그인이 필요합니다. <br/>
                        로그인 페이지로 이동하시겠습니까?
                      </v-card-title><br>
                      <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn outlined  color="#DAA520" width="80px" style="margin-bottom: 10px" @click="loginDialog = false">
                          취소
                        </v-btn>
                        <v-btn
                            outlined
                            color="#2F4F4F"
                            style="margin-bottom: 10px"
                            width="80px"
                            @click="$router.push('/sign-in')"
                        >
                          이동
                        </v-btn>
                        <v-spacer></v-spacer>
                      </v-card-actions>
                    </v-card>
                  </v-dialog>

                  <!--문의하기 버튼 / 문의 등록 dialog-->
                  <v-dialog
                      v-if="$store.state.signInCheckValue==true"
                      v-model="dialogQna"
                      @click:outside="fn_cancel2"
                      persistent
                      max-width="568px"
                      :retain-focus="false"
                  >
                    <template v-slot:activator="{on, attrs}">
                      <v-btn
                          large
                          dense
                          outlined
                          v-bind="attrs"
                          v-on="on"
                          width="140px"
                          elevation="0"
                          style="color: #2F4F4F; margin-top: 10px; margin-right: 10px;"
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
                              :src="require('@/assets/productImg/' + product.productImages[0].editedName)">
                          </v-img>
                        </v-card>

                        <v-card width="400px"
                                flat
                                tile
                        >
                          <v-card-title style="font-weight: bold; font-size: 15px">
                             {{product.title}}
                          </v-card-title>

                          <v-card-subtitle style="font-size: 12px">
                            {{ product.nickname }}
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

                </v-card-title>

                <v-card-text>상품에 대한 문의를 남기는 공간입니다. <br/>
                  구매한 상품의 <strong>취소/환불은 구매내역의 주문상세보기에서 신청</strong> 가능합니다. <br/>
                  상품문의 및 후기게시판을 통해 취소나 환불은 처리되지 않습니다. <br/>
                  <strong>"해당 상품 자체"와 관계없는 글, 양도, 광고성, 욕설, 비방, 도배 등의 글은 예고 없이 이동, 노출제한, 삭제 등의 조치가 취해질 수 있습니다.</strong>
                </v-card-text>

                <!--상품 문의 리스트-->
                <qna-form :productNo="productNo"/>
              </v-card>
            </v-tab-item>

          </v-tabs-items>
        </div>

      </table>
      </div>
    </form>
  </v-container>
</template>

<script>


import {mapActions, mapState} from "vuex";
import QnaForm from "@/components/product/qna/QnaForm";
import ReviewView from "@/views/product/review/ReviewView";

export default {
  name: "ProductReadForm",
  components: {ReviewView, QnaForm},
  props: {
    productNo: {
      type: String,
      required: true,
    },
    product: {
      type: Object,
      required: true,
    }
  },
  computed: {
    ...mapState ([
      'productReviewList',
      'productRatingAvg'
    ])
  },
  data() {
    return {
      imgIdx: 0,
      tab2 : null,
      tab : null,
      items: [
        {tab: '상품 상세 설명', content: ''},
        {tab: '상품 정보 제공 고시', content: ''},
        {tab: '구매 후기', content: ''},
        {tab: '상품 문의', content: ''},
      ],
      deliveryFee: '',
      reviewSumAvg: 4,
      totalPrice: 0,
      quantity: 1,
      rules: {
        required: value => !!value || "필수 입력 사항입니다",
        min: v => v > 0 || `상품 구매 최소수량은 1개 입니다.`,
        max: v => v <= this.product.productInfo.stock || `상품재고가 ${this.product.productInfo.stock}개 남았습니다`
      },

      loginDialog : false,
      qnaProductTitle: '',
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
        'requestDeleteProductToSpring',
        'requestRegisterShoppingBucketProduct',
        'requestRegisterQnaFromSpring',
        'requestProductReviewListFromSpring',
        'requestReviewCntFromSpring',
        'requestReviewImageFromSpring',
    ]),
    selectedImg(e) {
      this.imgIdx = e
      console.log(this.imgIdx)
    },
    async registerShoppingBucketProduct(quantity) {
      const productId = this.productNo
      const nickname = this.$store.state.memberInfoAfterSignIn.nickname
      const productAmountValue = quantity

      await this.requestRegisterShoppingBucketProduct({nickname, productId, productAmountValue})
      // 장바구니에 상품 추가
    },
    onModify () {
      this.$router.push({name:'ProductModifyView',
      params: { productNo: this.product.productNo.toString() }})
      console.log(this.product.productNo.toString())
    },
    onDelete () {
      this.requestDeleteProductToSpring(this.productNo)
    },
    onSubmit () {

    },
    freeDelivery () {
      this.initialDeliveryFee = this.product.productInfo.deliveryFee
      this.freeDeliveryFee = 0
      this.deliveryFee = this.product.productInfo.deliveryFee

      this.price = this.product.price

      if(this.quantity <= 0) {
        this.totalPrice = 0
      } else {
        this.totalPrice = this.price * this.quantity + this.deliveryFee
      }

      if(this.totalPrice >= 50000) {
        // eslint-disable-next-line vue/no-mutating-props
        this.deliveryFee = this.freeDeliveryFee

        if (this.totalPrice < 5000) {
          // eslint-disable-next-line vue/no-mutating-props
          this.deliveryFee = this.initialDeliveryFee
        }
      }
    },
    fn_cancel2() {
      this.dialogQna = false
    },
    async registerQna() {

      const productNo = this.product.productNo
      const writer = this.$store.state.memberInfoAfterSignIn.nickname
      const questionCategory = this.qnaCategory
      const questionTitle = this.qnaTitle
      const questionContent = this.qnaContent
      const openStatus =  this.checkStatus == true ? false : true

      await this.requestRegisterQnaFromSpring({productNo, writer, questionCategory, questionTitle, questionContent, openStatus})
      this.dialogQna = false
      history.go(0)
    },
  },
  beforeUpdate() {
    this.freeDelivery()
  },

  async mounted() {
    //리뷰 총 개수
    const productNo = this.productNo
    await this.requestReviewCntFromSpring(productNo)
    console.log("productReviewCnt: " + this.$store.state.productReviewCnt)


    //리뷰리스트 불러오기
    console.log("productNo: "+ this.productNo)
    this.productReviewList.splice(0)
    /*const productNo = this.productNo*/
    const reviewSize = Number(this.$store.state.productReviewCnt)

    await this.requestProductReviewListFromSpring({productNo, reviewSize})
  },

  async created() {
    this.reviewImage.splice(0)
    for (let i = 0; i < this.productReviewList.length; i++) {
      const reviewNo = this.productReviewList[i].reviewNo

      await this.requestReviewImageFromSpring(reviewNo)
    }
  },

}
</script>

<style scoped>
table {
  margin-top: 10px;
  width: 100%;
}
#content{
  display: block;
  margin-top: 72px;
  margin: 30px;
  border: 0px;
  width: 1200px;
  margin: 0 auto;
  padding: 40px;
  line-height: 24px;
  background: #fff;
  margin-bottom: 50px;
}
td {
  border: 1px solid lightgray;
  width: 100px;
  height: 100px;
  text-align: center;
}
span {
  position: relative;
  left: 22%;
  bottom: 22px;
  font-size: 12px;
}
.img {
  width: 100%;
}
.bt1 {
  left: 20px;
}
.subTitle{
  float: left;
}
.stockInfo{
  margin-top: 26px;
}
.col-sm-3{
  left:20px;
}
.detail {
  border: 1px solid #e9ecef;
}
.v-tab {
  padding: 0;
  position:relative;
}
.itemTable {
  width: 50%;
  height: 100%;
  background-color: #f6f6f6;
  padding: 10px;
}
.ectBtn {
  left: 1000px;
}
a {
  text-decoration: none;
}
.puple-input >>> .error--text {
  color: #2F4F4F !important;
}
</style>