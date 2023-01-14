<template>
  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="81" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Inquiry Manage
      </v-toolbar-title>
    </v-app-bar>

  </v-container>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";
export default {
  name: "InquiryManageForm",
  components: {SellerNavi}
}
</script>

<style scoped>

</style>