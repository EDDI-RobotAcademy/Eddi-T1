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
      'productListByFilter'
    ])
  },
  data() {
    return {
      categoryName: "취미/특기",
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

    async recentSortButton() {
      this.recentSort = true;
      this.popularitySort = false;
      this.reviewSort = false;
      this.highPriceSort = false;
      this.lowPriceSort = false;

      const category = "취미/특기";
      const productSize = 12;
      const filter = "최신순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter});

      await this.getMainPageFilterProductImgByHobby()

      this.hobbyProductRatingValue.splice(0)
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

      const category = "취미/특기";
      const productSize = 12;
      const filter = "인기순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHobby()

      this.hobbyProductRatingValue.splice(0)
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

      const category = "취미/특기";
      const productSize = 12;
      const filter = "후기순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHobby()

      this.hobbyProductRatingValue.splice(0)
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

      const category = "취미/특기";
      const productSize = 12;
      const filter = "높은 가격순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHobby()

      this.hobbyProductRatingValue.splice(0)
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

      const category = "취미/특기";
      const productSize = 12;
      const filter = "낮은 가격순"

      await this.requestProductListByFilterFromSpring({category, productSize, filter})
      await this.getMainPageFilterProductImgByHobby()

      this.hobbyProductRatingValue.splice(0)
      for (let i = 0; i < this.productListByFilter.length; i++) {
        let productNo = this.productListByFilter[i].productNo

        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

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
                  this.hobbyCategoryProduct.push(this.mainPageNextProductList[i])
                }
                this.lastProductNo = this.hobbyCategoryProduct[this.hobbyCategoryProduct.length - 1].productNo
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
        this.mainPageProductImgListByHobby.push(this.mainPageNextProductImgList[i])
      }
    },


    getMainPageFilterProductImgByHobby() {

      const category = this.categoryName
      this.mainPageProductImgListByHobby.splice(0)
      //취미 상품 받아오기
      for (let j = 0; j < this.productListByFilter.length; j++) {
        let productNo = this.productListByFilter[j].productNo;

        this.requestProductImgListToSpring({productNo, category});
      }
    },

    //스크롤 페이징작업
    async infiniteHandler($state) {
      await this.nextPageOnScroll($state)
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
  }
}
</script>

<style scoped>

</style>