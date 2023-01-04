<template>
  <v-container style="width: 1200px; margin-top: 50px;">
    <h2>{{ categoryName }}</h2>

    <v-layout style="margin-top: 50px;">
      <v-row class="justify-center">
        <div v-for="(item, index) in productListByCategory" :key="index">
          <router-link :to="{ name: 'ProductReadView',
                                    params: { productNo: item.productNo.toString() } }"
                       style="text-decoration: none; color: black"
          >
            <v-hover
                v-slot="{ hover } "
            >
              <v-card
                  :elevation="hover ? 16 : 0"
                  class="ma-4"
                  :class="{'on-hover' : hover}"
                  max-width="265"
                  flat
              >
                <v-img
                    class="white--text align-end"
                    height="265px"
                    :src="getProductThumbnail(index).productThumbnailListByCategory"
                >
                </v-img>
                <div style="padding: 10px 10px 10px 10px">
                  <div style="margin-top: 3px; color: darkgray;">
                    <h6>{{item.nickname}}</h6>
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

</template>

<script>
export default {
  name: "ProductByCategoryForm",
  props: {
    categoryName: {
      type: String
    },
    productListByCategory:{
      type: Array
    },
    productThumbnailListByCategory:{
      type: Array
    }
  },
  methods:{
    getProductThumbnail(index){
      return {
        ...this.productThumbnailListByCategory,
        productThumbnailListByCategory: this.productThumbnailListByCategory[index] && require(`@/assets/productImg/${this.productThumbnailListByCategory[index]}`)
      }
    },
  },
  filters: {
    comma(val) {
      return String(val).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  },
}
</script>

<style scoped>

</style>