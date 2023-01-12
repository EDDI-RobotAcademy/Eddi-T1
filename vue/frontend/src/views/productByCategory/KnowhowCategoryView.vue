<template>
  <div>
    <know-how-product-by-category-form :categoryName="categoryName"
                                       :productListByCategory="mainPageProductListByKnowHow"/>
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
    ])
  },
  data() {
    return {
      categoryName: "노하우",
      lastProductNo: 0,
      productSize: 12,
      knowHowCategoryProduct: [],
    }
  },
  methods: {
    ...mapActions([
      'requestProductListByCategoryToSpring',
      'requestProductListNextPageByCategoryToSpring',
      'requestProductListImgNextPageByCategoryToSpring'
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
      }

      for (let i = 0; i < this.mainPageNextProductImgList.length; i++) {
        this.mainPageProductImgListByKnowHOw.push(this.mainPageNextProductImgList[i])
      }
    },
    //스크롤 페이징작업
    async infiniteHandler($state) {
      await this.nextPageOnScroll($state)
    },
  },
  mounted() {
    const category = this.categoryName
    const productSize = this.productSize

    //상품 리스트 저장
    this.knowHowCategoryProduct.splice(0)
    this.requestProductListByCategoryToSpring({category, productSize})
    for (let i = 0; i < this.mainPageProductListByKnowHow.length; i++) {
      this.knowHowCategoryProduct.push(this.mainPageProductListByKnowHow[i])
    }
    this.lastProductNo = this.knowHowCategoryProduct[this.knowHowCategoryProduct.length - 1].productNo
  }
}
</script>

<style scoped>

</style>