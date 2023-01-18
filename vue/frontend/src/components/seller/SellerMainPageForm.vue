<template>
  <v-container>
    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="81" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Seller Home
      </v-toolbar-title>
    </v-app-bar>

    <table>
      <tr>
        <!-- 상품 등록 현황-->
        <td>
          <router-link :to="{ name: 'ProductManageView', }"
                       style="text-decoration: none; color: black"
          >

            <v-hover
                v-slot="{ hover } "
            >
            <v-card
                width="380"
                height="550"
                :elevation="hover ? 16 : 0"
                :class="{'on-hover' : hover}"
                class="ma-4"
                max-width="380"
                flat
            >
              <div
              align="right"
              >
              <v-btn
              plain
              >
              <v-icon>mdi-arrow-right-thick</v-icon>
              </v-btn>
              </div>
              <div
                  style="padding-top:30px"
              >
                <div
                    align="center">
                  <v-img
                      height="250"
                      width="250"
                      src="https://cdn-icons-png.flaticon.com/512/1029/1029010.png"
                  ></v-img>
                </div>

                <v-card-title>상품 현황</v-card-title>

                <v-card-text>

                  <div class="my-4 text-subtitle-1">
                    나만의 아이디어로 탄생한 상품!<br/><br/>

                  </div>

                </v-card-text>

                <v-card-title style="font-size:18px">등록된 상품
                  <hr style="width: 180px; border: 1px solid black; margin: 0px 8px 0px 8px"/>
                  {{ totalProduct }}건
                </v-card-title>
                <br/>


              </div>
            </v-card>
            </v-hover>
          </router-link>


        </td>

        <!--구매 후기 현황-->
        <td>
          <router-link :to="{ name: 'ProductManageView', }"
                       style="text-decoration: none; color: black"
          >

            <v-hover
                v-slot="{ hover } "
            >
            <v-card
                width="380"
                height="550"
                :elevation="hover ? 16 : 0"
                :class="{'on-hover' : hover}"
                class="ma-4"
                max-width="380"
                flat
            >
              <div
                  align="right"
              >
                <v-btn
                    plain
                >
                  <v-icon>mdi-arrow-right-thick</v-icon>
                </v-btn>
              </div>

              <div
                  style="padding-top:30px"
              >

                <div
                    align="center"
                >
                  <v-img
                      height="250"
                      width="250"
                      src="https://cdn-icons-png.flaticon.com/512/4088/4088850.png"
                  ></v-img>
                </div>
                <v-card-title>구매 후기 현황</v-card-title>

                <v-card-text>


                  <div class="my-4 text-subtitle-1">
                    '마음에 쏙 들어요💕'<br/>
                    '너무 좋아요😊'
                  </div>

                </v-card-text>



                <v-card-title style="font-size:18px">구매 후기
                  <hr style="width: 210px; border: 1px solid black; margin: 0px 8px 0px 8px"/>
                  {{ totalReview }}건
                </v-card-title>
                <br/>


              </div>
            </v-card>
            </v-hover>
          </router-link>
        </td>

        <!-- 문의 현황-->
        <td>
          <router-link :to="{ name: 'InquiryManageView', }"
                       style="text-decoration: none; color: black"
          >
            <v-hover
                v-slot="{ hover } "
            >
            <v-card
                width="380"
                height="550"
                :elevation="hover ? 16 : 0"
                :class="{'on-hover' : hover}"
                class="ma-4"
                max-width="380"
                flat
            >
              <div
                  align="right"
              >
                <v-btn
                    plain
                >
                  <v-icon>mdi-arrow-right-thick</v-icon>
                </v-btn>
              </div>

              <div
                  style="padding-top:30px"
              >

                <div
                    align="center"
                >
                  <v-img
                      height="250"
                      width="250"
                      src="https://cdn-icons-png.flaticon.com/512/813/813020.png"
                  ></v-img>
                </div>
                <v-card-title>문의 현황</v-card-title>

                <v-card-text>

                  <div class="my-4 text-subtitle-1">
                    궁금한게 너무나 많아요!<br/>
                    혹시.. 판매자님은 천재이신가요?! 🤔
                  </div>


                </v-card-text>


                <v-card-title style="font-size:18px">답변 대기 문의
                  <hr style="width: 165px; border: 1px solid black; margin: 0px 8px 0px 8px"/>
                  {{ totalQnA }}건
                </v-card-title>
                <br/>


              </div>
            </v-card>
            </v-hover>
          </router-link>
        </td>

        <!--주문 현황-->
        <td>
          <router-link :to="{ name: 'OrderManageView', }"
                       style="text-decoration: none; color: black"
          >
            <v-hover
                v-slot="{ hover } "
            >
            <v-card
                width="380"
                height="550"
                :elevation="hover ? 16 : 0"
                :class="{'on-hover' : hover}"
                class="ma-4"
                max-width="380"
                flat
            >
              <div
                  align="right"
              >
                <v-btn
                    plain
                >
                  <v-icon>mdi-arrow-right-thick</v-icon>
                </v-btn>
              </div>
              <div
                  style="padding-top:30px"
              >
                <div
                    align="center">
                  <v-img
                      height="250"
                      width="250"
                      src="https://cdn-icons-png.flaticon.com/512/2728/2728447.png"
                  ></v-img>
                </div>
                <v-card-title>주문 현황</v-card-title>

                <v-card-text>


                  <div class="my-4 text-subtitle-1">
                    불티나게 팔리는 나의 아이디어!<br/>
                    확인하러 가볼까요? 😆
                  </div>


                </v-card-text>


                <v-card-title style="font-size:18px">모든 주문
                  <hr style="width: 210px; border: 1px solid black; margin: 0px 8px 0px 8px"/>
                  {{ totalOrder }}건
                </v-card-title>
                <br/>


              </div>
            </v-card>
            </v-hover>
          </router-link>
        </td>

      </tr>
    </table>
    <br/>


    <v-simple-table
        fixed-header
        height="300px"
    >
      <template v-slot:default>
        <thead>
        <tr>
          <th class="text-center"
          >
            <div
                style="font-size: 20px">
              총 매출
            </div>
          </th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <th class="text-center">
            <div
                style="font-size:20px">
              {{ totalSales | comma }}원
            </div>
          </th>
        </tr>
        </tbody>
      </template>
    </v-simple-table>

  </v-container>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";

export default {
  name: "SellerMainPageForm",
  components: {SellerNavi},
  props: {
    totalProduct: {
      type: Number
    },
    totalReview: {
      type: Number
    },
    totalQnA: {
      type: Number
    },
    totalOrder: {
      type: Number
    },
    totalSales: {
      type: Number
    },

  },

  data: () => ({
    loading: false,
    selection: 1,
  }),

  methods: {
    reserve() {
      this.loading = true

      setTimeout(() => (this.loading = false), 2000)
    },
  },

  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },

}
</script>

<style scoped>
table {
  border-spacing: 20px;
  border-collapse: separate;
}

/*table td {*/
/*  width: 30px;*/
/*  background: #ccc;*/
/*}*/
</style>