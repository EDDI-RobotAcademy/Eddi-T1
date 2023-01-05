<template>
  <div>
    <buyer-nav/>

    <v-container style="width: 1400px">
      <h2>마이페이지</h2>
      <v-divider style="margin-top: 40px"></v-divider>

      <v-container style="width: 880px; margin-top: 80px">
        <v-card style="height: 150px"
                tile
                fla
        >
          <v-row class="justify-center">
            <v-card class="cardStyle"
                    v-for="(item, index) in myPageCategoryItems"
                    :key="index"
                    tile
                    flat
            >
              <v-card-title class="justify-center">
                <h5>{{ item.title }}</h5>
              </v-card-title>

              <v-card-title class="justify-sm-end" style="margin-right: 10px">
                <router-link to="null" style="text-decoration: none; color: white">
                  <h5 style="font-size: 33px; color: #FAEBD7">{{ item.count }}</h5>
                </router-link>

                <span style="margin-top: 7px">
                  개
                </span>
              </v-card-title>
            </v-card>
          </v-row>
        </v-card>
      </v-container>

      <!--최근 주문내역-->
      <v-container style="width: 1200px; margin-top: 80px">
        <v-layout>
          <h3>최근 주문내역</h3>
          <v-spacer></v-spacer>
          <router-link to="null" style="text-decoration: none; color: black">
            <h4 style="font-size: 13px">더보기></h4>
          </router-link>
        </v-layout>

        <v-container style="width: 800px; margin-top: 30px;">
          <v-tabs grow height="55px">
            <v-tabs-slider style="color: #DAA520"></v-tabs-slider>
            <v-layout justify-center v-for="(item, index) in orderListCategoryItems" :key="index">
              <v-tab style="color: #2F4F4F; border: 1px solid grey">
                <h4>{{ item.name }}</h4>
              </v-tab>
            </v-layout>

            <v-tab-item v-for="(item, index) in orderListCategoryItems" :key="index" style="margin-top: 50px;">
              <div v-for="(itemList, index) in item.contentList" :key="index">
                <v-card flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 10px;">
                  <v-card-subtitle style="border-bottom: 1px solid #eaebee">
                    <v-layout>
                      {{ itemList.date }}
                      <v-spacer></v-spacer>

                      <!--최근 주문상품 상세페이지로 이동-->
                      <router-link to="/order-detail" style="text-decoration: none; color: black">
                        <h5>{{ itemList.price }} ></h5>
                      </router-link>
                    </v-layout>
                  </v-card-subtitle>

                  <!--주문일자(주문번호)에 따른 상품 개수-->
                  <v-layout
                      v-for="(itemList, index) in item.contentList" :key="index"
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
                               :disabled="itemList.orderStatus == '입금 완료' || itemList.orderStatus == '배송 중' || itemList.orderStatus == '취소'"
                               width="98px"
                               elevation="0"
                               style="background-color: #2F4F4F;
                               color: white">
                          <h3 style="font-weight: normal">구매후기 작성</h3>
                        </v-btn>


                        <v-btn x-small
                               :disabled="itemList.orderStatus == '입금 완료'|| itemList.orderStatus == '취소'"
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

                </v-card>
              </div>
            </v-tab-item>
          </v-tabs>
        </v-container>
      </v-container>

<!--      <v-container style="width: 1200px; margin-top: 80px">
        <v-layout>
          <h3>최근 주문내역</h3>
          <v-spacer></v-spacer>
          <router-link to="null" style="text-decoration: none; color: black">
            <h4 style="font-size: 13px">더보기></h4>
          </router-link>
        </v-layout>

        <v-container style="width: 800px; margin-top: 30px;">
          <v-tabs grow height="55px">
            <v-tabs-slider style="color: #DAA520"></v-tabs-slider>
            <v-layout justify-center v-for="(item, index) in orderListCategoryItems" :key="index">
              <v-tab style="color: #2F4F4F; border: 1px solid black">
                <h4>{{ item.name }}</h4>
              </v-tab>
            </v-layout>

            <v-tab-item v-for="(item, index) in orderListCategoryItems" :key="index" style="margin-top: 50px;">
              <div v-for="(itemList, index) in item.contentList" :key="index">
                <v-card style="border: 1px solid black; margin-top: 10px;">
                  <v-card-subtitle style="border-bottom: 1px solid black">
                    <v-layout>
                      {{ itemList.date }}
                      <v-spacer></v-spacer>

                      &lt;!&ndash;최근 주문상품 상세페이지로 이동&ndash;&gt;
                      <router-link to="null" style="text-decoration: none; color: black">
                        <h5>{{ itemList.price }} ></h5>
                      </router-link>
                    </v-layout>
                  </v-card-subtitle>

                  <v-layout>
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
                            style="border-right: 1px solid black"
                            tile
                    >
                      <v-card-title style="font-weight: bold; font-size: 15px">
                        <router-link to="null" style="text-decoration: none; color: black">
                          {{ itemList.productTitle }}
                        </router-link>
                      </v-card-title>

                      <v-card-subtitle style="font-size: 12px">
                        {{ itemList.optionsList }} : {{ itemList.quantity }}개
                      </v-card-subtitle>
                    </v-card>

                    <v-card flat
                            style="border-right: 1px solid black"
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
                               elevation="0"
                               style="background-color: #2F4F4F;
                               color: white">
                          <h3 style="font-weight: normal">구매후기 작성</h3>
                        </v-btn>
                        <v-btn x-small
                               width="98px"
                               elevation="0"
                               style="background-color: #2F4F4F;
                               color: white"
                        >
                          <h3 style="font-weight: normal">배송 조회</h3>
                        </v-btn>
                      </div>
                    </v-card>

                  </v-layout>
                </v-card>
              </div>
            </v-tab-item>
          </v-tabs>
        </v-container>
      </v-container>-->

      <!--취소 및 반품 내역-->
      <v-container style="width: 1200px; margin-top: 80px">
        <v-layout>
          <h3>취소/반품 내역</h3>
          <v-spacer></v-spacer>
          <router-link to="null" style="text-decoration: none; color: black">
            <h4 style="font-size: 13px">더보기></h4>
          </router-link>
        </v-layout>

        <v-container style="width: 800px; margin-top: 30px">
          <div>
            <v-card style="border: 1px solid black; margin-top: 10px;">
              <v-card-subtitle style="border-bottom: 1px solid black">
                <v-layout>
                    취소 접수일: <h4>2022-12-20</h4> &nbsp;| 주문일: <h4>2022-12-20</h4> &nbsp;| 주문번호: <h4>202212200000001</h4>
                  <v-spacer></v-spacer>

                  <router-link to="null" style="text-decoration: none; color: black">
                    <!--                  <h5>{{ itemList.price }} ></h5>-->
                    <h5>35,000원</h5>
                  </router-link>
                </v-layout>
              </v-card-subtitle>

              <v-layout>
                <v-card max-width="100"
                        style="padding: 15px 15px 15px 15px"
                        flat
                >
                  <v-img
                      height="75px"
                      src="@/assets/productImg/상품이미지1.jpg"
                  >
                  </v-img>
                </v-card>

                <v-card width="400px"
                        flat
                        style="border-right: 1px solid black"
                        tile
                >
                  <v-card-title style="font-weight: bold; font-size: 15px">
                    <router-link to="null" style="text-decoration: none; color: black">
                      <!--                    {{ itemList.productTitle }}-->
                      핸드메이드 상품
                    </router-link>
                  </v-card-title>

                  <v-card-subtitle style="font-size: 12px">
                    <!--                  {{ itemList.optionsList }} : {{ itemList.quantity }}개-->
                    수제 케익 : 1개
                  </v-card-subtitle>
                </v-card>

                <v-card flat
                        style="border-right: 1px solid black"
                        tile
                        width="200px"
                >
                  <v-layout justify-center style="padding: 1px">
                    <v-card-title style="font-size: 15px">
                      <!--                    <h5>{{ itemList.seller }}</h5>-->
                      <h5> 핸드메이드 판매자 </h5>
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
                  <div style="margin: 50px 0px 0px 5px">
                    <h4>취소완료</h4>
                  </div>
                </v-card>
              </v-layout>
            </v-card>
          </div>
        </v-container>
      </v-container>

      <v-container style="width: 1200px; margin-top: 80px">
        <v-layout>
          <h3>최근 본 상품</h3>
          <v-spacer></v-spacer>
          <router-link to="null" style="text-decoration: none; color: black">
            <h4 style="font-size: 13px">더보기></h4>
          </router-link>
        </v-layout>
      </v-container>

      <v-container style="width: 1000px; margin-top: 80px">
        <v-layout>
          <v-row class="justify-start">
            <v-card
                    class="ma-4"
                    max-width="210"
                    style="margin-right: 20px"
            >
              <v-img
                  class="white--text align-end"
                  height="200px"
                  src="@/assets/productImg/상품이미지1.jpg"
              >
              </v-img>
              <v-card-subtitle class="pb-0">
<!--                {{ item.sellerNickname }}-->
                핸드메이드 판매자
              </v-card-subtitle>
              <v-card-title>
<!--                <h4>{{ item.commodityTitle }}</h4>-->
                <h4>핸드메이드 상품</h4>
              </v-card-title>
              <v-divider></v-divider>

              <v-card-text class="text--primary">
<!--                {{ item.contents }}-->
                핸드메이드 상품 설명
              </v-card-text>

            </v-card>
            <v-card
                class="ma-4"
                max-width="210"
            >
              <v-img
                  class="white--text align-end"
                  height="200px"
                  src="@/assets/productImg/상품이미지1.jpg"
              >
              </v-img>
              <v-card-subtitle class="pb-0">
                <!--                {{ item.sellerNickname }}-->
                핸드메이드 판매자
              </v-card-subtitle>
              <v-card-title>
                <!--                <h4>{{ item.commodityTitle }}</h4>-->
                <h4>핸드메이드 상품</h4>
              </v-card-title>
              <v-divider></v-divider>

              <v-card-text class="text--primary">
                <!--                {{ item.contents }}-->
                핸드메이드 상품 설명
              </v-card-text>

            </v-card><v-card
              class="ma-4"
              max-width="210"
          >
            <v-img
                class="white--text align-end"
                height="200px"
                src="@/assets/productImg/상품이미지1.jpg"
            >
            </v-img>
            <v-card-subtitle class="pb-0">
              <!--                {{ item.sellerNickname }}-->
              핸드메이드 판매자
            </v-card-subtitle>
            <v-card-title>
              <!--                <h4>{{ item.commodityTitle }}</h4>-->
              <h4>핸드메이드 상품</h4>
            </v-card-title>
            <v-divider></v-divider>

            <v-card-text class="text--primary">
              <!--                {{ item.contents }}-->
              핸드메이드 상품 설명
            </v-card-text>

          </v-card>
            <v-card
                class="ma-4"
                max-width="210"
            >
              <v-img
                  class="white--text align-end"
                  height="200px"
                  src="@/assets/productImg/상품이미지1.jpg"
              >
              </v-img>
              <v-card-subtitle class="pb-0">
                <!--                {{ item.sellerNickname }}-->
                핸드메이드 판매자
              </v-card-subtitle>
              <v-card-title>
                <!--                <h4>{{ item.commodityTitle }}</h4>-->
                <h4>핸드메이드 상품</h4>
              </v-card-title>
              <v-divider></v-divider>

              <v-card-text class="text--primary">
                <!--                {{ item.contents }}-->
                핸드메이드 상품 설명
              </v-card-text>

            </v-card>
          </v-row>
        </v-layout>
      </v-container>
    </v-container>
  </div>
</template>

<script>
import BuyerNav from "@/components/buyerMyPage/BuyerNav";

export default {
  name: "BuyerMyPageForm",
  components: {BuyerNav},
  data() {
    return {
      orderListCount: 0,
      orderListBtnName:[
        {name: '구매후기 작성'},
        {name: '배송 조회'},
      ],
      myPageCategoryItems: [
        {title: "최근 주문내역", count: 0},
        {title: "취소/반품 내역", count: 0},
        {title: "최근 본 상품", count: 3},
        {title: "내가 작성한 리뷰", count: 4},
      ],
      orderListCategoryItems: [
        {
          name: "핸드메이드", contentList: [
            {
              date: "2022-12-11",
              price: "35,000원",
              img: '상품이미지1.jpg',
              productTitle: '핸드메이드 상품',
              optionsList: '수제 케익',
              quantity: 1,
              seller: "핸드메이드 판매자",
              orderStatus: '입금 완료'
            },
            {
              date: "2022-12-09",
              price: "19,300원",
              img: '상품이미지3.jpg',
              productTitle: '캔들 판매',
              optionsList: '눈사람 캔들',
              quantity: 1,
              seller: "캔들판매",
              orderStatus: '배송 완료'
            }
          ]
        },
        {
          name: "노하우", contentList: [
            {
              date: "2022-12-13",
              price: "12,900원",
              img: '노하우이미지1.jpg',
              productTitle: '노하우 상품',
              optionsList: '노하우 상품 구성',
              quantity: 2,
              seller: "노하우 판매자"
            }
          ]
        },
        {
          name: "취미/특기", contentList: [
            {
              date: "2022-12-15",
              price: "50,000원",
              img: '취미이미지1.jpg',
              productTitle: '취미/특기 상품',
              optionsList: '취미/특기 상품 구성',
              quantity: 1,
              seller: "취미/특기 판매자"
            }
          ]
        },
      ]
    }
  },
  async mounted(){
    const handmadeListLength = this.orderListCategoryItems[0].contentList.length;
    const knowHowListLength = this.orderListCategoryItems[1].contentList.length;
    const hobbyListLength = this.orderListCategoryItems[2].contentList.length;

    const orderListTotalCount = handmadeListLength + knowHowListLength + hobbyListLength

    this.$set(this.myPageCategoryItems[0], 'count', orderListTotalCount)
  }
}
</script>

<style scoped>
.cardStyle {
  height: 150px;
  width: 215px;
  padding: 10px 10px;
  background-color: #2F4F4F;
  color: white;
  border-right: 1px solid white;
  border-left: 1px solid white;
}
</style>