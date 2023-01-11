<template>
  <div>
    <buyer-nav/>

    <v-container style="width: 1400px">
      <h2>주문 상세보기</h2>
      <v-divider></v-divider>

      <!--해당 상품 주문 내역-->
      <v-container style="width: 1200px; margin-top: 80px">
        <v-layout>
          <h3>주문한 상품</h3>
          <v-spacer></v-spacer>
        </v-layout>

        <v-container style="width: 850px; margin-top: 30px">

          <!--최근 주문상품 주문번호/주문일자로 분류-->
          <div>
            <v-card flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 20px" >
              <v-card-subtitle style="border-bottom: 1px solid #eaebee">
                <v-layout>
                  {{ orderNoList[orderNo] }} | {{ orderDateList[orderNo] }}
                  <v-spacer></v-spacer>
                </v-layout>
              </v-card-subtitle>


              <!--한 주문 건에 따른 상품 개수-->
              <div v-for="(itemList, i) in myOrderInfoList" :key="i">
                <div v-if="orderNoList[orderNo] === itemList.orderNo" style="border-bottom: 1px solid #eaebee">

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

                      <v-card-title style="font-weight: bold; font-size: 15px">
                        <!--주문상태 chip-->
                        <div style="margin-right: 100%">
                        <v-chip outlined style="float: right;" color="#DAA520" x-small v-if="itemList.orderStatus == 'PAYMENT_COMPLETE'">결제 완료</v-chip>
                        <v-chip outlined style="float: right;" color="#44a4fc" x-small v-if="itemList.orderStatus == 'DELIVERING'">배송 중</v-chip>
                        <v-chip outlined style="float: right;" color="green" x-small v-if="itemList.orderStatus == 'DELIVERED'">배송 완료</v-chip>
                        <v-chip outlined style="float: right;" color="warning" x-small v-if="itemList.orderStatus == 'EXCHANGE'">교환</v-chip>
                        <v-chip outlined style="float: right;" color="grey" x-small v-if="itemList.orderStatus == 'CANCEL'">취소</v-chip>
                        <v-chip outlined style="float: right;" color="red" x-small v-if="itemList.orderStatus == 'REFUND'">환불</v-chip>
                        </div>

                        <!--상품명(상세페이지연결)-->
                        <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: itemList.product.productNo.toString() } }" style="text-decoration: none; color: black" >
                          {{ itemList.product.title }}
                        </router-link>

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
                          v-model="dialog"
                          @click:outside="fn_cancel"
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

                            <!--상품 정보-->
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

                                <!--문의 카테고리-->
                                <v-select
                                    v-model="qnaCategory" label="카테고리" color="#2F4F4F" :items="categoryList" required
                                    :rules="categoryRule"/>

                                <!--문의 제목-->
                                <v-text-field
                                    v-model="qnaTitle" label="제목" color="#2F4F4F" required
                                    :rules="titleRule"/>

                                <!--문의자-->
                                <v-text-field
                                    :value="writer" label="작성자" color="#2F4F4F" readonly required/>

                                <!--문의 본문-->
                                <v-textarea
                                    v-model="qnaContent" label="내용" counter outlined clearable
                                    row-height="60" clear-icon="mdi-close-circle" color="#2F4F4F" auto-grow required
                                    :rules="contentRule"/>

                                <!--비밀글 체크-->
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

                        <v-btn x-small
                               :disabled="itemList.orderStatus == 'DELIVERING' || itemList.orderStatus == 'DELIVERED' || itemList.orderStatus == 'CANCEL' || itemList.orderStatus == 'REFUND'"
                               width="98px"
                               elevation="0"
                               style="background-color: #DAA520;
                               margin-top: -15px;
                               color: white">
                          <h3 style="font-weight: normal">취소하기</h3>
                        </v-btn>


                        <v-btn x-small
                               :disabled="itemList.orderStatus == 'CANCEL' || itemList.orderStatus == 'REFUND'"
                               outlined class="#2F4F4F"
                               width="98px"
                               elevation="0"
                        >
                          <h3 style="font-weight: normal">환불하기</h3>
                        </v-btn>

                      </div>
                    </v-card>
                  </v-layout>
                </div>
              </div>
            </v-card>
          </div>
        </v-container>


        <!--배송정보-->
      <v-container style="width: 1200px; margin-top: 20px">
        <v-layout>
          <h3>배송정보</h3>
          <v-spacer></v-spacer>
        </v-layout>

          <v-container style="width: 850px; margin-top: 30px">
            <div>
              <v-card  flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 10px; border-right: 0px; border-left: 0px;">
                <!--받는분-->
                <v-layout >
                  <v-card width="120px" flat color="#f5f5f5" style="border-bottom: 1px solid #eaebee" tile>
                    <v-card-title style="font-size: 14px">
                      받는분
                    </v-card-title>
                  </v-card>

                  <v-card width="730px" flat style="border-bottom: 1px solid #eaebee" tile>
                    <v-card-title style="font-size: 15px">
                      {{ myOrderInfoList[orderNo].address.recipient }}
                    </v-card-title>
                  </v-card>
                </v-layout>

                <!--전화-->
                <v-layout>
                  <v-card width="120px" flat color="#f5f5f5" style="border-bottom: 1px solid #eaebee" tile>
                    <v-card-title style="font-size: 14px">
                      전화
                    </v-card-title>
                  </v-card>

                  <v-card width="730px" flat style="border-bottom: 1px solid #eaebee" tile>
                    <v-card-title style="font-weight: normal; font-size: 15px">
                      {{ myOrderInfoList[orderNo].address.phone }}
                    </v-card-title>
                  </v-card>
                </v-layout>

                <!--주소-->
                <v-layout >
                  <v-card width="120px" flat color="#f5f5f5" tile>
                    <v-card-title style="font-size: 14px">
                      주소
                    </v-card-title>
                  </v-card>

                  <v-card width="730px" flat color="white">
                    <v-card-title style="font-weight: normal; font-size: 15px">
                      {{ myOrderInfoList[orderNo].address.city }}시 {{myOrderInfoList[orderNo].address.street}} {{myOrderInfoList[orderNo].address.addressDetail}} ( {{myOrderInfoList[orderNo].address.zipcode}} )
                    </v-card-title>
                  </v-card>
                </v-layout>

              </v-card>
            </div>
          </v-container>
      </v-container>


      <!--결제정보-->
      <v-container style="width: 1200px; margin-top: 50px; margin-bottom: 10px">
        <v-layout>
          <h3>결제정보</h3>
          <v-spacer></v-spacer>
        </v-layout>
      </v-container>


      <v-container style="width: 850px; margin-top: 30px; margin-bottom: 50px">
      <v-card style="height: auto; border: 1px solid black" flat>
          <v-layout style="height: 100%; width: 100%" justify-center>


            <v-card width="450px" flat style="border-right: 1px solid black" tile>

              <v-card width="380px" flat tile style="margin-bottom: 20px" v-for="(itemList, index) in myOrderInfoList" :key="index">
                <div v-if="orderNoList[orderNo] === itemList.orderNo">

                <div align="center" style="width: 350px">
                <v-card width="330px" height="50px" flat title>
                  <v-card-title style="font-weight: bold; font-size: 14px; color: #2F4F4F;">
                    🎁{{ itemList.product.nickname }}
                  </v-card-title>
                </v-card>
                </div>

                <div align="center" style="width: 380px">
                  <v-card width="380px" height="auto" flat color="#f5f5f5" style="border: 1px solid #eaebee; margin-left: 30px" tile >
                    <v-card-title style="font-weight: normal; font-size: 13px; text-align: left;" >
                      {{ itemList.product.title | truncate(23) }} <br/>
                      <v-spacer></v-spacer>
                      {{ itemList.product.price * itemList.quantity | comma }}
                    </v-card-title>

                    <v-card-title style="font-weight: normal; font-size: 13px; text-align: left; margin-top: -32px" >
                     배송비
                      <v-spacer></v-spacer>
                      <span v-if="itemList.product.price * itemList.quantity > 50000">
                        무료배송
                      </span>
                      <span v-else>
                        {{ itemList.product.productInfo.deliveryFee | comma }}
                      </span>
                    </v-card-title>

                  </v-card>
                </div>
                </div>
              </v-card>
            </v-card>


            <v-card width="400px" height="auto" flat color="#f5f5f5" style="border-bottom: 1px solid #eaebee" tile>

              <div align="center" style="width: 380px; padding-top: 20px">
              <v-card width="350px" flat color="#f5f5f5">
                <v-card-title style="font-weight: lighter; font-size: 15px">
                  상품금액
                  <v-spacer></v-spacer> {{totalProductPrice | comma }}원
                </v-card-title>
                <v-card-title style="font-weight: lighter; font-size: 15px">
                  총 배송비
                  <v-spacer></v-spacer> {{totalDelivery | comma }}원
                </v-card-title>
              </v-card>
              </div>


              <v-card width="400px" height="auto" flat color="#f5f5f5" style="border-top: 1px solid black" tile
              class="card-p"
              >
                <v-card-title style="font-weight: bolder; font-size: 15px">
                  총 결제 금액
                </v-card-title>
                <v-card-title style="font-weight: bolder; font-size: 25px; color: #DAA520">
                  <v-spacer></v-spacer>
                  {{ totalProductPrice + totalDelivery | comma }}원
                </v-card-title>
              </v-card>

            </v-card>


          </v-layout>
      </v-card>
      </v-container>
      </v-container>

    </v-container>
  </div>
</template>

<script>
import BuyerNav from "@/components/buyerMyPage/BuyerNav";
import {mapActions, mapState} from "vuex";
export default {
  name: "OrderDetailForm",
  components: {BuyerNav},
  props: {
    orderNo: {
      type: Number,
    }
  },
  computed: {
    ...mapState([
      'myOrderInfoList'
    ])
  },
  data() {
    return {
      dialog: false,

      totalProductPrice: "",
      totalDelivery: "",

      orderNoList: [],
      orderDateList: [],

      qnaProductImg: [],
      qnaProductTitle: '',
      currentSelectedQnaProductNumber: 0,
      qnaProductNo: 0,
      qnaProductQuantity: 0,


      writer: this.$store.state.memberInfoAfterSignIn.nickname,
      qnaCategory: '',
      categoryList : ['상품 문의', '배송 문의', '환불/취소 문의', '교환 문의', '기타'],
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
  orderNo: {
    type: Number,
  },
  //숫자 콤마
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },

    truncate: function(data,num){
      const reqdString = data.split("").slice(0, num).join("");
      if (data.length < num) {
        return reqdString
      } else {
        return reqdString + "...";
      }
    }
  },
  methods: {
    ...mapActions([
        "requestRegisterQnaFromSpring"
    ]),
    fn_cancel() {
      this.dialog = false
    },
    setProductQna(i) {
      this.qnaProductTitle = this.myOrderInfoList[i].product.title
      this.qnaProductQuantity = this.myOrderInfoList[i].quantity

      this.qnaProductImg = this.myOrderInfoList[i].product.productImages[0].editedName
      this.currentSelectedQnaProductNumber = i
      this.qnaProductNo = this.myOrderInfoList[this.currentSelectedReviewProductNumber].product.productNo
    },
    async registerQna() {

      const productNo = this.myOrderInfoList[this.currentSelectedQnaProductNumber].product.productNo
      const writer = this.$store.state.memberInfoAfterSignIn.nickname
      const questionCategory = this.qnaCategory
      const questionTitle = this.qnaTitle
      const questionContent = this.qnaContent
      const openStatus =  this.checkStatus == true ? false : true

      console.log('openStatus: ' + openStatus)

      await this.requestRegisterQnaFromSpring({productNo, writer, questionCategory, questionTitle, questionContent, openStatus})
      this.dialog = false
    }
  },
  beforeUpdate() {
    this.totalProductPrice = 0
    this.totalDelivery = 0

    for (let i = 0; i < this.myOrderInfoList.length; i++) {
      if(this.orderNoList[this.orderNo] === this.myOrderInfoList[i].orderNo) {

        this.totalProductPrice += this.myOrderInfoList[i].product.price * this.myOrderInfoList[i].quantity
      }
    }

    for (let i = 0; i < this.myOrderInfoList.length; i++) {
      if(this.orderNoList[this.orderNo] === this.myOrderInfoList[i].orderNo) {
        if(this.myOrderInfoList[i].product.price * this.myOrderInfoList[i].quantity < 50000) {
          this.totalDelivery += this.myOrderInfoList[i].product.productInfo.deliveryFee
        }
      }
    }

  },
  async mounted() {
    //주문상품의 orderNo 리스트
    const orderNoList = new Array()
    for (let i = 0; i < this.myOrderInfoList.length; i++) {
      orderNoList.push(this.myOrderInfoList[i].orderNo)
    }
    this.orderNoList = [...new Set(orderNoList)]
    console.log(this.orderNoList)


    const orderDateList = new Array()
    for (let i = 0; i < this.myOrderInfoList.length; i++) {
      orderDateList.push(this.myOrderInfoList[i].orderDate)
    }
    this.orderDateList = [...new Set(orderDateList)]
    console.log(this.orderDateList)

  },
  async created() {
    //문의페이지 상품 이미지 받는 로직
    //문의 이미지 받기전 받을 변수 초기화
    this.qnaProductImg.push(this.myOrderInfoList[0].product.productImages[0].editedName)
  }
}
</script>

<style scoped>
.card-p {
  padding-bottom: 39px;
  padding-top: 20px;
  position: absolute;
  bottom: 0;
}
</style>