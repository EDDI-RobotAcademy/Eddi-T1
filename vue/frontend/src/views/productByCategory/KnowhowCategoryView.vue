<template>
  <product-by-category-form :categoryName="categoryName"
                            :productListByCategory="mainPageProductListByKnowHow"
                            :productThumbnailListByCategory="mainPageProductImgListByKnowHOw"
  />
</template>

<script>
import ProductByCategoryForm from "@/components/productByCategory/ProductByCategoryForm";
import {mapActions, mapState} from "vuex";
export default {
  name: "KnowhowCategoryView",
  components: {ProductByCategoryForm},
  computed:{
    ...mapState([
        'mainPageProductListByKnowHow',
        'mainPageProductImgListByKnowHOw'
    ])
  },
  data(){
    return{
      categoryName: "노하우"
    }
  },
  methods:{
    ...mapActions([
      'requestProductImgListToSpring',
      'requestProductListByCategoryToSpring'
    ]),
    async getMainPageProductImgByHobby() {

      const category = this.categoryName
      this.mainPageProductImgListByKnowHOw.splice(0)
      // 취미/특기 상품 받아오기
      for (let j = 0; j < this.mainPageProductListByKnowHow.length; j++) {
        let productNo = this.mainPageProductListByKnowHow[j].productNo;

        await this.requestProductImgListToSpring({productNo, category});
      }
    },
  },
  async mounted() {
    const category = this.categoryName
    const productSize = 20
    await this.requestProductListByCategoryToSpring({category, productSize})

    await this.getMainPageProductImgByHobby()
  }
}
</script>

<style scoped>

</style>