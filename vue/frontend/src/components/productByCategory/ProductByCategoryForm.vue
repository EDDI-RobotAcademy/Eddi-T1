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
            <v-card
                class="ma-4"
                max-width="210"
                flat
            >
              <v-img
                  class="white--text align-end"
                  height="200px"
                  :src="getProductThumbnail(index).productThumbnailListByCategory"
              >
              </v-img>

              <div style="padding: 5px 10px 10px 5px; height: 60px;">
                <h5>{{ item.title }}</h5>
              </div>
            </v-card>
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
    checkValue(){
      console.log(this.productListByCategory)
    }
  },
}
</script>

<style scoped>

</style>