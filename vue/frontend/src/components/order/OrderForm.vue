<template>

  <div class="white" style="font-family: Arial">
    <v-row justify="center">
      <v-col cols="auto" style=" padding-top: 100px; padding-bottom: 300px">

        <div>
          <v-card style="width:1000px">
            <div>

              <!--선택한 상품 정보-->

              <h1 align="center" class="section" style="color: #2F4F4F">
                <v-img :src="require('@/assets/sign_up_choice_num1.png')" width="130" class="mx-auto mb-6"/>
                ✔ My Cart
              </h1>

              <div v-if="this.productReadCheckValue">
                <table class="cart">
                  <v-simple-table class="ui table">
                    <thead class="wrap">
                    <tr>
                      <th align="left">상품명</th>
                      <th align="left">수량</th>
                      <th align="left">배송비</th>
                      <th align="left">가격</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                      <td class="product">
                        <v-row class="mt-5 mb-3">
                          <img :src="require('@/assets/productImg/' + product.productImages[0].editedName)">
                          <p class="mt-7 ml-2"></p>
                          <h4 class="header">{{ product.title }}
                            <div class="sub header">{{ product.nickname }}</div>
                          </h4>
                        </v-row>
                      </td>

                      <td class="right aligned">{{ productQuantity }}</td>
                      <td class="right aligned">{{ productDeliveryFee | comma }}원</td>
                      <td class="right aligned">{{ product.price | comma }}원</td>
                    </tr>
                    </tbody>
                    <tfoot class="wrap">
                    <tr>
                      <th colspan="2"></th>
                      <th align="right">TOTAL:</th>
                      <th align="left"><h3>{{ productTotalPrice | comma }}원</h3></th>
                    </tr>
                    </tfoot>
                  </v-simple-table>
                </table>
              </div>

              <!--장바구니 데이터-->
              <div v-else>
                <table class="cart" v-for="(item, index) in productInfoByShoppingCart" :key="index">
                  <v-simple-table class="ui table">
                    <thead class="wrap">
                    <tr>
                      <th align="left">상품명</th>
                      <th align="left">수량</th>
                      <th align="left">배송비</th>
                      <th align="left">가격</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                      <td class="product">
                        <v-row class="mt-5 mb-3">
                          <img :src="require('@/assets/productImg/' + item.product.productImages[0].editedName)">
                          <p class="mt-7 ml-2"></p>
                          <h4 class="header">{{ item.product.title }}
                            <div class="sub header">{{ item.product.nickname }}</div>
                          </h4>
                        </v-row>
                      </td>

                      <td class="right aligned">{{ item.itemCount }}</td>
                      <td class="right aligned">{{ item.product.productInfo.deliveryFee | comma }}원</td>
                      <td class="right aligned">{{ item.product.price | comma }}원</td>
                    </tr>
                    </tbody>
                    <tfoot class="wrap">
                    <tr>
                      <th colspan="2"></th>
                      <th align="right">TOTAL:</th>
                      <th align="left"><h3>
                        {{ item.product.price * item.itemCount + item.product.productInfo.deliveryFee | comma }}원</h3>
                      </th>
                    </tr>
                    </tfoot>
                  </v-simple-table>
                </table>
              </div>
            </div>

            <v-divider></v-divider>

            <!--배송정보 입력-->
            <h1 align="center" class="section" style="color: #2F4F4F">
              <v-img :src="require('@/assets/sign_up_choice_num2.png')" width="130" class="mx-auto mb-6"/>
              ✔ Shipping
            </h1>

            <table class="shipping">

              <div class="d-flex">
                <v-text-field outlined v-model="recipient" label="수령인*" :disabled="false" required/>
              </div>

              <div class="d-flex">
                <v-text-field outlined v-model="phone" label="연락처*" :disabled="false" placeholder="000-0000-0000"
                              required/>
              </div>

              <div class="d-flex">
                <v-text-field outlined v-model="city" label="도시*" :disabled="true" required/>
              </div>
              <div class="d-flex">
                <v-text-field outlined v-model="street" label="기본 주소*" :disabled="true" required/>
              </div>
              <div class="d-flex">
                <v-text-field outlined type="text" v-model="addressDetail" label="상세 주소*" :disabled="false" required/>
              </div>
              <div class="d-flex">
                <v-text-field v-model="zipcode" label="우편번호*" :disabled="true" required/>
                <v-btn text large outlined style="font-size: 13px"
                       class="mt-3 ml-5" color="#2F4F4F"
                       @click="callDaumAddressApi"
                       :disabled="false">
                  주소 확인
                </v-btn>
              </div>

            </table>
          </v-card>


          <v-btn @click="PaymentBtn" block x-large class="bt1" color="#2F4F4F" style="color: white" tile>
            {{ productTotalPrice | comma }}원 결제하기
          </v-btn>

        </div>
      </v-col>

    </v-row>


  </div>


</template>


<script>


import {Bootpay} from '@bootpay/client-js'
import {mapActions} from "vuex";

export default {

  name: "OrderForm",
  data() {
    return {
      /*orderNo: '',*/
      recipient: '',
      phone: '',
      city: '',
      street: '',
      addressDetail: '',
      zipcode: '',
      order_name: [],
      address: [],
      orderInfoRequest: [],
    }
  },
  props: {
    product: {
      type: Object,
    },
    productQuantity: {
      type: Number
    },
    productDeliveryFee: {
      type: Number
    },
    productReadCheckValue: {
      type: Boolean
    },
    productInfoByShoppingCart: {
      type: Array,
    },
    productTotalPrice: {
      type: Number
    },
  },
  async mounted() {

    if (this.productReadCheckValue == true) {
      this.order_name = this.product.title
    } else {
      for (let i = 0; i < this.productInfoByShoppingCart.length; i++) {
        this.order_name.push(this.productInfoByShoppingCart[i].product.title)
      }
    }
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
  methods: {
    ...mapActions([
       'requestPaymentSuccessfulOrderInfoForSpring'
    ]),
    //주소Api
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
          this.street =/* data.sigungu + ' ' +*/ fullRoadAddr;
          this.streetPass = true
        }
      }).open()
    },
    //결제 성공시
    async paymentSuccessful() {

      if (this.productReadCheckValue == true) {
        console.log("상세페이지 상품")
        const addressData = {
          recipient: this.recipient,
          phone: this.phone,
          city: this.city,
          street: this.street,
          addressDetail: this.addressDetail,
          zipcode: this.zipcode,
        }

        this.orderInfoRequest.push({
          buyer: this.$store.state.memberInfoAfterSignIn.nickname,
          productNo: this.product.productNo,
          quantity: this.productQuantity,
          orderStatus: "입금완료"
        })
        const orderInfoRequestList = this.orderInfoRequest
        const addressRequest = addressData
        await this.requestPaymentSuccessfulOrderInfoForSpring({orderInfoRequestList, addressRequest})

      } else {
        console.log("장바구니 상품")
        const addressData = {
          recipient: this.recipient,
          phone: this.phone,
          city: this.city,
          street: this.street,
          addressDetail: this.addressDetail,
          zipcode: this.zipcode,
        }

        for (let i = 0; i < this.productInfoByShoppingCart.length; i++) {
          this.orderInfoRequest.push({
            buyer: this.$store.state.memberInfoAfterSignIn.nickname,
            productNo: this.productInfoByShoppingCart[i].product.productNo,
            quantity: this.productInfoByShoppingCart[i].itemCount,
            orderStatus: "입금완료"
          })
        }

        const orderInfoRequestList = this.orderInfoRequest
        const addressRequest = addressData
        await this.requestPaymentSuccessfulOrderInfoForSpring({orderInfoRequestList, addressRequest})
      }
    },

    //결제
    async PaymentBtn() {
      console.log(this.city)
      try {
        const response = await Bootpay.requestPayment({

          "application_id": "63a16493cf9f6d001ed120aa",
          // 실제 가격대로 결제하려면 아래와 같은 코드 사용
          // "price": this.productTotalPrice,
          "price": 100,
          "order_name": this.order_name,
          "order_id": "TEST_ORDER_ID",
          "pg": "이니시스",
          "method": "카드",
          "tax_free": 0,
          "user": {
            "id": "회원아이디",
            "username": "회원이름",
            "phone": "01000000000",
            "email": "test@test.com"
          },
          "extra": {
            "open_type": "iframe",
            "card_quota": "0,2,3",
            "escrow": false,
            "display_success_result": true,
          }
        })
        switch (response.event) {
          case 'issued':
            // 가상계좌 입금 완료 처리
            break
          case 'done':
            console.log(response)
            // 결제 완료 처리
            await this.paymentSuccessful()
            await this.$router.push({name: "HomeView"})
            break
          case 'confirm': //payload.extra.separately_confirmed = true; 일 경우 승인 전 해당 이벤트가 호출됨
            console.log(response.receipt_id)
            /**
             * 1. 클라이언트 승인을 하고자 할때
             * // validationQuantityFromServer(); //예시) 재고확인과 같은 내부 로직을 처리하기 한다.
             */
                // eslint-disable-next-line no-case-declarations
            const confirmedData = await Bootpay.confirm() //결제를 승인한다
            if (confirmedData.event === 'done') {
              //결제 성공
            } else if (confirmedData.event === 'error') {
              //결제 승인 실패
            }

            /**
             * 2. 서버 승인을 하고자 할때
             * // requestServerConfirm(); //예시) 서버 승인을 할 수 있도록  API를 호출한다. 서버에서는 재고확인과 로직 검증 후 서버승인을 요청한다.
             * Bootpay.destroy(); //결제창을 닫는다.
             */
            break
        }
      } catch (e) {
        // 결제 진행중 오류 발생
        // e.error_code - 부트페이 오류 코드
        // e.pg_error_code - PG 오류 코드
        // e.message - 오류 내용
        console.log(e.message)
        switch (e.event) {
          case 'cancel':
            // 사용자가 결제창을 닫을때 호출
            console.log(e.message);
            break
          case 'error':
            // 결제 승인 중 오류 발생시 호출
            console.log(e.error_code);
            break
        }
      }
    }
  }
}
</script>

<style scoped>
/*table {
  margin-top: 10px;
  width: 100%;
  border: 1px;
}*/
.cart {
  padding: 10px;
  padding-bottom: 0px;
  width: 100%;
}

.shipping {
  padding: 50px;
  padding-bottom: 100px;
  width: 100%;
}

img {
  width: 80px;
  height: 80px;
}

h4 div {
  color: #666666;
  font-size: .6em;
}

.section {
  padding-top: 50px;
  padding-bottom: 30px;
}

.wrap {
  background-color: #eaebee;
}
</style>