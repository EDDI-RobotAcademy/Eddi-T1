<template>
  <v-card flat style="width: 100%">
    <v-card-text>
      <h2 style="margin-left: 50px">회원탈퇴</h2>
      <v-divider style="margin-top: 30px"></v-divider>
      <v-container style="width: 1000px">
        <div style="margin-top: 50px" align="center">
          <v-card style="width: 700px; height: auto; text-align: left">
            <h4 style="padding: 12px 20px">회원 탈퇴 시 주의사항🚨</h4>
            <v-divider></v-divider>
            <div style="padding: 12px 25px">
              <h5>▪ 탈퇴 후 회원 정보 및 이용기록은 모두 삭제되며, 다시 복구 할 수 없습니다.</h5>
              <h5>▪ 탈퇴 후 동일한 아이디로 재가입이 가능합니다.</h5>
            </div>
          </v-card>
        </div>
        <!-- 체크박스 -->
        <v-layout justify-end style="margin-right: 128px">
          <div style="margin-top: 22px">
            <h4>주의사항을 확인하였고, 탈퇴를 진행합니다.</h4>
          </div>
          <div>
            <v-checkbox v-model="consentCheckStatus">
            </v-checkbox>
          </div>

        </v-layout>
      </v-container>
    </v-card-text>
    <div align="center">
      <v-btn
          rounded
          class="white--text"
          style="background-color: #2F4F4F"
          elevation="0"
          :disabled="!consentCheckStatus"
          @click="accountDrop"
      >
        회원탈퇴
      </v-btn>
    </div>
  </v-card>
</template>

<script>
import {mapActions} from "vuex";

export default {
  name: "BuyerAccountDropForm",
  data(){
    return{
      consentCheckStatus: false
    }
  },
  methods:{
    ...mapActions([
        'requestCurrentUserAccountDropToSpring'
    ]),
    async accountDrop(){
      alert("회원탈퇴을 진행합니다.")
      const currentUserToken = this.$store.state.userToken;
      await this.requestCurrentUserAccountDropToSpring({currentUserToken})
      await this.$router.push({name: "HomeView"})
      localStorage.removeItem("vuex")
      alert("회원탈퇴가 완료됐습니다.")
    }
  }
}
</script>

<style scoped>

</style>