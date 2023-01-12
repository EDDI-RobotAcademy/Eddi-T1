<template>
  <v-footer>
    <v-container style="width: 1000px">
      <v-layout>
        <v-layout style="margin-top: 30px; margin-bottom: 50px;">
          <div
              style="width: 130px; height: 130px;">
            <v-img
                src="@/assets/buydia_logo.png"
            >
            </v-img>
          </div>

          <!--바이디어 정보 -->
          <div style="margin-left: 50px;">
            <h4 style="margin-bottom: 10px;">(주)바이디어</h4>
            <div v-for="(item, index) in buy_diaInfo" :key="index">
              <h5>대표이사: {{item.name}}</h5>
              <h5>주소: {{item.address}}</h5>
              <h5>사업자등록번호:{{item.companyNumber}}</h5>
              <h5>통신판매업: {{item.mailOrderBusiness}}</h5>
              <h5>팩스: {{item.faxNum}}</h5>
            </div>
            <h5 style="margin-top: 80px;">Copyright © 2023 Backpackr All right reserved.</h5>
          </div>
        </v-layout>

        <v-layout style="margin-top: 30px; margin-bottom: 50px; margin-left: 100px;">
          <div>
            <h3>고객센터</h3>

            <h1 style="margin-top: 10px;">
              1664-1234
              <span style="font-size: 15px; font-weight: bold;">월~토요일 오전 7시~오후 6시</span>
            </h1>
            <div style="margin-top: 12px;">
              <h5>메일:&nbsp;  help@buydia.com</h5>
              <h5>제휴문의:&nbsp;  partnership@buydia.com</h5>
            </div>


            <v-btn style="margin-top: 20px;"
                v-for="icon in icons" :key="icon" icon>
              <v-icon size="24">
                {{icon}}
              </v-icon>
            </v-btn>
          </div>
        </v-layout>
      </v-layout>

    </v-container>

  </v-footer>
</template>

<script>
export default {
  name: "FooterForm",

  data(){
    return {
      icons: [
        'mdi-facebook',
        'mdi-instagram',
      ],
      buy_diaInfo:[
        {
          name: "조안나, 김소연, 박선호, 진건오, 임재범",
          address: '서울특별시 강남구 강남구 테헤란로14길 6',
          companyNumber: "123-45-67890",
          mailOrderBusiness: "2022-바이디어-1234",
          faxNum: "070-1234-5678",
        },
      ]
    }
  }
}
</script>

<style scoped>

</style>