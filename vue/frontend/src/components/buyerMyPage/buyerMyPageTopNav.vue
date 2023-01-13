<template>
  <v-container style="width: 1400px; height: 300px; margin-top: 80px;">
    <v-card style="height: 150px; margin-top: 80px;"
            elevation="0"
            tile
            fla
    >
      <v-row class="justify-center">
        <v-card class="cardStyle"
                v-for="(item, index) in myPageCategoryItems"
                :key="index"
                tile
                flat
        >
          <v-card-title class="justify-center">
            <h5>{{ item.title }}</h5>
          </v-card-title>

          <v-card-title class="justify-sm-end" style="margin-right: 10px">
            <router-link to="null" style="text-decoration: none; color: white">
              <h5 style="font-size: 33px; color: #FAEBD7">{{countByInfo[index]}}</h5>
            </router-link>

            <span style="margin-top: 7px">
                  개
                </span>
          </v-card-title>
        </v-card>
      </v-row>
    </v-card>
  </v-container>
</template>

<script>
export default {
  name: "buyerMyPageTopNav",
  props: {
    myPageCategoryItems:{
      type: Array
    },
    countByInfo:{
      type: Array
    }
  }
}
</script>

<style scoped>
.cardStyle {
  height: 150px;
  width: 215px;
  padding: 10px 10px;
  background-color: #2F4F4F;
  color: white;
  border-right: 1px solid white;
  border-left: 1px solid white;
}
</style>