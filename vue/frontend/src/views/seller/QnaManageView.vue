<template>
  <qna-manage-form/>
</template>

<script>
import QnaManageForm from "@/components/seller/QnaManageForm";
import {mapActions} from "vuex";
export default {
  name: "QnaManageView",
  components: {QnaManageForm},
  methods: {
    ...mapActions([
        'requestAnswerStatusListFromSpring'
    ])
  },
  async mounted() {
    const nickname = this.$store.state.memberInfoAfterSignIn.nickname
    const answerStatusArr = ['답변 대기', '답변 완료']

    for (let i = 0; i < answerStatusArr.length; i++) {
      let answerStatus = answerStatusArr[i]
      console.log(answerStatus)
      console.log(nickname)
      await this.requestAnswerStatusListFromSpring({nickname, answerStatus})
    }
  }
}
</script>

<style scoped>

</style>