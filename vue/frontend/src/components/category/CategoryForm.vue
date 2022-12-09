<template>
  <v-container style="width: 1400px">
    <v-row style="margin-top: 30px">
      <v-layout>
        <div style="margin-top: 30px"

        >
          <h2 style="font-weight: bold">{{ categoryName }}</h2>
        </div>
      </v-layout>
      <v-spacer></v-spacer>

      <div style="margin-top: 30px; margin-bottom: 30px">
        <span
            class="mr-2
            grey--text"
        >
            {{ page }} / {{ null }}
          </span>
        <v-btn
            fab
            dark
            x-small
            style="background-color: #2F4F4F"
            elevation="0"
            class="mr-1"
        >
          <v-icon>mdi-chevron-left</v-icon>
        </v-btn>
        <v-btn
            fab
            dark
            style="background-color: #2F4F4F"
            x-small
            elevation="0"
            class="ml-1"
        >
          <v-icon>mdi-chevron-right</v-icon>
        </v-btn>
      </div>
    </v-row>
    <v-divider></v-divider>

    <v-container>
      <v-layout>
        <v-row class="justify-center">
          <v-card v-for="(item, index) in categoryItems" :key="index"
                  class="ma-4"
                  max-width="210"
          >
            <v-img
                class="white--text align-end"
                height="200px"
                :src="require('@/assets/productImg/'+item.img)"
            >
            </v-img>
            <v-card-subtitle class="pb-0">
              {{ item.sellerNickname }}
            </v-card-subtitle>
            <v-card-title>
              <h4>{{ item.commodityTitle }}</h4>
            </v-card-title>
            <v-divider></v-divider>

            <v-card-text class="text--primary">
              {{ item.contents }}
            </v-card-text>

          </v-card>
        </v-row>
      </v-layout>
    </v-container>
  </v-container>
</template>

<script>
export default {
  name: "CategoryForm",
  props:{
    categoryName:{
      type: String
    },
    categoryItems:{
      type: Array
    }
  },
  data(){
    return {
      page: 1,
      itemsPerPage: 5,
    }
  },
}
</script>

<style scoped>

</style>