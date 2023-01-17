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
          <v-card
              width="380"
              height="550"
          >


            <v-img
                height="250"
                width="250"
                src="https://cdn-icons-png.flaticon.com/512/1029/1029010.png"
            ></v-img>

            <v-card-title>상품 현황</v-card-title>

            <v-card-text>

              <div class="my-4 text-subtitle-1">
                판매자님이 등록해주신 소중한 아이디어
              </div>

              <!--      <div>Small plates, salads & sandwiches - an intimate setting with 12 indoor seats plus patio seating.</div>-->
            </v-card-text>

            <v-divider class="mx-4"></v-divider>

            <v-card-title>등록된 상품 : 10건</v-card-title>
            <br/>

            <v-card-actions>
              <v-btn
                  color="deep-purple lighten-2"
                  text
                  @click="reserve"
              >
                상품 관리 페이지
              </v-btn>
            </v-card-actions>
          </v-card>
        </td>

        <!--구매 후기 현황-->
        <td>
          <v-card
              width="380"
              height="550"
          >

            <v-img
                height="250"
                width="250"
                src="https://cdn-icons-png.flaticon.com/512/4088/4088850.png"
            ></v-img>

            <v-card-title>구매 후기 현황</v-card-title>

            <v-card-text>


              <div class="my-4 text-subtitle-1">
                구매자님들이 남겨주신 후기
              </div>

              <!--      <div>Small plates, salads & sandwiches - an intimate setting with 12 indoor seats plus patio seating.</div>-->
            </v-card-text>

            <v-divider class="mx-4"></v-divider>

            <v-card-title>구매 후기 : 2건</v-card-title>
            <br/>

            <v-card-actions>
              <v-btn
                  color="deep-purple lighten-2"
                  text
                  @click="reserve"
              >
                후기 확인하기
              </v-btn>
              <br/>
            </v-card-actions>
          </v-card>
        </td>

        <!-- 문의 현황-->
        <td>
          <v-card
              width="380"
              height="550"
          >


            <v-img
                height="250"
                width="250"
                src="https://cdn-icons-png.flaticon.com/512/813/813020.png"
            ></v-img>

            <v-card-title>문의 현황</v-card-title>

            <v-card-text>

              <div class="my-4 text-subtitle-1">
                고객님들이 남겨주신 문의
              </div>

              <!--          <div>Small plates, salads & sandwiches - an intimate setting with 12 indoor seats plus patio seating.</div>-->
            </v-card-text>

            <v-divider class="mx-4"></v-divider>

            <v-card-title>답변 대기 문의 : 3건</v-card-title>
            <br/>


            <v-card-actions>
              <v-btn
                  color="deep-purple lighten-2"
                  text
                  @click="reserve"
              >
                문의 확인하기
              </v-btn>
            </v-card-actions>
          </v-card>
        </td>

        <!--주문 현황-->
        <td>
          <v-card
              width="380"
              height="550"
          >
            <v-img
                height="250"
                width="250"
                src="https://cdn-icons-png.flaticon.com/512/2728/2728447.png"
            ></v-img>

            <v-card-title>주문 현황</v-card-title>

            <v-card-text>


              <div class="my-4 text-subtitle-1">
                진행중인 주문내역
              </div>

              <!--          <div>Small plates, salads & sandwiches - an intimate setting with 12 indoor seats plus patio seating.</div>-->
            </v-card-text>

            <v-divider class="mx-4"></v-divider>

            <v-card-title>모든 주문 : 12건</v-card-title>
            <br/>


            <v-card-actions>
              <v-btn
                  color="deep-purple lighten-2"
                  text
                  @click="reserve"
              >
                주문내역 확인하기
              </v-btn>
            </v-card-actions>
          </v-card>
        </td>

      </tr>
    </table><br/>


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
            337,100 원
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