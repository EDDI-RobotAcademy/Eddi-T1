<template>
  <div>
    <handmade-product-by-category-form :categoryName="categoryName"
                                       :productListByCategory="handmadeCategoryProduct"/>
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
    ])
  },
  data() {
    return {
      categoryName: "핸드메이드",
      lastProductNo: 0,
      productSize: 12,
      handmadeCategoryProduct: [],
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
                  this.handmadeCategoryProduct.push(this.mainPageNextProductList[i])
                }
                this.lastProductNo = this.handmadeCategoryProduct[this.handmadeCategoryProduct.length - 1].productNo
                $state.loaded()
              }, 1000);
            }
          });

      this.mainPageNextProductImgList.splice(0)
      for (let i = 0; i < this.mainPageNextProductList.length; i++) {
        let productNo = this.mainPageNextProductList[i].productNo

        await this.requestProductListImgNextPageByCategoryToSpring(productNo)
      }

      for (let i = 0; i < this.mainPageNextProductImgList.length; i++) {
        this.mainPageProductImgListByHandmade.push(this.mainPageNextProductImgList[i])
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
    this.handmadeCategoryProduct.splice(0)
    this.requestProductListByCategoryToSpring({category, productSize})
    for (let i = 0; i < this.mainPageProductListByHandmade.length; i++) {
      this.handmadeCategoryProduct.push(this.mainPageProductListByHandmade[i])
    }

    this.lastProductNo = this.handmadeCategoryProduct[this.handmadeCategoryProduct.length - 1].productNo
  },
}
</script>

<style scoped>

</style>