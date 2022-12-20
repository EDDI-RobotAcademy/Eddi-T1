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
      myPageCategoryItems: [
        {title: "최근 주문내역", count: 0},
        {title: "취소/반품 내역", count: 0},
        {title: "최근 본 상품", count: 3},
        {title: "내가 작성한 리뷰", count: 4},
      ],
    }
  },
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