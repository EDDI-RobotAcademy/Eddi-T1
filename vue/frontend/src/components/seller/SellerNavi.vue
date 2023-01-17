<template>
  <div>

    <!--Seller Navigation Drawer-->

    <v-navigation-drawer
      permanent
      height="100%"
      width="260px"
      app
      color="#2F4F4F"
      >
      <v-list-item style="height: 25%">
        <v-list-item-content>
          <v-list-item-title class="mb-5 ml-8">
            <router-link to="/order-manage">
              <v-avatar
                  :size="120"
                  color="grey lighten-4"
              >
                <img src="@/assets/default_profile_image.png" alt="avatar">
              </v-avatar>
            </router-link>
          </v-list-item-title>


          <v-list-item-subtitle
              class="white--text ml-8"
              style="font-size: 16px"
          >
            {{ this.$store.state.memberInfoAfterSignIn.nickname }}님 환영합니다!
          </v-list-item-subtitle>

        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>

      <!-- 관리항목 -->

      <v-list dense nav>
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
            <v-list-item-title class="white--text">{{
                item.title
              }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>


      <template>
        <v-list dense nav>
          <div class="pa-2" style="margin-top: 280px">
            <v-btn
                block
                @click="signOut"
            >
              Logout
            </v-btn>
          </div>
        </v-list>
      </template>


    </v-navigation-drawer>
  </div>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: "SellerNavi",
  data() {
    return {
      items: [
        {title: "내 정보", icon: "mdi-account", route: "/seller-info"},
        {
          title: "상품 관리",
          icon: "mdi-lightbulb-on-outline",
          route: "/product-manage",
        },
        {title: "주문 관리", icon: "mdi-credit-card-settings-outline", route: "/order-manage"},
        {
          title: "후기 관리",
          icon: "mdi-pencil-box-outline",
          route: "/review-manage",
        },
        {
          title: "문의 관리",
          icon: "mdi-comment-question",
          route: "/qna-manage",
        },
      ],
    };
  },
  methods: {
    ...mapState([
      'signInCheckValue'
    ]),
    signOut() {
      this.$store.commit("SIGN_IN_CHECK_VALUE",false)
      this.$store.state.signInCheckValue = false
      localStorage.removeItem("vuex")
      localStorage.removeItem("userToken")
      alert("로그아웃 되었습니다.")
      this.$router.push({name: "HomeView"})
      history.go(0)
    },
  }
}
</script>

<style scoped>

</style>