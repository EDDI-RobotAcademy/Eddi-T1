<template>
  <v-container>
    <sign-up-choice-view/>
  </v-container>
</template>

<script>
import SignUpChoiceView from "@/views/account/SignUpChoiceView";

export default {
  name: 'HomeView',

  components: {
    SignUpChoiceView,
  },
}
</script>