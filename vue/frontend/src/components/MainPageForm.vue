<template>
  <div>
    <v-carousel
        hide-delimiters
        cycle
        show-arrows-on-hover
    >
      <v-carousel-item
          v-for="(item,i) in imgItems"
          :key="i"
          :src="require('@/assets/'+item.path)"
      >
      </v-carousel-item>
    </v-carousel>
    <category-form/>
  </div>
</template>

<script>
import CategoryForm from "@/components/category/CategoryForm";
import {mapActions, mapState} from "vuex";

export default {
  name: "MainPageForm",
  components: {CategoryForm},
  computed: {
    ...mapState([
      'mainPageProductListByHandmade',
      'mainPageProductListByKnowHow',
      'mainPageProductListByHobby',
      'mainPageProductImgListByHandmade',
      'mainPageProductImgListByKnowHOw',
      'mainPageProductImgListByHobby',
      'handmadeProductRatingValue',
      'knowhowProductRatingValue',
      'hobbyProductRatingValue'
    ])
  },
  data() {
    return {
      imgItems: [
        {path: 'advertisement1.jpg'},
        {path: 'advertisement2.jpg'},
        {path: 'advertisement3.jpg'},
      ],
      mainPageHandmadeProductImgArr: [],
      mainPageHobbyProductImgArr: [],
      mainPageKnowHowProductImgArr: []

    }
  },
  methods: {
    ...mapActions([
      'requestProductListByCategoryToSpring',
      'requestProductImgListToSpring',
      'requestProductRatingValueToSpring'
    ]),
    async getMainPageProductImgByHandmade() {
      this.handmadeProductRatingValue.splice(0)
      let category = "핸드메이드"
      // 핸드메이드 상품 받아오기
      for (let j = 0; j < this.mainPageProductListByHandmade.length; j++) {
        let productNo = this.mainPageProductListByHandmade[j].productNo;

        await this.requestProductImgListToSpring({productNo, category});
        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

    async getMainPageProductImgByKnowHow() {
      this.knowhowProductRatingValue.splice(0)
      //노하우 상품 이미지 받아오기
      let category = '노하우'

      for (let j = 0; j < this.mainPageProductListByKnowHow.length; j++) {
        let productNo = this.mainPageProductListByKnowHow[j].productNo;

        await this.requestProductImgListToSpring({productNo, category});
        await this.requestProductRatingValueToSpring({productNo, category})
      }
    },

    async getMainPageProductImgByHobby() {
      this.hobbyProductRatingValue.splice(0)
      // 취미/특기 상품 받아오기
      let category = "취미/특기"

      for (let j = 0; j < this.mainPageProductListByHobby.length; j++) {
        let productNo = this.mainPageProductListByHobby[j].productNo

        await this.requestProductImgListToSpring({productNo, category})
        await this.requestProductRatingValueToSpring({productNo, category})
      }
    }
  },
  async mounted() {
    const categoryArr = ['핸드메이드', '노하우', '취미/특기']
    const productSize = 8

    for (let i = 0; i < categoryArr.length; i++) {
      let category = categoryArr[i]
      await this.requestProductListByCategoryToSpring({category, productSize})
    }

    await this.getMainPageProductImgByHandmade();
    await this.getMainPageProductImgByHobby()
    await this.getMainPageProductImgByKnowHow()
  },
}
</script>

<style scoped>

</style>