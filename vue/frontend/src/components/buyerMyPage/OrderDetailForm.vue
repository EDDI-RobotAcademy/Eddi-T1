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

        <v-container style="width: 800px; margin-top: 30px">

            <div>
              <v-card flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 10px;">
                <v-card-subtitle style="border-bottom: 1px solid #eaebee">
                  <v-layout>
                    {{ date }}
                    <v-spacer></v-spacer>

                    <!--최근 주문상품 상세페이지로 이동-->
                    <h5 style="text-decoration: none; color: black">{{ totalPrice }}</h5>
                  </v-layout>
                </v-card-subtitle>


                <!--주문일자(주문번호)에 따른 상품 개수-->
                <v-layout
                    v-for="(itemList, index) in orderList" :key="index"
                    style="border-bottom: 0.5px solid #eaebee"
                >

                  <v-card max-width="100"
                          style="padding: 15px 15px 15px 15px"
                          flat
                  >
                    <v-img
                        height="75px"
                        :src="require('@/assets/productImg/' + itemList.img)">
                    </v-img>
                  </v-card>

                  <v-card width="400px"
                          flat
                          style="border-right: 1px solid #eaebee"
                          tile
                  >
                    <v-card-title style="font-weight: bold; font-size: 15px">
                      <router-link to="null" style="text-decoration: none; color: black">
                        {{ itemList.productTitle }}&nbsp;
                      </router-link>

                      <!--주문상태 chip-->

                      <v-chip outlined style="float: right;" color="#DAA520" x-small v-if="itemList.orderStatus == '입금 완료'">입금 완료</v-chip>
                      <v-chip outlined style="float: right;" color="#44a4fc" x-small v-if="itemList.orderStatus == '배송 중'">배송 중</v-chip>
                      <v-chip outlined style="float: right;" color="green" x-small v-if="itemList.orderStatus == '배송 완료'">배송 완료</v-chip>
                      <v-chip outlined style="float: right;" color="warning" x-small v-if="itemList.orderStatus == '교환'">교환</v-chip>
                      <v-chip outlined style="float: right;" color="grey" x-small v-if="itemList.orderStatus == '취소'">취소</v-chip>
                      <v-chip outlined style="float: right;" color="red" x-small v-if="itemList.orderStatus == '환불'">환불</v-chip>


                    </v-card-title>

                    <v-card-subtitle style="font-size: 12px">
                      {{ itemList.optionsList }} : {{ itemList.quantity }}개
                    </v-card-subtitle>
                  </v-card>

                  <v-card flat
                          style="border-right: 1px solid #eaebee"
                          tile
                          width="200px"
                  >
                    <v-layout justify-center style="padding: 1px">
                      <v-card-title style="font-size: 15px">
                        <h5>{{ itemList.seller }}</h5>
                      </v-card-title>
                    </v-layout>

                    <v-card-subtitle align="center">
                      <v-btn
                          small
                          elevation="0"
                          style="background-color: #2F4F4F; color: white; margin-top: -35px;"
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
                             style="background-color: #2F4F4F;
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
              </v-card>
            </div>
        </v-container>
      </v-container>



      <!--배송정보-->
      <v-container style="width: 1200px; margin-top: 20px">
        <v-layout>
          <h3>배송정보</h3>
          <v-spacer></v-spacer>
        </v-layout>

          <v-container style="width: 800px; margin-top: 30px">
            <div>
              <v-card  flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 10px; border-right: 0px; border-left: 0px;">
                <!--받는분-->
                <v-layout >
                  <v-card width="120px" flat color="#f5f5f5" style="border-bottom: 1px solid #eaebee" tile>
                    <v-card-title style="font-size: 14px">
                      받는분
                    </v-card-title>
                  </v-card>

                  <v-card width="680px" flat style="border-bottom: 1px solid #eaebee" tile>
                    <v-card-title style="font-size: 15px">
                      {{ recipient }}
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

                  <v-card width="680px" flat style="border-bottom: 1px solid #eaebee" tile>
                    <v-card-title style="font-weight: normal; font-size: 15px">
                      {{ phone }}
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

                  <v-card width="680px" flat color="white">
                    <v-card-title style="font-weight: normal; font-size: 15px">
                      {{ address }}
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


      <v-container style="width: 800px; margin-top: 30px; margin-bottom: 50px">
      <v-card style="height: auto; border: 1px solid black" flat>
          <v-layout style="height: 100%; width: 100%" justify-center>


            <v-card width="400px" flat style="border-right: 1px solid black" tile>

              <v-card width="330px" flat tile style="margin-bottom: 20px" v-for="(itemList, index) in orderList" :key="index">

                <div align="center" style="width: 350px">
                <v-card width="330px" height="50px" flat title>
                  <v-card-title style="font-weight: bold; font-size: 14px; color: #2F4F4F">
                    🎁{{ itemList.seller }} 작가님
                  </v-card-title>
                </v-card>
                </div>

                <div align="center" style="width: 380px">
                  <v-card width="330px" height="auto" flat color="#f5f5f5" style="border: 1px solid #eaebee" tile >
                    <v-card-title style="font-weight: normal; font-size: 13px; text-align: left">
                      {{ itemList.productTitle }} <br/>
                      배송비
                      <v-spacer></v-spacer>
                      {{ itemList.price }}
                      <br/>
                      {{ itemList.deliveryFee }}
                    </v-card-title>
                  </v-card>
                </div>

              </v-card>

            </v-card>


            <v-card width="400px" height="auto" flat color="#f5f5f5" style="border-bottom: 1px solid #eaebee" tile>

              <div align="center" style="width: 380px; padding-top: 20px">
              <v-card width="350px" flat color="#f5f5f5">
                <v-card-title style="font-weight: lighter; font-size: 15px">
                  작품금액
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
  </div>
</template>

<script>
import BuyerNav from "@/components/buyerMyPage/BuyerNav";
export default {
  name: "OrderDetailForm",
  components: {BuyerNav},
  data() {
    return {
      totalProductPrice: "28,000",
      totalDelivery: "20,000",
      date: "2022-12-30",
      totalPrice: "300,000",
      recipient: '김땡땡',
      phone: '010-1234-5678',
      address: '경기도 부천시 똑딱로 135번길 389동 307호',

      orderList: [
        {
          date: "2022-12-11",
          price: "35,000원",
          img: '상품이미지1.jpg',
          productTitle: '핸드메이드 상품',
          optionsList: '수제 케익',
          quantity: 1,
          seller: "핸드메이드 판매자",
          orderStatus: '입금 완료',
          deliveryFee: 3000,
        },
        {
          date: "2022-12-11",
          price: "35,000원",
          img: '상품이미지2.jpg',
          productTitle: '곰돌이 캔들',
          optionsList: '곰돌이 캔들',
          quantity: 1,
          seller: "sosoShop",
          orderStatus: '배송 중',
          deliveryFee: 3000,
        },
        {
          date: "2022-12-11",
          price: "19,300원",
          img: '상품이미지3.jpg',
          productTitle: '캔들 판매',
          optionsList: '눈사람 캔들',
          quantity: 3,
          seller: "Kun",
          orderStatus: '배송 완료',
          deliveryFee: 3000,
        },
        {
          date: "2022-12-11",
          price: "19,300원",
          img: '상품이미지5.jpg',
          productTitle: '크리스마스 장식',
          optionsList: '트리 장식',
          quantity: 4,
          seller: "cherryflavor",
          orderStatus: '취소',
          deliveryFee: 4000,
        },
        {
          date: "2022-12-11",
          price: "19,300원",
          img: '상품이미지4.jpg',
          productTitle: '맛있는 디저트',
          optionsList: '컵케이크',
          quantity: 2,
          seller: "똑딱이",
          orderStatus: '교환',
          deliveryFee: 0,
        },
        {
          date: "2022-12-11",
          price: "19,300원",
          img: '상품이미지1.jpg',
          productTitle: '캔들 판매',
          optionsList: '눈사람 캔들',
          quantity: 1,
          seller: "rarararara",
          orderStatus: '환불',
          deliveryFee: 2000,
        },
      ],
    }
  }
}
</script>

<style scoped>
.card-p {
  padding-bottom: 39px;
  position: absolute;
  bottom: 0;
}
</style>