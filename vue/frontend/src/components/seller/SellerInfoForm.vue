<template>
  <form @submit.prevent="onSubmit">
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="80" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Seller Profile
      </v-toolbar-title>
    </v-app-bar>

    <div style="font-family: Arial">
      <v-row justify="center">
        <v-col cols="auto" style="padding-bottom: 90px">
          <v-card elevation="0" width="460">
            <v-card-text class="text-center px-12 py-16">
              <v-form @submit.prevent="onSubmit" ref="form">
                <div class="text-h4 font-weight-black mb-10">{{this.$store.state.memberInfoAfterSignIn.nickname}}<br/>업체 정보 입력</div>
                <div class="text-sm-caption">*는 필수 입력 사항입니다.</div>
                <div class="d-flex">
                  <v-text-field v-model="seller" label="대표 본명 입력*"
                                :rules="seller_rule" :disabled="false" required/>

                </div>


                <div class="d-flex">
                  <v-text-field v-model="city" label="도시" :disabled="true" required/>
                </div>

                <div class="d-flex">
                  <v-text-field v-model="street" label="기본 주소" :disabled="true" required/>
                </div>

                <div class="d-flex">
                  <v-text-field v-model="addressDetail" label="상세 주소" :disabled="false" required/>
                </div>

                <div class="d-flex">
                  <v-text-field v-model="zipcode" label="우편번호" :disabled="true" required/>

                  <v-btn text large outlined style="font-size: 13px"
                         class="mt-3 ml-5" color="blue lighten-1"
                         @click="callDaumAddressApi"
                         :disabled="false">
                    주소 확인
                  </v-btn>
                </div>

                <div class="d-flex">
                  <v-text-field v-model="companyPhoneNumber" label="업체 전화번호*"
                                :disabled="false" required/>
                </div>


                <div class="d-flex">
                  <v-text-field v-model="companyRegisterNumber" label="사업자 등록번호*"
                                :disabled="false" required/>
                  <v-btn text large outlined style="font-size: 13px"
                         class="mt-3 ml-5" color="#356859"
                         @click="checkRegistrationNumber"
                  >
                    번호 확인<br/>
                  </v-btn>
                </div>

                <v-btn type="submit" block x-large rounded elevation="0"
                       class="mt-6" color="#F7D358">
                  사업자 등록하기
                </v-btn>

              </v-form>
            </v-card-text>
          </v-card>
        </v-col>

      </v-row>
    </div>



  </v-container>
  </form>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";
import {mapActions, mapState} from "vuex";

export default {
  name: "SellerInfoForm",
  ...mapState([
    'loginUser'
  ]),
  components: {SellerNavi},
  data(){
    return{
      seller: "",


      companyPhoneNumber: "",
      companyRegisterNumber: "",


      city: '',
      street: '',
      addressDetail: '',
      zipcode: '',

      seller_rule: [
        v => !(v && v.length >= 6) || '판매자명은 6자 이상 입력할 수 없습니다.',
      ],
    }

  },
  methods: {
    ...mapActions([

    ]),

    checkRegistrationNumber(){
      alert("사업자 등록번호 확인")
    },


    onSubmit() {
      const { seller,   city, street, addressDetail, zipcode, companyPhoneNumber, companyRegisterNumber} = this
      this.$emit("submit", { seller,  city, street, addressDetail, zipcode, companyPhoneNumber, companyRegisterNumber})
    },

    callDaumAddressApi () {
      new window.daum.Postcode({
        oncomplete: (data) => {
          let fullRoadAddr = data.roadAddress;
          let extraRoadAddr = '';

          if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
            extraRoadAddr += data.bname;
          }

          if (data.buildingName !== '' && data.apartment === 'Y') {
            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }

          if (extraRoadAddr !== '') {
            extraRoadAddr = ' (' + extraRoadAddr + ')';
          }

          if (fullRoadAddr !== '') {
            fullRoadAddr += extraRoadAddr;
          }

          this.city = data.sido;
          this.zipcode = data.zonecode;
          this.street = /*data.sigungu +  ' ' + */ fullRoadAddr;

          this.streetPass = true
        }
      }).open()
    }
  },

}
</script>

<style scoped>

</style>