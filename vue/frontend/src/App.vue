<template>
  <v-app>
    <v-app-bar elevation="0" height="100" color="white" app>
      <v-app-bar-title>
        <div style="margin-left: 100px">
          <v-img class="none_drag" :src="require('@/assets/buydia_logo.png')" width="200" @click="moveToHome"/>
        </div>
      </v-app-bar-title>
      <v-row style="margin-left: 50px" align="center">
        <router-link class="service" style="text-decoration: none; color: #2F4F4F;" :to="{ name : 'CommonPageHeader'}">핸드메이드</router-link>
        <router-link class="service" style="text-decoration: none; color: #2F4F4F;" :to="{ name : 'CommonPageHeader'}">노하우</router-link>
        <router-link class="service" style="text-decoration: none; color: #2F4F4F;" :to="{ name : 'CommonPageHeader'}">취미/특기</router-link>
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
        <router-link style="text-decoration: none; color: #2F4F4F; margin-left: 80px; margin-right: 40px" :to="{ name : 'CommonPageHeader'}">로그인</router-link>
        <router-link style="text-decoration: none; color: #2F4F4F; margin-right: 40px" :to="{ name : 'CommonPageHeader'}">회원가입</router-link>
        <v-icon @click="show" size="30" color="#2F4F4F">mdi-cart-variant</v-icon>
      </v-row>
    </v-app-bar>
    <v-main>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script>

export default {
  name: 'App',
  data () {
    return {
      show: false
    }
  },
  methods: {
    moveToHome() {
      this.$router.push('/');
    },
  }
};
</script>

<style>
.none_drag {
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  -o-user-select: none;
  user-select: none;
}

.service {
  text-decoration: none;
  font-size: 18px;
  font-weight: bold;
  margin-right: 30px;
}
</style>
