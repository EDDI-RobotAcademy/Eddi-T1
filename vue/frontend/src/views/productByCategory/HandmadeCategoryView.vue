<template>
  <product-by-category-form :categoryName="categoryName"
                            :productListByCategory="mainPageProductListByHandmade"
                            :productThumbnailListByCategory="mainPageProductImgListByHandmade"
  />
</template>

<script>
import ProductByCategoryForm from "@/components/productByCategory/ProductByCategoryForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "HandmadeCategoryView",
  components: {ProductByCategoryForm},
  computed: {
    ...mapState([
      'mainPageProductListByHandmade',
      'mainPageProductImgListByHandmade'
    ])
  },
  data() {
    return {
      categoryName: "핸드메이드"
    }
  },
  methods: {
    ...mapActions([
      'requestProductImgListToSpring',
      'requestProductListByCategoryToSpring'
    ]),
    async getMainPageProductImgByHandmade() {

      const category = this.categoryName
      this.mainPageProductImgListByHandmade.splice(0)
      // 핸드메이드 상품 받아오기
      for (let j = 0; j < this.mainPageProductListByHandmade.length; j++) {
        let productNo = this.mainPageProductListByHandmade[j].productNo;

        await this.requestProductImgListToSpring({productNo, category});
      }
    },
  },
  async mounted() {
    const category = this.categoryName
    const productSize = 20
    await this.requestProductListByCategoryToSpring({category, productSize})

    await this.getMainPageProductImgByHandmade()
  },
}
</script>

<style scoped>

</style>