<template>

  <div>

    <div
        align="end"
        style="margin-right:400px; margin-top:50px"

    >
      <v-btn
          elevation="0"
          color="white"
          @click="recentSortButton"
      >
        <div v-if="!recentSort">최신순</div>
        <div v-else style="font-weight: bolder">최신순</div>
      </v-btn>


      <v-btn
          elevation="0"
          color="white"
          @click="popularitySortButton">
        <div v-if="!popularitySort">인기순</div>
        <div v-else style="font-weight: bolder">인기순</div>
      </v-btn>


      <v-btn
          elevation="0"
          color="white"
          @click="reviewSortButton">
        <div v-if="!reviewSort">후기순</div>
        <div v-else style="font-weight: bolder">후기순</div>
      </v-btn>


      <v-btn
          elevation="0"
          color="white"
          @click="highPriceSortButton">
        <div v-if="!highPriceSort">높은 가격순</div>
        <div v-else style="font-weight: bolder">높은 가격순</div>
      </v-btn>


      <v-btn
          elevation="0"
          color="white"
          @click="lowPriceSortButton">
        <div v-if="!lowPriceSort">낮은 가격순</div>
        <div v-else style="font-weight: bolder">낮은 가격순</div>
      </v-btn>
    </div>

    <handmade-product-by-category-form :categoryName="categoryName"/>
    <infinite-loading @infinite="infiniteHandler" spinner="waveDots">
      <div slot="no-more" v-show="false"></div>
    </infinite-loading>
  </div>
</template>

<script>
import InfiniteLoading from "vue-infinite-loading"
import {mapActions, mapState} from "vuex";
import HandmadeProductByCategoryForm from "@/components/productByCategory/HandmadeProductByCategoryForm";

export default {
  name: "HandmadeCategoryView",
  components: {HandmadeProductByCategoryForm, InfiniteLoading},
  computed: {
    ...mapState([
      'mainPageProductListByHandmade',
      'mainPageNextProductList',
      'mainPageNextProductImgList',
      'mainPageProductImgListByHandmade',
      'handmadeProductRatingValue',
      'productListByFilter'
    ])
  },
  data() {
    return {
      categoryName: "핸드메이드",
      lastProductNo: 0,
      productSize: 12,
      filter: "최신순",
      recentSort: false,
      popularitySort: false,
      reviewSort: false,
      highPriceSort: false,
      lowPriceSort: false,
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
    ]),
    async nextPageOnScroll($state) {
      const productNo = this.lastProductNo
      const category = this.categoryName
      const productSize = this.productSize

      this.mainPageNextProductList.splice(0)
      await this.requestProductListNextPageByCategoryToSpring({productNo, category, productSize})
          .then(() => {
            if (this.mainPageNextProductList.length == 0) {
              $state.complete()
            } else {
              setTimeout(() => {
                for (let i = 0; i < this.mainPageNextProductList.length; i++) {
                  this.handmadeCategoryProduct.push(this.mainPageNextProductList[i])
                }
                this.lastProductNo = this.handmadeCategoryProduct[this.handmadeCategoryProduct.length - 1].productNo
                $state.loaded()
              }, 2000);
            }
          });

      this.mainPageNextProductImgList.splice(0)
      for (let i = 0; i < this.mainPageNextProductList.length; i++) {
        let productNo = this.mainPageNextProductList[i].productNo

        await this.requestProductListImgNextPageByCategoryToSpring(productNo)
        await this.requestProductRatingValueToSpring({productNo, category})
      }

      for (let i = 0; i < this.mainPageNextProductImgList.length; i++) {
        this.mainPageProductImgListByHandmade.push(this.mainPageNextProductImgList[i])
      }
    },

    //스크롤 페이징작업
    async infiniteHandler($state) {
      await this.nextPageOnScroll($state)
    },

    //최신순 버튼 클릭시 상품 재정렬됨.
    async recentSortButton() {
      this.recentSort = true;
      this.popularitySort = false;
      this.reviewSort = false;
      this.highPriceSort = false;
      this.lowPriceSort = false;

      const category = "핸드메이드";
      const productSize = 12;
      const filter = "최신순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter});

      await this.getMainPageFilterProductImgByHandmade()

      this.handmadeProductRatingValue.splice(0)
      for (let i = 0; i < this.productListByFilter.length; i++) {
        let productNo = this.productListByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

    //인기순 버튼 클릭시 상품 재정렬됨.
    async popularitySortButton() {

      this.recentSort = false;
      this.popularitySort = true;
      this.reviewSort = false;
      this.highPriceSort = false;
      this.lowPriceSort = false;

      const category = "핸드메이드";
      const productSize = 12;
      const filter = "인기순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHandmade()

      this.handmadeProductRatingValue.splice(0)
      for (let i = 0; i < this.productListByFilter.length; i++) {
        let productNo = this.productListByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

    //후기순 버튼 클릭시 상품 재정렬됨.
    async reviewSortButton() {
      this.recentSort = false;
      this.popularitySort = false;
      this.reviewSort = true;
      this.highPriceSort = false;
      this.lowPriceSort = false;

      const category = "핸드메이드";
      const productSize = 12;
      const filter = "후기순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHandmade()

      this.handmadeProductRatingValue.splice(0)
      for (let i = 0; i < this.productListByFilter.length; i++) {
        let productNo = this.productListByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

    async highPriceSortButton() {
      this.recentSort = false;
      this.popularitySort = false;
      this.reviewSort = false;
      this.highPriceSort = true;
      this.lowPriceSort = false;

      const category = "핸드메이드";
      const productSize = 12;
      const filter = "높은 가격순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHandmade()

      this.handmadeProductRatingValue.splice(0)
      for (let i = 0; i < this.productListByFilter.length; i++) {
        let productNo = this.productListByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

    async lowPriceSortButton() {
      this.recentSort = false;
      this.popularitySort = false;
      this.reviewSort = false;
      this.highPriceSort = false;
      this.lowPriceSort = true;

      const category = "핸드메이드";
      const productSize = 12;
      const filter = "낮은 가격순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHandmade()

      this.handmadeProductRatingValue.splice(0)
      for (let i = 0; i < this.productListByFilter.length; i++) {
        let productNo = this.productListByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

    getMainPageFilterProductImgByHandmade() {

      const category = this.categoryName
      this.mainPageProductImgListByHandmade.splice(0)
      // 핸드메이드 상품 받아오기
      for (let j = 0; j < this.productListByFilter.length; j++) {
        let productNo = this.productListByFilter[j].productNo;

        this.requestProductImgListToSpring({productNo, category});
      }
    },

  },

  async mounted() {
    const category = this.categoryName

    await this.recentSortButton()

    this.lastProductNo = this.productListByFilter[this.productListByFilter.length - 1].productNo

    this.handmadeProductRatingValue.splice(0)
    for (let i = 0; i < this.productListByFilter.length; i++) {
      let productNo = this.productListByFilter[i].productNo

      await this.requestProductRatingValueToSpring({productNo, category})
    }
  },
}
</script>

<style scoped>

</style>