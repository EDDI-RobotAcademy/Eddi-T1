<template>
  <div>

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
                       :to="{ name : 'HandmadeCategoryView'}">
            핸드메이드
          </router-link>
          <router-link class="service" style="text-decoration: none; color: #2F4F4F;"
                       :to="{ name : 'KnowhowCategoryView'}">
            노하우
          </router-link>
          <router-link class="service" style="text-decoration: none; color: #2F4F4F;"
                       :to="{ name : 'HobbyCategoryView'}">
            취미/특기
          </router-link>
          <v-col cols="4">
            <v-text-field
                v-model="searchWord"
                outlined
                color="#2F4F4F"
                solo
                flat
                :append-icon="'mdi-magnify'"
                placeholder="통합검색"
                @click:append="moveSearchPage"
                @keypress.e.enter="moveSearchPage"
                style="margin-top: 30px;
              border: #2F4F4F"></v-text-field>
          </v-col>
          <template v-if="this.signInCheckValue">
            <v-btn
                plain
                @click="moveMyPage"
            >
              <h4>마이페이지</h4>
            </v-btn>
            <v-btn
                plain
                @click="signOut"
            >
              <h4>로그아웃</h4>
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
          <v-icon @click="moveShoppingCardPage" size="30" color="#2F4F4F">mdi-cart-variant</v-icon>
        </v-app-bar>
      </v-container>
      <v-main>
        <router-view/>
      </v-main>
    </v-app>

    <v-divider style="margin-top: 80px;"></v-divider>
    <footer-form/>
  </div>
</template>

<script>


import {mapActions, mapState} from "vuex";
import FooterForm from "@/components/footer/FooterForm";
export default {
  name: 'App',
  components: {FooterForm},
  computed:{
    ...mapState([
      'signInCheckValue',
      'memberInfoAfterSignIn',
      'searchResultList'
    ]),
  },
  data() {
    return {
      searchWord: ""
    }
  },
  methods: {
    ...mapActions([
      'requestSearchBySearchTermToSpring'
    ]),
    moveMyPage(){
      if (this.memberInfoAfterSignIn.memberType === "판매자"){
        this.$router.push('/order-manage')
      } else {
        this.$router.push('/buyer-info')
      }
    },
    moveToHome() {
      this.$router.push('/');
    },
    signOut() {
      this.$store.commit("SIGN_IN_CHECK_VALUE", false)
      localStorage.removeItem("vuex")
      localStorage.removeItem("userToken")
      alert("로그아웃 되었습니다.")
      this.$router.push({name: "HomeView"})
      history.go(0)
    },
    moveShoppingCardPage() {
      this.$router.push({name: 'ShoppingCartView'})
    },
    async moveSearchPage() {
      const keyword = this.searchWord
      console.log(keyword)
      await this.requestSearchBySearchTermToSpring(keyword)
      await this.$router.push({name: 'SearchView', params: {searchWord: keyword}});
      localStorage.setItem('searchWord', keyword)
    }
  },
  beforeUpdate() {
    console.log(this.signInCheckValue)
  }
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