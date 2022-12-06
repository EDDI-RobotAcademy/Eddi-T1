<template>
  <v-container>
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
              <v-form @submit.prevent="onSubmitBuyerSignInForm">
                <v-text-field
                    v-model="buyerId"
                    class="mx-10 mt-10"
                    outlined label="ID"
                    :prepend-icon="'mdi-account'"
                    clearable
                >
                </v-text-field>
                <v-text-field
                    v-model="buyerPassword"
                    class="mx-10 mb-16"
                    outlined label="Password"
                    :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                    :type="show1 ? 'text' : 'password'"
                    @click:append="show1 = !show1"
                    :prepend-icon="'mdi-lock'"
                    clearable
                >
                </v-text-field>
                <div style="width: 300px; margin: 0 auto">
                  <v-btn type="submit" color="#2F4F4F" width="300" height="50" style="color: white">로그인</v-btn>
                </div>
                <v-divider style="width: 400px; margin: 30px auto"></v-divider>
                <div style="display: flex; width: 300px; margin: 0 auto; justify-content: center">
                  <p class="induce" style="margin-right: 10px">아직 회원이 아니신가요?</p>
                  <router-link class="induce" :to="{name: 'SignUpChoiceView'}" style="text-decoration: none; color: #DAA520; font-weight: bold">회원가입</router-link>
                </div>
              </v-form>
            </v-tab-item>

            <v-tab-item>
              <v-form @submit.prevent="onSubmitSellerSignInForm">
                <v-text-field
                    v-model="sellerId"
                    class="mx-10 mt-10"
                    outlined label="ID"
                    :prepend-icon="'mdi-account'"
                    clearable
                >
                </v-text-field>
                <v-text-field
                    v-model="sellerPassword"
                    class="mx-10 mb-16"
                    outlined label="Password"
                    :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
                    :type="show2 ? 'text' : 'password'"
                    @click:append="show2 = !show2"
                    :prepend-icon="'mdi-lock'"
                    clearable
                >
                </v-text-field>
                <div style="width: 300px; margin: 0 auto">
                  <v-btn type="submit" color="#2F4F4F" width="300" height="50" style="color: white">로그인</v-btn>
                </div>
                <v-divider style="width: 400px; margin: 30px auto"></v-divider>
                <div style="display: flex; width: 400px; margin: 0 auto; justify-content: center">
                  <p class="induce" style="margin-right: 10px">자신의 아이디어를 판매하고 싶으신가요?</p>
                  <router-link class="induce" :to="{name: 'SignUpChoiceView'}" style="text-decoration: none; color: #DAA520; font-weight: bold">회원가입</router-link>
                </div>
              </v-form>
            </v-tab-item>
          </v-tabs-items>
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
      buyerId: "",
      buyerPassword: "",
      sellerId: "",
      sellerPassword: "",
      show1: false,
      show2: false,
      tabs: null,
      loginType: ["일반회원", "판매자"]
    }
  },
  methods: {
    onSubmitBuyerSignInForm () {
      const { buyerId, buyerPassword } = this
      this.$emit("submit", { buyerId, buyerPassword })
    },
    onSubmitSellerSignInForm () {
      const { sellerId, sellerPassword } = this
      this.$emit("submit", { sellerId, sellerPassword })
    }
  }
}
</script>

<style scoped>
.induce {
  font-size: 13px;
}
</style>