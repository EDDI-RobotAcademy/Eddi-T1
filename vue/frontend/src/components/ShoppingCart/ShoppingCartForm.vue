<template>
  <div>
    <v-container style="width: 1000px">
      <div style="margin-top: 30px;">
        <h2>장바구니</h2>
      </div>
      <v-divider style="margin-top: 30px; margin-bottom: 30px;"></v-divider>

      <!-- 장바구니 상품 표시 카드 -->
      <v-container style="width: 900px" >
        <v-card style="border: 1px solid black; margin-top: 10px;"
                v-for="(item,index) in product" :key="index">
          <v-layout style="background-color: #2F4F4F">
            <v-checkbox style="margin-left: 30px;" color="#FAEBD7" dark v-model="productCheckValue"
                        @change="setTotalPrice"/>
            <!--<h4>{{item.sellerName}}</h4>-->
            <h4 style="margin-top: 20px; color: white">{{ item.sellerName }}</h4>
          </v-layout>

          <v-layout>
            <v-card max-width="100"
                    style="padding: 15px 15px 15px 15px"
                    flat>
<!--              <v-img-->
<!--                  height="75px"-->
<!--                  :src="require('@/assets/productImg/'+item.thumbnailImage)"-->
<!--              >-->
<!--              </v-img>-->
            </v-card>

            <v-card style="width: 100%;" flat>
              <v-layout style="margin-bottom: 30px;">
                <h4 style="margin-top: 40px; padding: 0px 0px 0px 20px">{{ item.productTitle }}</h4>
                <!--<h4>{{item.title}}</h4>-->

                <v-spacer></v-spacer>
                <v-layout style="margin-top: 40px" justify-end>

                  <div>
                    <v-btn small plain elevation="0" @click="minusProductAmount">
                      <h1>-</h1>
                    </v-btn>
                  </div>
                  <div>
                    <h3>{{ item.productAmount }}</h3>
                  </div>
                  <div>
                    <v-btn small plain elevation="0" @click="plusProductAmount">
                      <h1>+</h1>
                    </v-btn>
                  </div>

                  <div style="margin-top: 5px; margin-left: 30px;">
                    <h5>{{ item.productPrice | comma }}원</h5>
                  </div>

                  <div style=" padding: 0px 10px 0px 30px">
                    <v-btn
                        rounded
                        small
                        elevation="0"
                        style="background-color: #2F4F4F;
                        color: white; margin-left: 10px;">
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
                {{ item.totalProductPriceByAmount | comma }}원
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
              <div align="end" style="padding: 20px 20px 0px 0px">
                <h4>{{ item.deliveryFee | comma }}원</h4>
                <div>
                  <h5 style="font-weight: normal">50,000이상 무료배송</h5>
                </div>
              </div>
            </v-layout>
          </v-card>
        </v-card>
      </v-container>

      <!-- 장바구니 상품 총 가격 표시 바 -->
      <v-container style="width: 900px">
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

      </v-container>
    </v-container>
  </div>
</template>

<script>
import {mapActions} from "vuex";

export default {
  name: "ShoppingCartForm",
  data() {
    return {
      rules: {
        required: value => !!value || "필수 입력 사항입니다",
        min: v => v > 0 || `상품 구매 최소수량은 1개 입니다.`,
        max: v => v <= this.stock || `상품재고가 ${this.stock}개 남았습니다`
      },
      productCheckValue: false,
      stock: 10,
      productPrice1: 0,
      deliveryFee: 0,
      totalProductPrice: 0,
      totalDeliveryFee: 0,
      totalPaymentAmount: 0,
      product: [
        {
          sellerName: "예시1",
          productTitle: "예시1",
          productAmount: 1,
          productPrice: 50000,
          deliveryFee: 3000,
          totalProductPriceByAmount: 0,
          thumbnailImage: ''
        },
        {
          sellerName: "예시2",
          productTitle: "예시2",
          productAmount: 1,
          productPrice: 30000,
          deliveryFee: 3000,
          totalProductPriceByAmount: 0,
          thumbnailImage: ''
        }
      ],
      testProduct: []
    }
  },
  methods: {
    ...mapActions([
      'requestShoppingBucketItemListToSpring',
      'requestShoppingBucketItemImgToSpring'
    ]),
    freeDeliveryFee() {
      this.product[0].deliveryFee = 0
      this.totalDeliveryFee = 0
    },
    notFreeDeliveryFee() {
      this.product[0].deliveryFee = 3000
    },
    setTotalPrice() {
      if (this.productCheckValue == true) {
        this.totalProductPrice += this.product[0].totalProductPriceByAmount
        this.totalDeliveryFee += this.product[0].deliveryFee
        this.totalPaymentAmount = this.totalProductPrice + this.totalDeliveryFee

      } else if (this.productCheckValue == false) {
        this.totalProductPrice -= this.product[0].totalProductPriceByAmount
        this.totalDeliveryFee -= this.product[0].deliveryFee
        this.totalPaymentAmount = this.totalProductPrice + this.totalDeliveryFee
      }
    },
    async minusProductAmount() {
      this.product[0].productAmount--

      this.product[0].totalProductPriceByAmount -= this.product[0].productPrice

      if (this.product[0].productAmount <= 0) {
        alert("더이상 낮은 수량은 입력할 수 없습니다.")
        this.product[0].productAmount = 0
        this.product[0].totalProductPriceByAmount = 0
      }

      if (this.product[0].totalProductPriceByAmount < 50000) {
        await this.notFreeDeliveryFee()
      }
    },
    async plusProductAmount() {
      this.product[0].productAmount++

      if (this.product[0].productAmount > this.stock) {
        alert("재고보다 더 많은 수량을 입력할 수 없습니다.")
        this.product[0].productAmount = this.stock
      }

      this.product[0].totalProductPriceByAmount += this.product[0].productPrice;
    }
  },

  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
  async created() {
    const memberToken = this.$store.state.userToken
    // this.product[0].totalProductPriceByAmount = this.product[0].productPrice

    await this.requestShoppingBucketItemListToSpring(memberToken)
    this.testProduct = new Array(this.$store.state.shoppingBucketProductItemList.length)

    console.log(this.testProduct)

    this.testProduct.push(this.$store.state.shoppingBucketProductItemList[0])
    this.testProduct.push(this.$store.state.shoppingBucketProductItemList[1])

    console.log(this.testProduct[2].product)

  },
  async mounted() {
    this.productNo = this.$store.state.shoppingBucketProductItemList[0].product.productNo

    await this.requestShoppingBucketItemImgToSpring(this.productNo)

  },
  beforeUpdate() {
    if (this.product[0].totalProductPriceByAmount >= 50000) {
       this.freeDeliveryFee()
    }
  }
}
</script>

<style scoped>
.puple-input >>> .error--text {
  color: #2F4F4F !important;
}
</style>