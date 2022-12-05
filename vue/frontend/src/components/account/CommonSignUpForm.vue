<template>
  <div class="white" style="font-family: Arial">
    <v-row justify="center">
      <v-col cols="auto" style="padding-bottom: 90px">
        <h2 style="margin-block: 50px" class="text-md-center">{{signUpTypeTitle}}</h2>
        <v-img
            :src="require('@/assets/sign_up_choice_num2.png')" width="150" class="mx-auto mb-6"/>
        <h5 class="text-md-center" style="font-weight: normal; margin-top: 50px">
          가입 정보를 입력해주세요.</h5>
        <v-card width="480" height="660" style="padding-inline: 40px; margin-top: 30px; margin-bottom: 30px" >
          <v-form @submit.prevent="onSubmit" ref="form">
            <div class="d-flex">
              <v-text-field v-model="id" label="아이디*" @change="idValidation"
                            :rules="id_rule" :disabled="false" required/>
              <v-btn text large outlined style id="textFieldType"
                     class="mt-3 ml-5" color="#2F4F4F"
                     @click="null"
                     :disabled="!idPass">
                아이디 <br/>중복 확인
              </v-btn>
            </div>

            <div class="d-flex">
              <v-text-field v-model="password"
                            @click:append="show1 = !show1"
                            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                            :rules="password_rule"
                            :type="show1 ? 'text' : 'password'"
                            label="비밀번호*"
                            counter
                            required/>
            </div>
            <div class="d-flex">
              <v-text-field v-model="password_confirm"
                            @click:append="show2 = !show2"
                            :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
                            @change="passwordValidation"
                            :rules="password_confirm_rule"
                            :type="show2 ? 'text' : 'password'"
                            label="비밀번호 확인*"
                            counter
                            required/>
            </div>

            <div class="d-flex">
              <v-text-field v-model="nickname" :label="signUpTypeBtn +'*'"  @change="nicknameValidation"
                            :rules="nickname_rule" :disabled="false" required/>
              <v-btn text large outlined style id="textFieldType"
                     class="mt-3 ml-5" color="#2F4F4F"
                     @click="null"
                     :disabled="!nicknamePass">
                {{signUpTypeBtn}} <br/>중복 확인
              </v-btn>
            </div>

            <accept-card/>

            <div style="margin-bottom: 30px">
              <v-btn type="submit" block x-large rounded
                      color="#2F4F4F" :disabled="(idPass & nicknamePass) == false">
                가입하기
              </v-btn>
            </div>

          </v-form>
        </v-card>
      </v-col>
    </v-row>

  </div>
</template>

<script>
import AcceptCard from "@/components/account/AcceptCard";

export default {
  name: "SellerSignUpForm",
  components: {AcceptCard},
  props: {
    signUpTypeTitle: {
      type: String,
      default : "",
    },
    signUpTypeBtn: {
      type: String,
      default : "",
    }
  },
  data() {
    return {
      id: "",
      password: "",
      password_confirm: "",
      nickname: "",
      signUpType: this.signUpTypeBtn,
      idPass: false,
      passwordPass: false,
      nicknamePass: false,
      show1: false,
      show2: false,
      /**
       * ID 공백/특수문자/길이 검사
       */
      id_rule: [
        v => !!v || '아이디를 입력해주세요.',
        v => {
          const pattern = /^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/
          return pattern.test(v) || '특수문자는 입력할 수 없습니다.'
        },
        v => !(v && v.length >= 20) || '아이디는 30자 이상 입력할 수 없습니다.',
      ],
      /**
       * 패스워드 필수입력/길이 검사
       */
      password_rule: [
        v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
        v => !(v && v.length >= 30) || '패스워드는 30자 이상 입력할 수 없습니다.',
      ],
      /**
       * 패스워드 텍스트 필드 일치여부 검사
       */
      password_confirm_rule: [
        v => this.state === 'ins' ? !!v || '패스워드는 필수 입력사항입니다.' : true,
        v => !(v && v.length >= 30) || '패스워드는 30자 이상 입력할 수 없습니다.',
        v => v === this.password || '패스워드가 일치하지 않습니다.'
      ],
      /**
       * 상호명&닉네임 공백/특수문자/길이 검사
       */
      nickname_rule: [
        v => !!v || this.signUpTypeBtn+'을(를) 입력해주세요.',
        v => {
          const pattern = /^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/
          return pattern.test(v) || '특수문자는 입력할 수 없습니다.'
        },
        v => !(v && v.length >= 20) || this.signUpTypeBtn+'은(는) 30자 이상 입력할 수 없습니다.',
      ],
    }
  },

  methods: {
    // 아이디 중복 검사 mapActions 추가 예정

    idValidation() {
      const idValid = this.id.match(
          /^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/
      );
      if (idValid) {
        this.idPass = true
      }
    },

    nicknameValidation() {
      const nicknameValid = this.nickname.match(
          /^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/
      );
      if (nicknameValid) {
        this.nicknamePass = true
      }
    },

    passwordValidation() {
      if ((this.password == this.password_confirm) && (this.password.length != 0)) {
        this.passwordPass = true
      }
    },

    onSubmit() {
      const {id, password, businessName} = this
      this.$emit("submit", {id, password, businessName})
    }
  }

}
</script>

<style scoped>
#textFieldType {
  margin-top: 10px;
  margin-bottom: 10px;
  font-size: 14px;
}
</style>