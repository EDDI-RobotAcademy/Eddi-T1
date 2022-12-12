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
    <div v-for="(category, index) in categoryRelated" :key="index">
      <category-form :categoryName="category.name" :category-page="category.url" :categoryItems="category.item"/>
    </div>
  </div>
</template>

<script>
import CategoryForm from "@/components/category/CategoryForm";


export default {
  name: "MainPageForm",
  components: {CategoryForm},
  data() {
    return {
      imgItems: [
        {path: 'advertisement1.jpg'},
        {path: 'advertisement2.jpg'},
        {path: 'advertisement3.jpg'},
      ],
      categoryRelated:[
        {name: "핸드메이드", url: "/hand-made", item: [
            {commodityTitle: '핸드메이드1', sellerNickname: '판매자6', contents: '뭐 이런저런 물건 팔고있어요', img: '상품이미지1.jpg',categoryType: '핸드메이드'},
            {commodityTitle: '핸드메이드2', sellerNickname: '판매자6', contents: '뭐 이런저런 물건 팔고있어요', img: '상품이미지2.jpg',categoryType: '핸드메이드'},
            {commodityTitle: '핸드메이드3', sellerNickname: '판매자6', contents: '뭐 이런저런 물건 팔고있어요', img: '상품이미지3.jpg',categoryType: '핸드메이드'},
            {commodityTitle: '핸드메이드4', sellerNickname: '판매자6', contents: '뭐 이런저런 물건 팔고있어요', img: '상품이미지4.jpg',categoryType: '핸드메이드'},
            {commodityTitle: '핸드메이드5', sellerNickname: '판매자6', contents: '뭐 이런저런 물건 팔고있어요', img: '상품이미지5.jpg',categoryType: '핸드메이드'},
          ]},
        {name: "노하우", url: "/know-how", item: [
            {commodityTitle: '노하우1', sellerNickname: '판매자7', contents: '뭐 이런저런 물건 팔고있어요', img: '노하우이미지1.jpg',categoryType: '노하우'},
            {commodityTitle: '노하우2', sellerNickname: '판매자8', contents: '뭐 이런저런 물건 팔고있어요', img: '노하우이미지2.jpg',categoryType: '노하우'},
            {commodityTitle: '노하우3', sellerNickname: '판매자9', contents: '뭐 이런저런 물건 팔고있어요', img: '노하우이미지3.jpg',categoryType: '노하우'},
            {commodityTitle: '노하우4', sellerNickname: '판매자10', contents: '뭐 이런저런 물건 팔고있어요', img: '노하우이미지4.jpg',categoryType: '노하우'},
            {commodityTitle: '노하우5', sellerNickname: '판매자10', contents: '뭐 이런저런 물건 팔고있어요', img: '노하우이미지5.jpg',categoryType: '노하우'},
          ]},
        {name: "취미/특기", url: "/hobby", item: [
            {commodityTitle: '취미1', sellerNickname: '판매자1', contents: '재봉틀 수업', img: '취미이미지1.jpg' ,categoryType: '취미/특기'},
            {commodityTitle: '취미2', sellerNickname: '판매자2', contents: '십자수 수업', img: '취미이미지2.jpg',categoryType: '취미/특기'},
            {commodityTitle: '취미3', sellerNickname: '판매자3', contents: '에그타르트 만들기', img: '취미이미지3.jpg',categoryType: '취미/특기'},
            {commodityTitle: '취미4', sellerNickname: '판매자4', contents: '머랭쿠키 만들기', img: '취미이미지4.jpg',categoryType: '취미/특기'},
            {commodityTitle: '취미5', sellerNickname: '판매자5', contents: '악세서리 공방', img: '취미이미지5.jpg',categoryType: '취미/특기'},
          ]}
      ],
    }
  },
}
</script>

<style scoped>

</style>