<template>
  <div>
    <hobby-product-by-category-form :categoryName="categoryName"
                                    :productListByCategory="hobbyCategoryProduct"/>
    <infinite-loading @infinite="infiniteHandler" spinner="waveDots">
      <div slot="no-more" v-show="false"></div>
      <div slot="no-results" v-show="false"></div>
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
      'hobbyProductRatingValue'
    ])
  },
  data() {
    return {
      categoryName: "취미/특기",
      lastProductNo: 0,
      productSize: 12,
      hobbyCategoryProduct: [],
    }
  },
  methods: {
    ...mapActions([
      'requestProductListByCategoryToSpring',
      'requestProductListNextPageByCategoryToSpring',
      'requestProductListImgNextPageByCategoryToSpring',
      'requestProductRatingValueToSpring'
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
    //스크롤 페이징작업
    async infiniteHandler($state) {
      await this.nextPageOnScroll($state)
    },
  },
  mounted() {
    const category = this.categoryName
    const productSize = this.productSize

    //상품 리스트 저장
    this.hobbyCategoryProduct.splice(0)
    this.requestProductListByCategoryToSpring({category, productSize})
    for (let i = 0; i < this.mainPageProductListByHobby.length; i++) {
      this.hobbyCategoryProduct.push(this.mainPageProductListByHobby[i])
    }

    this.lastProductNo = this.hobbyCategoryProduct[this.hobbyCategoryProduct.length - 1].productNo
  }
}
</script>

<style scoped>

</style>