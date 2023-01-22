<template>

  <div>
    <v-container style="width:1200px">
      <h2>{{ categoryName }}</h2>
      <v-layout justify-end>
        <div style="margin-top: 15px;">
          <h5 style="font-weight: normal; font-size: 14px">{{ this.filterType }}으로 조회...</h5>
        </div>
        <v-spacer></v-spacer>
        <v-btn-toggle borderless dense color="#2f4f4f">
          <v-btn
              v-for="(btn, index) in filterBtn" :key="index"
              elevation="0"
              color="white"

              @click="recentSortButton(index)"
          >
            <h4>{{ btn.name }}</h4>
          </v-btn>
        </v-btn-toggle>
      </v-layout>
    </v-container>

    <hobby-product-by-category-form :categoryName="categoryName"/>
    <infinite-loading @infinite="infiniteHandler" spinner="waveDots">
      <div slot="no-more" v-show="false"></div>
    </infinite-loading>

  </div>
</template>


<script>
import {mapActions, mapState} from "vuex";
import InfiniteLoading from "vue-infinite-loading";
import HobbyProductByCategoryForm from "@/components/productByCategory/HobbyProductByCategoryForm";

export default {
  name: "HobbyCategoryView",
  components: {HobbyProductByCategoryForm, InfiniteLoading},
  computed: {
    ...mapState([
      'mainPageProductImgListByHobby',
      'mainPageProductListByHobby',
      'mainPageNextProductList',
      'mainPageNextProductImgList',
      'hobbyProductRatingValue',
      'hobbyProductListByFilter',
      'filterType',
      'hobbyProductListByFilterLastLength'
    ])
  },
  data() {
    return {
      filterBtn: [
        {name: "최신순", btnCheck: false},
        {name: "인기순", btnCheck: false},
        {name: "후기순", btnCheck: false},
        {name: "높은 가격순", btnCheck: false},
        {name: "낮은 가격순", btnCheck: false},
      ],
      categoryName: "취미/특기",
      lastProductNo: 0,
      productSize: 12,
      productNoList: [],
      filter: "",
    }
  },
  methods: {
    ...mapActions([
      'requestProductListByCategoryToSpring',
      'requestProductListNextPageByCategoryToSpring',
      'requestProductListImgNextPageByCategoryToSpring',
      'requestProductRatingValueToSpring',
      'requestProductListByFilterFromSpring',
      'requestProductImgListToSpring',
      'saveFilterType'
    ]),

    async nextPageOnScroll($state) {
      for (let i = 0; i < this.hobbyProductListByFilter.length; i++) {
        this.productNoList.push(this.hobbyProductListByFilter[i].productNo)
      }
      for (let i = 0; i < this.hobbyProductListByFilter.length; i++) {
        this.lastProductNo = this.hobbyProductListByFilter[this.hobbyProductListByFilter.length - 1].productNo
      }
      const productNo = this.lastProductNo
      const category = this.categoryName
      const productSize = this.productSize
      if (this.filterType === "") {
        this.filter = "최신순"
      } else {
        this.filter = this.filterType
      }
      let filter = this.filter
      const productNoList = [...new Set(this.productNoList)]

      console.log(filter)

      console.log(productNoList)
      await this.requestProductListNextPageByCategoryToSpring({productNo, category, productSize, filter, productNoList})
          .then(() => {
            if (this.hobbyProductListByFilterLastLength === 0) {
              $state.complete()
            } else {
              setTimeout(() => {
                this.lastProductNo = this.hobbyProductListByFilter[this.hobbyProductListByFilter.length - 1].productNo
                $state.loaded()
              }, 2000);
            }
          });
    },
    //스크롤 페이징작업
    async infiniteHandler($state) {
      await this.nextPageOnScroll($state)
    },
    //상품 사진가져오는 로직
    getMainPageFilterProductImgByHobby() {

      const category = this.categoryName
      this.mainPageProductImgListByHobby.splice(0)
      // 핸드메이드 상품 받아오기
      for (let j = 0; j < this.hobbyProductListByFilter.length; j++) {
        let productNo = this.hobbyProductListByFilter[j].productNo;

        this.requestProductImgListToSpring({productNo, category});
      }
    },
    //필터 버튼 클릭시 실행
    async recentSortButton(index) {
      await history.go(0)
      const category = this.categoryName
      const productSize = this.productSize
      const filterType = this.filterBtn[index].name

      await this.saveFilterType(filterType)
      const filter = this.filterType

      this.hobbyProductRatingValue.splice(0)
      this.mainPageProductImgListByHobby.splice(0)
      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHobby()
      await this.getProductRatingValue()
    },
    //별점 가져오는 로직
    async getProductRatingValue() {
      const category = this.categoryName
      for (let i = 0; i < this.hobbyProductListByFilter.length; i++) {
        let productNo = this.hobbyProductListByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

  },
}
</script>

<style scoped>

</style>