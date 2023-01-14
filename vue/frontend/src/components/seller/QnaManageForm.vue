<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="81" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 QnA Manage
      </v-toolbar-title>
    </v-app-bar>

    <!--문의 답변전 리스트-->



  </v-container>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";
import {mapState} from "vuex";
export default {
  name: "QnaManageForm",
  components: {SellerNavi},
  computed: {
    ...mapState([
        'qnaBeforeAnswerList',
        'qnaCompleteList',
    ])
  },

}
</script>

<style scoped>

</style>