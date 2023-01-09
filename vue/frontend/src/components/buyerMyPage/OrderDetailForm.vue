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
                        <v-chip outlined style="float: right;" color="#DAA520" x-small v-if="itemList.orderStatus == '입금완료'">입금 완료</v-chip>
                        <v-chip outlined style="float: right;" color="#44a4fc" x-small v-if="itemList.orderStatus == '배송 중'">배송 중</v-chip>
                        <v-chip outlined style="float: right;" color="green" x-small v-if="itemList.orderStatus == '배송 완료'">배송 완료</v-chip>
                        <v-chip outlined style="float: right;" color="warning" x-small v-if="itemList.orderStatus == '교환'">교환</v-chip>
                        <v-chip outlined style="float: right;" color="grey" x-small v-if="itemList.orderStatus == '취소'">취소</v-chip>
                        <v-chip outlined style="float: right;" color="red" x-small v-if="itemList.orderStatus == '환불'">환불</v-chip>
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
                        <v-btn
                            small
                            elevation="0"
                            style="background-color: #2F4F4F; color: white; margin-top: -35px;"
                            @click="inquiry()"
                        >
                          문의하기
                        </v-btn>
                      </v-card-subtitle>
                    </v-card>

                    <v-card flat align="center">
                      <div style="margin-top: 35px;">

                        <v-btn x-small
                               :disabled="itemList.orderStatus == '배송 중' || itemList.orderStatus == '배송 중' || itemList.orderStatus == '배송 완료' || itemList.orderStatus == '취소' || itemList.orderStatus == '환불'"
                               width="98px"
                               elevation="0"
                               style="background-color: #DAA520;
                               margin-top: -15px;
                               color: white">
                          <h3 style="font-weight: normal">취소하기</h3>
                        </v-btn>


                        <v-btn x-small
                               :disabled="itemList.orderStatus == '입금 완료'|| itemList.orderStatus == '취소' || itemList.orderStatus == '환불'"
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
                      {{ itemList.product.title | truncate(26) }} <br/>
                      배송비
                      <v-spacer></v-spacer>
                      {{ itemList.product.price * itemList.quantity | comma }}
                      <br/>
                      {{ itemList.product.productInfo.deliveryFee | comma }}
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
                  <v-spacer></v-spacer> {{totalProductPrice}}원
                </v-card-title>
                <v-card-title style="font-weight: lighter; font-size: 15px">
                  총 배송비
                  <v-spacer></v-spacer> {{totalDelivery}}원
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
                  {{ totalPrice }}원
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
import {mapState} from "vuex";
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
      totalProductPrice: "28,000",
      totalDelivery: "20,000",
      totalPrice: 0,

      orderNoList: [],
      orderDateList: [],

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
      return reqdString + "...";
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