<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="80" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        π Review Manage
      </v-toolbar-title>
    </v-app-bar>


      <h2>{{ nickname }} λμ νλ§€μνμ λ¬λ¦° νκΈ°</h2><br/>


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
                :value="4.5"
                color="amber"
                dense
                half-increments
                readonly
                size="14"
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
                :value="3.0"
                color="amber"
                dense
                half-increments
                readonly
                size="14"
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
                :value="5.0"
                color="amber"
                dense
                half-increments
                readonly
                size="14"
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
      Seller: "μ¬λ²ν°λΉ",

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
          image: 'λ¦¬μλͺ½ μ΄λ―Έμ§',
          name: "λ¦¬μλͺ½",
          title: "μμ΄κ° μ’μνλ€μ",
          main: "μμ΄μκ² μ’μ μ λ¬Όμ΄ λμμ΄μ! ν­μ μ μ΄μ©νκ³  μμ΅λλ€ λ°μ΄λμ΄ μ¬λν΄μ~",
          writer: "ljb8194",
          date: "2022-12-27",
          grade: 5
        },
        {
          image: 'λ¦¬μλͺ½ μ΄λ―Έμ§',
          name: "κ°ΈλΌλμ€",
          title: "λ±κ»μ§μ΄ λΆμ€νλ€μ",
          main: "μμ΄κ° λͺ λ² κ°μ§κ³  λλλ λνκ³  λΆλ¬μ‘λ€μ",
          writer: "jb8194",
          date: "2022-12-26",
          grade: 3
        },
        {
          image: 'λ¦¬μλͺ½ μ΄λ―Έμ§',
          name: "νΌμΉ΄μΈ",
          title: "ν¬λ¦¬μ€λ§μ€ μ λ¬Όλ‘ λ±!",
          main: "λλΆμ ν¬λ¦¬μ€λ§μ€ μ λ¬Ό κ±±μ μ λμλ€μ! κ³ λ§μμ λ°μ΄λμ΄!",
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