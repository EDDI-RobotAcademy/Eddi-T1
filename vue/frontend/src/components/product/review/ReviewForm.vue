<template>
  <div>
    <v-card flat style="margin-left: 25px; margin-top: 20px" width="95%">

      <v-layout
          v-for="(itemList, index) in productReviewList" :key="index"
          @page-count="pageCount = $event"
      >

        <v-card max-width="230px"
                style="padding: 25px 25px 25px 25px; border-bottom: 1px solid #eaebee;"
                flat
        >
          <v-img
              height="180px" flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 10px;"
              :src="getReviewImg(index).reviewImgList">
          </v-img>
        </v-card>

        <v-card width="100%"
                flat
                style="border-bottom: 1px solid #eaebee; margin-top: 15px"
                tile
        >
          <v-card-title style="font-weight: bold; font-size: 15px">
            <router-link to="null" style="text-decoration: none; color: black">
              {{ itemList.writer }}
            </router-link>

            <v-spacer></v-spacer>
            <v-rating
                :value="itemList.starRating"
                background-color="orange lighten-3"
                color="orange"
                small
                dense hover readonly>
            </v-rating>

          </v-card-title>

          <v-card-subtitle style="font-size: 12px; font-weight: bold">
            {{ itemList.regDate | date }}
          </v-card-subtitle>


          <v-card-title style="padding-top: 0px; font-weight: normal; font-size: 16px; color: black">
            {{itemList.content}}
          </v-card-title>
        </v-card>

      </v-layout>



      <v-layout
          v-for="(itemList, index) in productNextReviewList" :key="index"
      >
        <v-card max-width="230px"
                style="padding: 25px 25px 25px 25px; border-bottom: 1px solid #eaebee;"
                flat
        >
          <v-img
              height="180px" flat color="#f5f5f5" style="border: 1px solid #d9d9d9; margin-top: 10px;"
              :src="getReviewImg(index).reviewImgList">
          </v-img>
        </v-card>

        <v-card width="100%"
                flat
                style="border-bottom: 1px solid #eaebee; margin-top: 15px"
                tile
        >
          <v-card-title style="font-weight: bold; font-size: 15px">
            <router-link to="null" style="text-decoration: none; color: black">
              {{ itemList.writer }}
            </router-link>

            <v-spacer></v-spacer>
            <v-rating
                :value="itemList.starRating"
                background-color="orange lighten-3"
                color="orange"
                small
                dense hover readonly>
            </v-rating>

          </v-card-title>

          <v-card-subtitle style="font-size: 12px; font-weight: bold">
            {{ itemList.regDate | date }}
          </v-card-subtitle>


          <v-card-title style="padding-top: 0px; font-weight: normal; font-size: 16px; color: black">
            {{itemList.content}}
          </v-card-title>
        </v-card>
      </v-layout>

      <v-btn
          @click="addReview()"
          block
          large
          dense
          outlined
          v-bind="attrs"
          v-on="on"
          width="140px"
          elevation="0"
          style="color: #2F4F4F; margin-top: 10px; margin-right: 10px;"
      >
        더보기
      </v-btn>

    </v-card>

    <v-pagination
        class="mt-10 mb-5"
        v-model="page"
        :length="pageCount"
        total-visible="5"
        color="#2F4F4F"
        circle
        flat
    >
    </v-pagination>


  </div>

</template>


<script>

export default {
  name: "ReviewForm",
  props: {
    productNo: {
      type: String,
      required: true,
    },
  },

  data() {
    return {
      page: 1,
      pageCount: 0,

    }
  },
  filters: {
    date : function(data){
      const reqdString = data.split("").slice(0, 10).join("");
      if (data.length < 10) {
        return reqdString
      } else {
        return reqdString ;
      }
    },
    nameFormat(val){
      return String(val).replace(/(?<=.{2})./gi,"*");
    }
  },
  methods: {

    getReviewImg(index) {
     return {
       ...this.reviewImage,
       reviewImgList: this.reviewImage[index] && require(`@/assets/reviewImg/${this.reviewImage[index].editedName}`)
     }
    },

  },

  async mounted() {

  },



}
</script>

<style scoped>

</style>