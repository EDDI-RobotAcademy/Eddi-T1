<template>
  <v-container style="width: 1200px">
    <div align="center" style="margin-top: 80px; margin-bottom: 80px;">
      <div v-if="keyword">
        <h2 style="font-size: 28px">'{{ keyword }}' 에 대한 검색결과</h2>
      </div>
      <div v-else>
        <h2 style="font-size: 28px">" "에 대한 검색결과</h2>
      </div>
    </div>

    <div>
      <v-container style="width: 900px; margin-top: 80px;"
                   v-if="!searchResultList || (Array.isArray(searchResultList) && searchResultList.length === 0)">
        <div align="center">
          <v-icon size="100px" style="color: lightgray">mdi-magnify</v-icon>
          <h4 style="color: lightgray">검색된 상품이 없습니다.</h4>
        </div>
      </v-container>

      <v-container v-else style="width: 1200px">
        <v-layout style="margin-bottom: 30px;">
          <div>
            <h4>총 {{ searchResultList.length }}건</h4>
          </div>

          <v-spacer></v-spacer>
          <v-layout justify-end>
            <div v-for="(filter, index) in filterItems" :key="index">
              <h4
              ><a @click="check(index)" style="text-decoration: none; color: black">{{filter.name}} &nbsp;</a>
              </h4>
            </div>
          </v-layout>
        </v-layout>
        <v-layout>
          <v-row class="justify-start">
            <div v-for="(item, index) in searchResultList" :key="index">
              <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString() } }"
                           style="text-decoration: none; color: black"
              >
                <v-hover
                    v-slot="{ hover } "
                >
                  <v-card
                      :elevation="hover ? 16 : 0"
                      :class="{'on-hover' : hover}"
                      class="ma-4"
                      max-width="265"
                      flat
                  >
                    <v-img
                        class="white--text align-end"
                        height="265px"
                        :src="getSearchProductImg(index).searchResultList"
                    >
                    </v-img>
                    <div style="padding: 10px 10px 10px 10px">
                      <div style="margin-top: 3px; color: darkgray;">
                        <h6>{{ item.nickname }}</h6>
                      </div>

                      <div style="padding: 5px 10px 10px 5px; height: 60px;">
                        <h4>{{ item.title }}</h4>
                      </div>

                      <div align="end">
                        <h5>{{ item.price | comma }}원</h5>
                      </div>
                    </div>
                  </v-card>
                </v-hover>
              </router-link>
            </div>

          </v-row>
        </v-layout>
      </v-container>
    </div>
  </v-container>
</template>

<script>
import {mapState} from "vuex";

export default {
  name: "SearchForm",
  computed: {
    ...mapState([
      'searchResultList',
    ])
  },
  data(){
    return{
      filterItems: [
        {name: "최신순 | "},
        {name: "인기순 | "},
        {name: "리뷰순 | "},
        {name: "가격순"},
      ],
      keyword: ''
    }
  },
  props: {
    searchWord: {
      type: String
    }
  },
  methods: {
    getSearchProductImg(index) {
      return {
        ...this.searchResultList,
        searchResultList: this.searchResultList[index].productImages[0].editedName && require(`@/assets/productImg/${this.searchResultList[index].productImages[0].editedName}`)
      }
    },
    check(i){
      switch (this.filterItems[i].name){
        case "최신순": this.newest()
              break
        case "가격순": this.byPrice()
              break
        case "리뷰순": this.byReview()
              break
        case "인기순": this.byPopularity()
              break
      }
    },
    newest(){
      console.log("최신순")
    },
    byPrice(){
      console.log("가격순")
    },
    byReview(){
      console.log("리뷰순")
    },
    byPopularity(){
      console.log("인기순")
    }
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
  mounted() {
    this.keyword = localStorage.getItem('searchWord')
  },
}
</script>

<style scoped>

</style>