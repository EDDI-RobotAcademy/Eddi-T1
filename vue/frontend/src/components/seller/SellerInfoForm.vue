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
      <div v-if="dataPresenceCheck">
        <v-container style="width: 1200px">
          <h2>내 정보</h2>
          <v-divider style="margin-top: 50px;"></v-divider>

          <v-container style="width: 900px">
            <div align="center" style="margin-top: 40px;">
              <v-img
                  style="width: 398px"
                  src="@/assets/buydia_logo.png"
              ></v-img>
            </div>
            <v-card style="width: 100%; margin-top: 50px;" flat>
              <v-layout justify-center>
                <h4 style="margin-top: 8px; margin-right: 30px;">상호 명</h4>
                <div style="width: 250px">
                  <v-text-field
                      v-model="memberInfoAfterSignIn.nickname"
                      dense
                      readonly
                      solo-inverted
                  />
                </div>
              </v-layout>
              <v-layout justify-center>
                <h4 style="margin-top: 8px; margin-right: 53px;">성명</h4>
                <div style="width: 250px">
                  <v-text-field
                      v-model="sellerInfoData.realName"
                      dense
                      readonly
                      solo-inverted
                  />
                </div>
              </v-layout>
              <v-layout justify-center>
                <h4 style="margin-top: 8px;">사업자 번호</h4>
                <div style="margin-left: 30px; width: 220px">
                  <v-text-field
                      v-model="sellerInfoData.registrationNumber"
                      dense
                      readonly
                      solo-inverted
                  />
                </div>
              </v-layout>
              <v-layout justify-center>
                <h4 style="margin-top: 8px;">핸드폰 번호</h4>
                <div style="margin-left: 30px; width: 220px">
                  <v-text-field
                      v-model="sellerInfoData.phone"
                      dense
                      readonly
                      solo-inverted
                  />
                </div>
              </v-layout>
              <v-layout justify-center>
                <h4 style="margin-top: 8px;">주소</h4>
                <div style="margin-left: 30px; width: 270px">
                  <v-text-field
                      v-model="sellerInfoData.street"
                      dense
                      readonly
                      solo-inverted
                  />
                </div>
              </v-layout>
              <v-layout justify-center>
                <h4 style="margin-top: 8px;">상세주소</h4>
                <div style="margin-left: 30px; width: 240px">
                  <v-text-field
                      v-model="sellerInfoData.addressDetail"
                      dense
                      readonly
                      solo-inverted
                  />
                </div>
              </v-layout>


              <div align="center">
                <div id="map" style="width:500px;height:400px;"></div>
              </div>
            </v-card>
          </v-container>
        </v-container>
      </div>

      <div style="font-family: Arial" v-else>
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
import {mapActions, mapState} from "vuex";

export default {
  name: "SellerInfoForm",
  components: {SellerNavi},
  computed: {
    ...mapState([
      'sellerInfoData',
      'memberInfoAfterSignIn'
    ])
  },
  data() {
    return {
      searchAddressData: "",
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
      dataPresenceCheck: false,
      seller_rule: [
        v => !(v && v.length > 5) || '판매자명은 5자까지 입력가능합니다.',
      ],
      companyNum_rule: [
        v => !(v && v.length > 12) || '사업자 등록번호는 10자까지 입력가능합니다. '
      ],
    }
  },
  methods: {
    ...mapActions([
      'requestSellerInfoToSpring'
    ]),
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
      this.$emit("submit", {
        seller,
        city,
        street,
        addressDetail,
        zipcode,
        companyPhoneNumber,
        companyRegisterNumber,
        nickname
      })
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
    },
    addScript() {
      const script = document.createElement('script');
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      script.src = 'http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=4c3cfe3db7e73977866ffcede86cde8f&libraries=services';
      // script.src = 'http://dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=APPKEY&libraries=services';
      document.head.appendChild(script);
    },

    initMap() {
      var container = document.getElementById('map');
      var options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 3
      };
      var map = new kakao.maps.Map(container, options);

      var geocoder = new kakao.maps.services.Geocoder();

      geocoder.addressSearch(this.searchAddressData, function(result, status) {

        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {

          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);


          // 결과값으로 받은 위치를 마커로 표시합니다
          var marker = new kakao.maps.Marker({
            map: map,
            position: coords
          });

          // 인포윈도우로 장소에 대한 설명을 표시합니다
          var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
          });
          infowindow.open(map, marker);

          // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
          map.setCenter(coords);
        }
      })

      //마커추가하려면 객체를 아래와 같이 하나 만든다.
      var marker = new kakao.maps.Marker({
        position: map.getCenter()
      });
      marker.setMap(map);
    },
  },
  async created() {
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname
    await this.requestSellerInfoToSpring(nickname)

    if (!(this.sellerInfoData.constructor === Object && Object.keys(this.sellerInfoData).length === 0)) {
      this.dataPresenceCheck = true
    } else {
      this.dataPresenceCheck = false
    }
    this.searchAddressData = this.sellerInfoData.street +" "+ this.sellerInfoData.addressDetail
  },

  mounted() {
    if (self.name != 'reload') {
      self.name = 'reload';
      self.location.reload(true);
    }
    else self.name = '';

    window.kakao && window.kakao.maps ? this.initMap() : this.addScript();
  }
}
</script>

<style scoped>

</style>