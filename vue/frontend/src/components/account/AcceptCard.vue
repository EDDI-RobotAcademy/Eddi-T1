<template>
  <v-container>
    <v-card height="220px" class="scroll" style="margin-top: 15px">
      <v-card-text>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
        이용약관 내용 TEST <br>
      </v-card-text>
    </v-card>
    <div style="margin-top: 10px" class="text-md-right">
      <input type="checkbox" id="checkbox" @click:append="check = !check">
      <label for="checkbox" style="margin-left: 3px">이용 약관에 동의합니다.</label>
    </div>
  </v-container>
</template>

<script>
export default {
  name: "AcceptCard",
  data() {
    return {
      check: false,
    }
  }
}
</script>

<style scoped>
.scroll {
  overflow-y: scroll
}
</style>