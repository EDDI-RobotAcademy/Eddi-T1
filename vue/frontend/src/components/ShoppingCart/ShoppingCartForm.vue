<template>
  <div>
    <v-container style="width: 1000px">
      <div style="margin-top: 30px;">
        <h2>장바구니</h2>
      </div>
      <v-divider style="margin-top: 30px; margin-bottom: 30px;"></v-divider>

      <!-- 장바구니 상품 표시 카드 -->
      <v-container style="width: 900px" v-if="!shoppingBucketProductItemList || (Array.isArray(shoppingBucketProductItemList) && shoppingBucketProductItemList.length === 0)">
        <div align="center">
          <h2>장바구니에 상품이 없습니다.</h2>
        </div>
      </v-container>

      <v-container style="width: 900px" v-else>
        <v-card style="border: 1px solid black; margin-top: 10px;"
                v-for="(item, index) in shoppingBucketProductItemList" :key="index">
          <v-layout style="background-color: #2F4F4F">
            <v-checkbox style="margin-left: 30px;" color="#FAEBD7" dark v-model="selectList"
                        @click="selectProduct(item.product.price, item.itemCount, this)"
                        :value="item"
                        type="checkbox"
            />

            <h4 style="margin-top: 20px; color: white">{{ item.product.nickname }}</h4>

          </v-layout>

          <v-layout>
            <v-card max-width="100"
                    style="padding: 15px 15px 15px 15px"
                    flat>
                            <v-img
                                height="75px"
                                :src="require('@/assets/productImg/'+ item.product.productImages[0].editedName)"
                            >
                            </v-img>
            </v-card>

            <v-card style="width: 100%;" flat>
              <v-layout style="margin-bottom: 30px;">
                <h4 style="margin-top: 40px; padding: 0px 0px 0px 20px">{{ item.product.title }}</h4>

                <v-spacer></v-spacer>
                <v-layout style="margin-top: 40px" justify-end>

                  <div>
                    <v-btn small plain elevation="0" @click="minusProductAmount(index)"
                           :disabled="showMinusButtonValue"

                    >
                      <h1>-</h1>
                    </v-btn>
                  </div>
                  <div>
                    <h3>{{ item.itemCount }}</h3>
                  </div>
                  <div>
                    <v-btn small plain elevation="0" @click="plusProductAmount(index)"
                           :disabled="showPlusButtonValue"
                    >
                      <h1>+</h1>
                    </v-btn>
                  </div>

                  <div style="margin-top: 5px; margin-left: 30px;">
                    <h5>{{ item.product.price | comma }}원</h5>
                  </div>

                  <div style=" padding: 0px 10px 0px 30px">
                    <v-btn
                        rounded
                        small
                        elevation="0"
                        style="background-color: #2F4F4F;
                        color: white; margin-left: 10px;"
                    >
                      삭제
                    </v-btn>
                  </div>
                </v-layout>
              </v-layout>
            </v-card>
          </v-layout>

          <v-card
              flat
              style="border-top: 1px solid black; height: 50px">
            <v-layout>
              <div style="padding: 13px 10px 10px 20px">
                <h4>상품 가격</h4>
              </div>
              <v-spacer></v-spacer>
              <div style="padding: 13px 20px 10px 0px">
                {{ item.product.price * item.itemCount | comma }}원
              </div>
            </v-layout>
          </v-card>

          <v-card
              flat
              style="border-top: 1px solid black; height: 80px">
            <v-layout>
              <div style="padding: 30px 0px 0px 20px">
                <h4>배송비</h4>
              </div>
              <v-spacer></v-spacer>
              <div align="end" style="padding: 20px 20px 0px 0px"
                   v-if="item.product.price * item.itemCount < 50000"
              >
                <h4>{{ item.product.productInfo.deliveryFee | comma }}원</h4>
                <div>
                  <h5 style="font-weight: normal">50,000이상 무료배송</h5>
                </div>
              </div>

              <div align="end" style="padding: 33px 20px 0px 0px" v-else>
                <h5>무료배송</h5>
              </div>
            </v-layout>
          </v-card>
        </v-card>
      </v-container>

      <!-- 장바구니 상품 총 가격 표시 바 -->
      <v-container style="width: 900px">
        <v-checkbox
            type="checkbox"
            v-model="allSelected"
            label="전체선택"
        >

        </v-checkbox>
        <v-card style="height: 100px; border: 3px solid black" flat>
          <v-container style="width: 600px">
            <v-layout style="height: 100%; width: 100%; margin-top: 8px" justify-center>
              <div>
                <h5 style="font-weight: normal">상품금액</h5>
                <span style="font-size: 30px; font-weight: bold">
                  {{ this.totalProductPrice }}
                </span>
                <span>원</span>
              </div>
              <v-spacer></v-spacer>
              <h2 style="margin-top: 10px;">+</h2>
              <v-spacer></v-spacer>
              <div>
                <h5 style="font-weight: normal">배송비</h5>
                <div>
                  <span style="font-size: 30px; font-weight: bold">
                    {{ this.totalDeliveryFee }}
                  </span>
                  <span>원</span>
                </div>
              </div>
              <v-spacer></v-spacer>
              <h2 style="margin-top: 10px;">=</h2>
              <v-spacer></v-spacer>
              <div>
                <h5 style="font-weight: normal">총 금액</h5>
                <span style="font-size: 30px; font-weight: bold">
                  {{ this.totalPaymentAmount }}
                </span>
                <span>
                  원
                </span>
              </div>
            </v-layout>
          </v-container>
        </v-card>
        <!--구매하기 버튼-->
        <v-container style="width: 800px">
          <v-btn width="100%" height="40px" elevation="0" style="background-color: #2F4F4F; color: white"
                 :to="{name: 'OrderForm', params: {productInfo: this.selectList, productTotalPrice: this.totalProductPrice}}"
          >
            <h4>구매하기</h4>
          </v-btn>
        </v-container>
      </v-container>
    </v-container>
  </div>
</template>

<script>

import {mapState} from "vuex";

export default {
  name: "ShoppingCartForm",
  computed: {
    ...mapState([
        'shoppingBucketProductItemList',
    ]),
    allSelected: {
      get: function () {
        return this.shoppingBucketProductItemList.length === this.selectList.length
      },
      set: function (e){
        this.selectList = e ? this.shoppingBucketProductItemList : []
        for (let i = 0; i < this.selectList.length; i++) {
          this.totalProductPrice += this.selectList[i].product.price * this.selectList[i].itemCount
        }
      }
    }
  },
  data() {
    return {
      showMinusButtonValue: false,
      showPlusButtonValue: false,
      selectList: [],
      totalProductPrice: 0,
      totalDeliveryFee: 0,
      totalPaymentAmount: 0,
    }
  },
  methods: {
    selectProduct(price, itemCount){
      this.totalProductPrice += (price * itemCount)
    },
    async minusProductAmount(i) {
      this.shoppingBucketProductItemList[i].itemCount--

      if (this.shoppingBucketProductItemList[i].itemCount <= 1){
        this.showMinusButtonValue = true
      }

      if (this.shoppingBucketProductItemList[i].product.productInfo.stock > this.shoppingBucketProductItemList[i].itemCount){
        this.showPlusButtonValue = false
      }

    },
    async plusProductAmount(i) {
      this.shoppingBucketProductItemList[i].itemCount++

      if (this.shoppingBucketProductItemList[i].itemCount > 1){
        this.showMinusButtonValue = false
      }

      if (this.shoppingBucketProductItemList[i].product.productInfo.stock <= this.shoppingBucketProductItemList[i].itemCount){
        this.showPlusButtonValue = true
      }
    }
  },
  beforeUpdate() {
    this.totalProductPrice = 0
    this.totalDeliveryFee = 0
    this.totalPaymentAmount = 0

    for (let i = 0; i < this.selectList.length; i++) {
      this.totalProductPrice += this.selectList[i].product.price * this.selectList[i].itemCount

      if (this.selectList[i].product.price * this.selectList[i].itemCount >= 50000) {
        this.totalDeliveryFee += 0

      } else {
        this.totalDeliveryFee += this.selectList[i].product.productInfo.deliveryFee
      }
    }

    this.totalPaymentAmount = this.totalDeliveryFee + this.totalProductPrice
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
}
</script>

<style scoped>

</style>