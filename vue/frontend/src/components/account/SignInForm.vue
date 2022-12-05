<template>
  <v-container style="margin-top: 100px" >
    <v-row justify="center" align="center">
      <v-col>
        <div style="width: 600px; margin: 0 auto">
          <v-tabs
              color="#2F4F4F"
              fixed-tabs
              background-color="white"
              v-model="tabs" >
            <v-tab v-for="type in loginType" :key="type">
              {{ type }}
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tabs">
            <v-tab-item>
              <v-text-field
                  class="mx-10 mt-10"
                  outlined label="ID"
                  clearable
              >
              </v-text-field>
              <v-text-field
                  class="mx-10 mb-16"
                  outlined label="Password"
                  clearable
              >
              </v-text-field>
              <div style="width: 300px; margin: 0 auto">
                <v-btn color="#2F4F4F" width="300" height="50" style="color: white">로그인</v-btn>
              </div>
            </v-tab-item>

            <v-tab-item>
              <v-text-field
                  class="mx-10 mt-10"
                  outlined label="ID"
                  clearable
              >
              </v-text-field>
              <v-text-field
                  class="mx-10 mb-16"
                  outlined label="Password"
                  clearable
              >
              </v-text-field>
              <div style="width: 300px; margin: 0 auto">
                <v-btn color="#2F4F4F" width="300" height="50" style="color: white">로그인</v-btn>
              </div>
            </v-tab-item>
          </v-tabs-items>
          <v-divider style="width: 400px; margin: 30px auto"></v-divider>
          <div style="display: flex; width: 250px; margin: 0 auto">
            <p style="margin-right: 10px">아직 회원이 아니신가요?</p>
            <router-link :to="{name: 'SignUpChoiceView'}" style="text-decoration: none; color: #DAA520">회원가입</router-link>
          </div>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "SignInForm",
  data () {
    return {
      tabs: null,
      loginType: ["일반회원", "판매자"]
    }
  }
}
</script>

<style scoped>

</style>