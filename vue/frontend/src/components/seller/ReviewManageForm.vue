<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="80" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Review Manage
      </v-toolbar-title>
    </v-app-bar>


      <h2>{{ nickname }} 님의 판매상품에 달린 후기</h2><br/>


    <v-simple-table dense>
      <template v-slot:default>
        <thead>
        <tr>
          <th class="text-left">
            Image
          </th>
          <th class="text-left">
            Product Name
          </th>
          <th class="text-left">
            Review Title
          </th>
          <th class="text-left">
            Review Main
          </th>
          <th class="text-left">
            Writer
          </th>
          <th class="text-left">
            Date
          </th>
          <th class="text-left">
            Grade
          </th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td> <img :src="require('@/assets/fire.png')" width="70"></td>
          <td>{{reviews.at(0).name }}</td>
          <td>{{ reviews.at(0).title }}</td>
          <td>{{ reviews.at(0).main }}</td>
          <td>{{ reviews.at(0).writer }}</td>
          <td>{{ reviews.at(0).date }}</td>
          <td>  <div class="text-center">
            <v-rating
                v-model="rating"
                icon-label="custom icon label text {0} of {1}"
            ></v-rating>
          </div></td>
        </tr>
        <tr>
          <td> <img :src="require('@/assets/water.png')" width="70"></td>
          <td>{{reviews.at(1).name }}</td>
          <td>{{ reviews.at(1).title }}</td>
          <td>{{ reviews.at(1).main }}</td>
          <td>{{ reviews.at(1).writer }}</td>
          <td>{{ reviews.at(1).date }}</td>
          <td>  <div class="text-center">
            <v-rating
                v-model="rating"
                icon-label="custom icon label text {0} of {1}"
            ></v-rating>
          </div></td>
        </tr>
        <tr>
          <td> <img :src="require('@/assets/thunder.png')" width="70"></td>
          <td>{{reviews.at(2).name }}</td>
          <td>{{ reviews.at(2).title }}</td>
          <td>{{ reviews.at(2).main }}</td>
          <td>{{ reviews.at(2).writer }}</td>
          <td>{{ reviews.at(2).date }}</td>
          <td>  <div class="text-center">
            <v-rating
                v-model="rating"
                icon-label="custom icon label text {0} of {1}"
            ></v-rating>
          </div></td>
        </tr>
        </tbody>
      </template>
    </v-simple-table>





  </v-container>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";
export default {
  name: "ReviewManageForm",
  components: {SellerNavi},
  data () {
    return {
      nickname : this.$store.state.memberInfoAfterSignIn.nickname,
      Seller: "재범티비",

      headers: [
        { text: "Image", value: "image", sortable: false },
        { text: "Product Name", value: "name", sortable: false },
        { text: "Review Title", value: "title", sortable: false },
        { text: "Review Main", value: "main", sortable: false },
        { text: "Writer", value: "writer", sortable: false },
        { text: "Date", value: "date", sortable: false },
        { text: "Grade", value: "grade", sortable: false },
      ],

      reviews: [
        {
          image: '리자몽 이미지',
          name: "리자몽",
          title: "아이가 좋아하네요",
          main: "아이에게 좋은 선물이 되었어요! 항상 잘 이용하고 있습니다 바이디어 사랑해요~",
          writer: "ljb8194",
          date: "2022-12-27",
          grade: 5
        },
        {
          image: '리자몽 이미지',
          name: "갸라도스",
          title: "등껍질이 부실하네요",
          main: "아이가 몇 번 가지고 놀더니 똑하고 부러졌네요",
          writer: "jb8194",
          date: "2022-12-26",
          grade: 3
        },
        {
          image: '리자몽 이미지',
          name: "피카츄",
          title: "크리스마스 선물로 딱!",
          main: "덕분에 크리스마스 선물 걱정을 덜었네요! 고마워요 바이디어!",
          writer: "woqja8194",
          date: "2022-12-25",
          grade: 5
        },


      ],

    }
  },

}
</script>

<style scoped>
h2 { text-align: center; }
</style>