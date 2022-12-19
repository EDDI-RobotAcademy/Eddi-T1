<template>
  <v-container>
    <form @submit.prevent="onSubmit">


      <div id="content">

        <!--뒤로가기-->
<!--        <template>
          <div class="col-md-5 col-sm-5 col-xs-12">
          <v-icon v-on="on" large color="#2F4F4F" @click="goBack()">mdi-chevron-left</v-icon>
          </div>
        </template>-->

      <table>
        <div class="row">
          <div class="col-md-5 col-sm-5 col-xs-12">

            <div>
              <v-img contain width="440px" height="380px"
                     :src="productImgs[this.imgIdx]"></v-img>
            </div>

            <template>
                <v-tabs width="400" height="100"
                        show-arrows background-color="transparent"
                        v-model="tab2"
                >
                  <v-tab @click="selectedImg(index)"
                      v-for="(item, index) in productImgs"
                      :key="index"
                  >

                    <v-card width="80px" height="80px">
                      <div class="image-box">
                        <v-img :src="item"></v-img>
                      </div>
                    </v-card>
                  </v-tab>
                </v-tabs>
            </template>
          </div>


        <div class="col-md-6 col-sm-7 col-xs-12">
            <div style="margin: 0 0 50px 50px">
            <div class="pl-6">

              <!--상호프로필이미지-->
              <h5>
                <v-avatar
                  :size="23"
                  color="grey lighten-4"
              >
                <img src="@/assets/default_profile_image.png" alt="avatar">
              </v-avatar>

                <!--상호명-->
                {{ writer }}</h5>


              <!--상품명-->
              <h2 class="display-1 mb-0">{{title}}</h2>

              <!--가격-->
              <v-card-actions class="pa-0">
                <p class="headline font-weight-light pt-3"> {{ price | comma }}원</p>
                <v-spacer></v-spacer>
              </v-card-actions>


              <!--카테고리-->
              <v-col>
                <v-row>
                  <p class="title">CATEGORY</p>
                  <col class="col-sm-2 mr-3">
                  <p class="subTitle">{{ category }}</p>
                </v-row>
              </v-col>

              <!--별점 / 리뷰 수-->
              <v-col>
                <v-row>
                  <p class="title">REVIEW</p>
                  <col class="col-sm-3 mr-0">

                  <v-rating
                    :value="reviewSumAvg"
                    background-color="orange lighten-3"
                    color="orange"
                    small dense hover readonly>
                  </v-rating>

                  <div>({{ reviewNum }})</div>
                </v-row>
              </v-col>

              <!--배송비-->
              <v-col>
                <v-row>
                  <p class="title">DELIVERYFEE</p>
                  <col class="col-sm-1 mr-7">
                  <p class="subTitle">{{ deliveryFee | comma }}원</p>
                </v-row>
              </v-col>

              <!--개수-->
              <v-col>
                <v-row>
                  <p class="title">ITEMS</p>
                  <!--재고상태표시-->
                  <div class="stockInfo">
                    <span class="green" style="padding: 5px" v-if="stock > 10"> For Sale </span>
                    <span class="amber" style="padding: 5px" v-else-if="stock <= 10 && stock > 0"> Only Few Left </span>
                    <span class="grey" style="padding: 5px" v-else>SOLD OUT</span>
                  </div>
                  <col class="col-sm-2">
                  <!--선택한상품개수-->
                  <v-text-field
                      class="puple-input"
                      type="number"
                      outlined color="grey darken-5"
                      dense
                      v-model="quantity"
                      :rules="[rules.min, rules.max]"
                  ></v-text-field>
                </v-row>
              </v-col>

              <!--총 가격-->
              <v-col>
                <v-row>
                  <p class="title">TOTAL PRICE</p>
                  <col class="col-sm-2">
                  <p class="subTitle">{{ totalPrice | comma }}원</p>
                </v-row>
              </v-col>

            </div>

            <!--장바구니 / 바로구매 버튼-->
            <v-row>
              <v-col cols="6" align="center">
                <v-btn
                    @click="btnCart"
                    :disabled="stock <= 0"
                    block x-large
                    class="bt1"
                    color="#DAA520"
                    style="color: white" tile
                >장바구니</v-btn>

              </v-col>
              <v-col cols="6" align="center">
                <v-btn @click="btnPurchase" :disabled="stock <= 0" block x-large class="bt1" color="#2F4F4F" style="color: white" tile >바로구매</v-btn>
              </v-col>
            </v-row>

          </div>
        </div>

      </div>



      </table>
      </div>
    </form>
  </v-container>
</template>

<script>

export default {
  name: "ProductReadForm",
  data() {
    return {
      imgIdx: 0,
      tab2 : null,

      writer:'[성분맛집]천연화장품_드레싱테이블',
      title:'라벤더 진정밤 멀티밤 3.5g☞ 트러블에 정말 좋아요~',
      category: "핸드메이드",
      content:'',
      information:'',
      price: 20000,
      reviewSumAvg: 4,
      reviewNum: 40,
      deliveryFee: 3000,
      totalPrice: 0,
      stock: 11,
      quantity: 1,

      productImgs: [
        require('@/assets/productImg/상품이미지1.jpg'),
        require('@/assets/productImg/취미이미지1.jpg'),
        require('@/assets/productImg/상품이미지2.jpg'),
        require('@/assets/productImg/상품이미지3.jpg'),
        require('@/assets/productImg/취미이미지2.jpg'),
        require('@/assets/productImg/취미이미지4.jpg'),
        require('@/assets/productImg/취미이미지5.jpg'),
        require('@/assets/productImg/상품이미지4.jpg'),
        require('@/assets/productImg/상품이미지5.jpg'),
        require('@/assets/productImg/취미이미지3.jpg'),
      ],

      rules: {
        required: value => !!value || "필수 입력 사항입니다",
        min: v => v > 0 || `상품 구매 최소수량은 1개 입니다.`,
        max: v => v <= this.stock || `상품재고가 ${this.stock}개 남았습니다`
      }
    }
  },

  /*
  * 숫자 콤마
  * */
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },

  //별점
  /*computed: {
    reviewSumAvg() {
      let sum = 0;
      let avg = 0;
      if (this.reviewList.length != 0) {
        for (let i = 0; i < this.reviewList.length; i++) {
          sum = sum + this.reviewList[i].reviewRating;
        }
        avg = sum / this.reviewList.length;
        console.log("평균" + avg);
        return Number(avg.toFixed(2));
      }
      return Number(avg);
    },
  },
*/

  methods: {
    selectedImg(e) {
      this.imgIdx = e
      console.log(this.imgIdx)
    },
    btnCart() {
      // 장바구니에 상품 추가
      this.$router.push({name:''})
    },
    btnPurchase() {
      // 구매 페이지로 이동
      this.$router.push({name:''})
    },
    goBack() {
      this.$router.go(-1);
    },
    onSubmit () {

    },
  }
}
</script>

<style scoped>
table {
  margin-top: 10px;
  width: 100%;
}
#content{
  display: block;
  margin-top: 72px;
  margin: 30px;
  border: 0px;
  width: 1200px;
  margin: 0 auto;
  padding: 40px;
  line-height: 24px;
  background: #fff;
  margin-bottom: 50px;
}
td {
  border: 1px solid lightgray;
  width: 100px;
  height: 100px;
  text-align: center;
}
span {
  position: relative;
  left: 22%;
  bottom: 22px;
  font-size: 12px;
}
.img {
  width: 100%;
}
.bt1 {
  left: 20px;
  /*right: 20px;*/
}
.subTitle{
  float: left;
}
.stockInfo{
  margin-top: 26px;
}
.col-sm-3{
  left:20px;
}
.detail {
  border: 1px solid #e9ecef;
}
.v-tab {
  padding: 0;
  position:relative;
}
.itemTable {
  width: 50%;
  height: 100%;
  background-color: #f6f6f6;
  padding: 10px;
}

.puple-input >>> .error--text {
  color: #2F4F4F !important;
}
</style>