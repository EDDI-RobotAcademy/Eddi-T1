<template>
  <div>
    <v-navigation-drawer
      permanent
      height="100%"
      width="350px"
      app
      color="#FAEBD7"
      >
      <v-list-item style="height: 25%">
        <v-list-item-content>
          <v-list-item-title class="mb-5 ml-3">
            <router-link to="/">
              <span class="logo" style="color: #2F4F4F">buy</span>
              <span class="logo" style="color: #2F4F4F">idea</span>
            </router-link>
          </v-list-item-title>

          <v-list-item-subtitle
              class="black--text ml-5"
              style="font-size: 20px"
          >
            판매자님 환영합니다!
          </v-list-item-subtitle>

        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>

      <v-list dense nav>
        <v-list-item
            v-for="item in items"
            :key="item.title"
            :to="item.route"
            link
            class="mt-5 mb-5 ml-5"
        >
          <v-list-item-icon>
            <v-icon color="#2F4F4F">{{ item.icon }}</v-icon>
          </v-list-item-icon>

          <v-list-item-content style="height: 100%">
            <v-list-item-title class="#2F4F4F--text">{{
                item.title
              }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>

    </v-navigation-drawer>
  </div>
</template>

<script>
export default {
  name: "SellerNavi",
  data() {
    return {
      items: [
        {title: "정보 수정", icon: "mdi-account", route: "/"},
        {
          title: "상품 관리",
          icon: "mdi-play-box-outline",
          route: "/",
        },
        {title: "주문 관리", icon: "mdi-town-hall", route: "/"},
        {
          title: "후기 관리",
          icon: "mdi-pencil-box-outline",
          route: "/",
        },
        {
          title: "문의 관리",
          icon: "mdi-comment-question",
          route: "/",
        },
        {
          title: "배송 관리",
          icon: "mdi-truck-delivery-outline",
          route: "/",
        },
        {title: "환불 관리", icon: "mdi-cash-refund", route: "/"},
      ],
    };
  }
}
</script>

<style scoped>

</style>