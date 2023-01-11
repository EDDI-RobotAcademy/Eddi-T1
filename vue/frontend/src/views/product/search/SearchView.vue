<template>
  <search-form :searchWord="searchWord"/>
</template>

<script>
import SearchForm from "@/components/product/search/SearchForm";
export default {
  name: "SearchView",
  components: {SearchForm},
  props:{
    searchWord:{
      type: String
    }
  },
}
</script>

<style scoped>

</style>