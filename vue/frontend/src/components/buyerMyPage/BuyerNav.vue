<template>
  <v-container style="width: 1400px">
    <v-navigation-drawer
        permanent
        height="100%"
        width="260px"
        app
        color="#2F4F4F"
    >
      <v-list-item style="height: 25%">
        <v-list-item-content>
          <v-list-item-title class="mb-5" style="margin-top: 250px">
            <div align="center">
              <router-link to="/order-manage">
                <v-avatar
                    :size="120"
                    color="grey lighten-4"
                >
                  <img src="@/assets/default_profile_image.png" alt="avatar">
                </v-avatar>
              </router-link>
            </div>

          </v-list-item-title>


          <v-list-item-subtitle
              class="white--text justify-center mt-8"
              style="font-size: 16px"
          >
            <div align="center">
              {{ this.nickname }} 님 환영합니다!
            </div>
          </v-list-item-subtitle>

        </v-list-item-content>
      </v-list-item>

      <v-divider style="border-color: white; margin-top: 150px" ></v-divider>

      <!-- 관리항목 -->

      <v-list dense nav class="mt-3">
        <v-list-item
            clas="tile"
            v-for="item in items"
            :key="item.title"
            :to="item.route"
            link
            class="mt-5 mb-5 ml-5"
        >
          <v-list-item-icon>
            <v-icon color="white">{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content style="height: 100%">
            <v-list-item-title class="white--text">
              {{ item.title }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </v-container>
</template>

<script>
export default {
  name: "BuyerNav",
  data(){
    return {
      nickname: this.$store.state.memberInfoAfterSignIn.nickname,
      items: [
        {
          title: "내 정보",
          icon: "mdi-account",
          route: "/buyer-info"},
        {
          title: "최근 주문내역",
          icon: "mdi-currency-usd",
          route: "/buyer-orderInfo"},
        {
          title: "나의 문의",
          icon: "mdi-comment-question",
          route: "/buyer-qna"},
      ],
    }
  },
  async mounted() {
    this.nickname = this.$store.state.memberInfoAfterSignIn.nickname
  },
}
</script>

<style scoped>

</style>