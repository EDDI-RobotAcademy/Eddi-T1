<template>
  <div>
    <v-container style="width:1200px">
      <h2>{{ categoryName }}</h2>
      <v-layout justify-end>
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

    <know-how-product-by-category-form :categoryName="categoryName"/>
    <infinite-loading @infinite="infiniteHandler" spinner="waveDots">
      <div slot="no-more" v-show="false"></div>
      <div slot="no-results" v-show="false"></div>
    </infinite-loading>
  </div>

</template>

<script>
import {mapActions, mapState} from "vuex";
import KnowHowProductByCategoryForm from "@/components/productByCategory/KnowHowProductByCategoryForm";
import InfiniteLoading from "vue-infinite-loading";

export default {
  name: "KnowhowCategoryView",
  components: {KnowHowProductByCategoryForm, InfiniteLoading},
  computed: {
    ...mapState([
      'mainPageProductListByKnowHow',
      'mainPageProductImgListByKnowHOw',
      'mainPageNextProductList',
      'mainPageNextProductImgList',
      'knowhowProductRatingValue',
      'knowhowProductByFilter',
      'filterType',
      'knowhowProductListByFilterLastLength'
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
      categoryName: "노하우",
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
      for (let i = 0; i < this.knowhowProductByFilter.length; i++) {
        this.productNoList.push(this.knowhowProductByFilter[i].productNo)
      }
      for (let i = 0; i < this.knowhowProductByFilter.length; i++) {
        this.lastProductNo = this.knowhowProductByFilter[this.knowhowProductByFilter.length - 1].productNo
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
            if (this.knowhowProductListByFilterLastLength === 0) {
              $state.complete()
            } else {
              setTimeout(() => {
                this.lastProductNo = this.knowhowProductByFilter[this.knowhowProductByFilter.length - 1].productNo
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
    getMainPageFilterProductImgByKnowhow() {

      const category = this.categoryName
      this.mainPageProductImgListByKnowHOw.splice(0)
      //노하우 상품 받아오기
      for (let j = 0; j < this.knowhowProductByFilter.length; j++) {
        let productNo = this.knowhowProductByFilter[j].productNo;

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

      this.knowhowProductRatingValue.splice(0)
      this.mainPageProductImgListByKnowHOw.splice(0)
      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByKnowhow()
    },
    //별점 가져오는 로직
    async getProductRatingValue() {
      const category = this.categoryName
      for (let i = 0; i < this.knowhowProductByFilter.length; i++) {
        let productNo = this.knowhowProductByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },
  },
}
</script>

<style scoped>

</style>