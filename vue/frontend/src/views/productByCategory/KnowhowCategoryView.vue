<template>
  <div>
    <v-container style="width:1200px">
    <h2>{{ categoryName }}</h2>
    <div
        align="end"
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

    </v-container>

    <know-how-product-by-category-form :categoryName="categoryName"/>
    <infinite-loading @infinite="infiniteHandler" spinner="waveDots">
      <div slot="no-more" v-show="false"></div>
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
      'productListByFilter'
    ])
  },
  data() {
    return {
      categoryName: "노하우",
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
                  this.knowHowCategoryProduct.push(this.mainPageNextProductList[i])
                }
                this.lastProductNo = this.knowHowCategoryProduct[this.knowHowCategoryProduct.length - 1].productNo
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
        this.mainPageProductImgListByKnowHOw.push(this.mainPageNextProductImgList[i])
      }
    },
    //스크롤 페이징작업
    async infiniteHandler($state) {
      await this.nextPageOnScroll($state)
    },

    async recentSortButton() {
      this.recentSort = true;
      this.popularitySort = false;
      this.reviewSort = false;
      this.highPriceSort = false;
      this.lowPriceSort = false;

      const category = "노하우";
      const productSize = 12;
      const filter = "최신순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter});

      await this.getMainPageFilterProductImgByKnowhow()

      this.knowhowProductRatingValue.splice(0)
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

      const category = "노하우";
      const productSize = 12;
      const filter = "인기순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByKnowhow()

      this.knowhowProductRatingValue.splice(0)
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

      const category = "노하우";
      const productSize = 12;
      const filter = "후기순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByKnowhow()

      this.knowhowProductRatingValue.splice(0)
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

      const category = "노하우";
      const productSize = 12;
      const filter = "높은 가격순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByKnowhow()

      this.knowhowProductRatingValue.splice(0)
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

      const category = "노하우";
      const productSize = 12;
      const filter = "낮은 가격순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByKnowhow()

      this.knowhowProductRatingValue.splice(0)
      for (let i = 0; i < this.productListByFilter.length; i++) {
        let productNo = this.productListByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

    getMainPageFilterProductImgByKnowhow() {

      const category = this.categoryName
      this.mainPageProductImgListByKnowHOw.splice(0)
      //취미 상품 받아오기
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

    this.knowhowProductRatingValue.splice(0)
    for (let i = 0; i < this.productListByFilter.length; i++) {
      let productNo = this.productListByFilter[i].productNo

      await this.requestProductRatingValueToSpring({productNo, category})
    }
  }
}
</script>

<style scoped>

</style>