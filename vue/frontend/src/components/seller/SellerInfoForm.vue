<template>
  <form @submit.prevent="onSubmit">
    <v-container>

      <!--Seller Navigation Drawer-->
      <seller-navi/>

      <!--Top bar-->
      <v-app-bar color="white" elevate-on-scroll height="81" app elevation="3">
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
                  <div class="text-h4 font-weight-black mb-10">
                    {{ this.$store.state.memberInfoAfterSignIn.nickname }}<br/>업체 정보 입력
                  </div>
                  <div class="text-sm-caption">*는 필수 입력 사항입니다.</div>
                  <div class="d-flex">
                    <v-text-field v-model="seller" label="대표 성명 입력*"
                                  maxlength="5"
                                  :rules="seller_rule" :disabled="false" required
                                  @change="checkInputRealName"/>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="city" label="도시" :disabled="true" required/>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="street" label="기본 주소" :disabled="true" required/>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="addressDetail" label="상세 주소" :disabled="false" required
                                  @change="checkInputDetailAddress"/>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="zipcode" label="우편번호" :disabled="true" required/>

                    <v-btn text large outlined style="font-size: 13px"
                           rounded
                           class="mt-3 ml-5" color="blue lighten-1"
                           @click="callDaumAddressApi"
                           :disabled="false">
                      주소 확인
                    </v-btn>
                  </div>

                  <div class="d-flex">
                    <v-text-field v-model="companyPhoneNumber" label="업체 전화번호*"
                                  :disabled="false" required
                                  @change="checkInputPhoneNum"/>
                  </div>


                  <div class="d-flex">
                    <v-text-field v-model="companyRegisterNumber" label="사업자 등록번호*"
                                  :disabled="false" required
                                  maxlength="12"
                                  :rules="companyNum_rule"
                                  @change="checkInputCompanyNum"

                    />
                    <v-btn text large outlined style="font-size: 13px"
                           rounded
                           class="mt-3 ml-5" color="#356859"
                           @click="checkRegistrationNumber(companyRegisterNumber)"
                           :disabled="(this.realNameInputCheckValue &&
                                       this.addressInputCheckValue &&
                                       this.detailAddressInputCheckValue &&
                                       this.phoneInputCheckValue &&
                                       this.companyNumInputCheckValue) === false">
                      조회<br/>
                    </v-btn>
                  </div>

                  <v-btn type="submit" elevation="0" large width="200px" rounded
                         class="mt-6" style="background-color: #2F4F4F; color: white"
                         :disabled="(this.realNameInputCheckValue &&
                                     this.addressInputCheckValue &&
                                     this.detailAddressInputCheckValue &&
                                     this.phoneInputCheckValue &&
                                     this.companyNumInputCheckValue &&
                                     this.companyNumCheckValue) === false">
                    <h4>등록하기</h4>
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

export default {
  name: "SellerInfoForm",
  components: {SellerNavi},
  data() {
    return {
      seller: "",
      companyPhoneNumber: "",
      companyRegisterNumber: "",
      city: '',
      street: '',
      addressDetail: '',
      zipcode: '',
      realNameInputCheckValue: false,
      addressInputCheckValue: false,
      detailAddressInputCheckValue: false,
      phoneInputCheckValue: false,
      companyNumInputCheckValue: false,
      companyNumCheckValue: false,
      seller_rule: [
        v => !(v && v.length > 5) || '판매자명은 5자까지 입력가능합니다.',
      ],
      companyNum_rule:[
          v => !(v && v.length > 12) || '사업자 등록번호는 10자까지 입력가능합니다. '
      ],
    }
  },
  methods: {
    checkInputRealName() {
      this.realNameInputCheckValue = true
    },
    checkInputDetailAddress() {
      this.detailAddressInputCheckValue = true
    },
    checkInputPhoneNum() {
      this.phoneInputCheckValue = true
    },
    checkInputCompanyNum() {
      this.companyNumInputCheckValue = true
    },
    checkRegistrationNumber(companyNum) {

      if (companyNum != null) {
        switch (companyNum) {
          case "012-34-56789":
            this.companyNumCheckValue = true
            alert("등록된 사업자 번호입니다.")
            break

          case "123-45-67890":
            this.companyNumCheckValue = true
            alert("등록된 사업자 번호입니다.")
            break

          case "098-76-54321":
            this.companyNumCheckValue = true
            alert("등록된 사업자 등록번호")
            break

          case "089-76-54321":
            this.companyNumCheckValue = true
            alert("등록된 사업자 등록번호")
            break

          case "987-65-43210":
            this.companyNumCheckValue = true
            alert("등록된 사업자 등록번호")
            break

          default:
            this.companyNumCheckValue = false
            alert("등록되지 않은 사업자 번호입니다.")
            break
        }
      } else {
        alert("사업자 등록번호를 입력해주세요.")
        this.companyNumInputCheckValue = false
      }
    },
    onSubmit() {
      const nickname = this.$store.state.memberInfoAfterSignIn.nickname
      const {seller, city, street, addressDetail, zipcode, companyPhoneNumber, companyRegisterNumber} = this
      this.$emit("submit", {seller, city, street, addressDetail, zipcode, companyPhoneNumber, companyRegisterNumber, nickname})
    },

    callDaumAddressApi() {
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

      this.addressInputCheckValue = true
      console.log("주소")
    }
  },

}
</script>

<style scoped>

</style>