<template>
  <product-by-category-form :categoryName="categoryName"
                            :productListByCategory="mainPageProductListByHobby"
                            :productThumbnailListByCategory="mainPageProductImgListByHobby"
  />
</template>

<script>
import ProductByCategoryForm from "@/components/productByCategory/ProductByCategoryForm";
import {mapActions, mapState} from "vuex";
export default {
  name: "HobbyCategoryView",
  components: {ProductByCategoryForm},
  computed:{
    ...mapState([
        'mainPageProductImgListByHobby',
        'mainPageProductListByHobby'
    ])
  },
  data(){
    return{
      categoryName: "취미/특기"
    }
  },
  methods:{
    ...mapActions([
      'requestProductImgListToSpring',
      'requestProductListByCategoryToSpring'
    ]),
    async getMainPageProductImgByHobby() {

      const category = this.categoryName
      this.mainPageProductImgListByHobby.splice(0)
      // 취미/특기 상품 받아오기
      for (let j = 0; j < this.mainPageProductListByHobby.length; j++) {
        let productNo = this.mainPageProductListByHobby[j].productNo;

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