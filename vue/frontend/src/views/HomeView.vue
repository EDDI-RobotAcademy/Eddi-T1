<template>
  <div>
    <main-page-view/>
  </div>
</template>

<script>
import MainPageView from "@/views/MainPageView";

export default {
  name: 'HomeView',
  components: {
    MainPageView,
  },
  async mounted(){
    if (localStorage.getItem('loginValue') != null) {
      this.$store.state.signInCheckValue = true
    }
  }
}
</script>