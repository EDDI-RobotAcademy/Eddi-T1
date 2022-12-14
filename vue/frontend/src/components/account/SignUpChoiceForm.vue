<template>
  <v-container>
    <div class="white" style="font-family: Arial">
      <v-col cols="auto" style="padding-bottom: 90px">
        <v-img
            :src="require('@/assets/buydia_logo.png')" width="300" class="mx-auto mb-6"/>
        <h5 class="text-md-center" style="font-weight: normal">
          회원 타입을 선택해주세요.</h5>
        <v-row justify="center">
          <div class="my-2">
            <v-btn width="200" height="150" text large outlined style="font-size: large"
                   class="mx-auto" id="heightSizeBox" color="#2F4F4F" @click="null">
              <h5 style="font-weight: normal">
                <v-icon size="50px">mdi-account-plus-outline</v-icon>
                <br/> 판매자 회원가입
              </h5>
            </v-btn>
          </div>
          <div>
            <v-container></v-container>
          </div>
          <div class="my-2">
            <v-btn width="200" height="150" text large outlined style="font-size: large"
                   class="mx-auto" id="heightSizeBox" color="#2F4F4F" @click="null">
              <h5 style="font-weight: normal">
                <v-icon size="50px">mdi-account-plus</v-icon>
                <br/> 일반회원 회원가입
              </h5>
            </v-btn>
          </div>
        </v-row>
        <div id="heightSizeBox" class="text-md-center">
          <h5 style="font-weight: normal">
            이미 가입한 계정이 있으신가요?</h5>
          <router-link to="/sign-in-view"
                       style="font-weight: normal; font-size: small">
            로그인 화면으로 이동하기
          </router-link>
        </div>
      </v-col>
    </div>
  </v-container>
</template>

<script>
export default {
  name: "SignUpChoiceForm"
}
</script>

<style scoped>
#heightSizeBox {
  margin-top: 50px;
}

</style>