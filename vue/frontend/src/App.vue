<template>
  <v-app>
    <v-container>
      <v-app-bar
          class="v-toolbar__content" elevation="0" height="100" color="white"
          width="auto" style="margin: 0 auto; justify-content: center" app>
        <div>
          <v-img class="mr-9" :src="require('@/assets/buydia_logo.png')" width="200px" contain
                 style="cursor: pointer"
                 @click="moveToHome"/>
        </div>
        <router-link class="service" style="text-decoration: none; color: #2F4F4F;"
                     :to="{ name : 'CommonPageHeader'}">
          핸드메이드
        </router-link>
        <router-link class="service" style="text-decoration: none; color: #2F4F4F;"
                     :to="{ name : 'CommonPageHeader'}">
          노하우
        </router-link>
        <router-link class="service" style="text-decoration: none; color: #2F4F4F;"
                     :to="{ name : 'CommonPageHeader'}">
          취미/특기
        </router-link>
        <v-col cols="4">
          <v-text-field
              outlined
              color="#2F4F4F"
              solo
              flat
              :append-icon="'mdi-magnify'"
              placeholder="통합검색"
              @click:append="show"
              style="margin-top: 30px;
              border: #2F4F4F"></v-text-field>
        </v-col>
        <template v-if="this.signInStatus != null">
          <v-btn
              plain
              @click="signOut"
          >
            <h4>로그아웃</h4>
          </v-btn>
          //마이페이지 설계 후 페이지 연결 필요!
          <v-btn
              plain
              to=""
          >
            <h4>마이페이지</h4>
          </v-btn>
        </template>

        <template v-else>
          <v-btn
              plain
              to="/sign-in"
          >
            <h4>로그인</h4>
          </v-btn>
          <v-btn
              plain
              to="/sign-up-choice"
          >
            <h4>회원가입</h4>
          </v-btn>
        </template>
        <v-icon @click="show" size="30" color="#2F4F4F">mdi-cart-variant</v-icon>
      </v-app-bar>
    </v-container>
    <v-main>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script>
export default {
  name: 'App',
  data() {
    return {
      show: false,
      signInStatus: localStorage.getItem("userToken")
    }
  },
  methods: {
    moveToHome() {
      this.$router.push('/');
    },
    signOut() {
      localStorage.removeItem("userToken")
      alert("로그아웃 되었습니다.")
      history.go(0)
    },
  },
};
</script>

<style>
.service {
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  -o-user-select: none;
  user-select: none;
  white-space: nowrap;
  display: inline-block;
  text-decoration: none;
  font-size: 18px;
  font-weight: bold;
  margin-right: 30px;
}
</style>