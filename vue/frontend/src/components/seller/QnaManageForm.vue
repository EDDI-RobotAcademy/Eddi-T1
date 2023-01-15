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
    <v-container style="width: 1400px">
      <buyer-my-page-top-nav :countByInfo="countByInfo"/>

      <div>
        <v-card-title style="font-size: 20px; font-weight: bold; color: #2F4F4F">
          <v-icon size="30" color="#2F4F4F">mdi-bullhorn-variant-outline</v-icon>&nbsp;
          답변 대기 상태의 글
          <v-spacer></v-spacer>
          총 {{ qnaBeforeAnswerList.length }}건
        </v-card-title>

        <hr color="#DAA520" width="100%">
        <v-data-table class="elevation-0 "
                      :headers="headers"
                      :items="qnaBeforeAnswerList"
                      item-key="qnaNo"
                      :expanded.sync="expanded"
                      :single-expand="singleExpand"
                      hide-default-footer
                      :items-per-page="7"
                      :page.sync="page"
                      @page-count="pageCount = $event"
                      @click:row="expandRow"
        >
          <template v-slot:expanded-item="{ headers, item }">
            <td :colspan="headers.length">

              <v-card style="width: 100%; height: auto; border: 1px solid transparent" flat>
                <v-layout style="height: 100%; width: 100%">

                  <v-card width="100%" height="auto" color="#f5f5f5" style="border-bottom: 1px solid #eaebee" flat tile>


                    <div style="color: #666666; margin-top: 5px; margin-left: 96%">&nbsp;</div>
                    <v-card width="100%" flat color="#f5f5f5" style="padding-bottom: 0px">

                      <v-card-subtitle style="width: 100%; font-size: 13px; padding-top: 0px; padding-bottom: 0px">

                        <span style="color: black" v-if="item.openStatus === false">
                          <v-icon size="16" color="grey">mdi-lock-outline</v-icon>&nbsp;
                        </span>

                        <span style="color: black" v-else>
                           <v-icon size="16" color="grey">mdi-lock-open-variant-outline</v-icon>&nbsp;
                        </span>

                        <strong>{{ item.writer }}</strong> | <strong> {{ item.questionTitle }} </strong>
                      </v-card-subtitle>

                      <v-card-title style="padding-top: 0px; font-weight: bolder; font-size: 20px; color: #2F4F4F">
                        Q
                        <v-card-title style="font-weight: normal; font-size: 15px">
                          {{ item.questionContent }}
                        </v-card-title>
                      </v-card-title>

                    </v-card>

                    <v-card
                        width="100%" height="auto" flat color="#f5f5f5" style="border-top: 1px solid transparent" tile
                        class="card-p"
                        v-show="item.answerStatus != 'BEFORE_ANSWER'"
                    >
                      <v-card-title style="font-weight: bolder; font-size: 20px; color: #DAA520">
                        A

                        <v-card-title style="font-weight: normal; font-size: 15px;">
                          <!--문의하기 버튼 / 문의 등록 dialog-->
                          <v-dialog
                              v-model="dialog"
                              @click:outside="fn_cancel"
                              persistent
                              max-width="568px"
                              :retain-focus="false"
                          >
                            <template v-slot:activator="{on, attrs}">
                              <v-btn
                                  large
                                  dense
                                  outlined
                                  v-bind="attrs"
                                  v-on="on"
                                  width="150px"
                                  elevation="0"
                                  style="color: #DAA520"
                                  @click="setQnaAnswer(i)"
                              >
                                답변하기
                              </v-btn>
                            </template>
                            <v-card height="auto">

                              <v-layout style="margin-left: 35px">

                                <!--상호명 + 기본문구-->
                                <v-card width="400px" flat tile>
                                  <v-card-title style="font-weight: bold; font-size: 15px">
                                    📨 &nbsp; <span style="color: cadetblue"> {{ item.nickname }} </span> 의
                                  </v-card-title>

                                  <v-card-subtitle style="font-weight: bold; color: black; font-size: 15px">
                                    &emsp; &nbsp; 답변을 기다리는 문의글입니다.
                                  </v-card-subtitle>
                                </v-card>
                              </v-layout>

                              <v-divider style="margin: 0px 38px 10px 38px;"></v-divider>

                              <!--문의 유형/상품/공개상태/답변상태/닉네임/날짜/제목/내용-->
                              <div align="center">
                                <v-card height="auto" width="500" flat style="border: 1px solid transparent">

                                  <v-card width="100%" height="auto" flat color="#f5f5f5" style="padding-bottom: 0px">

                                    <v-card-subtitle style="width: 100%; padding-top: 0px; padding-bottom: 0px">
                                      &nbsp;
                                    </v-card-subtitle>

                                    <v-card-subtitle style="width: 100%; font-size: 13px; text-align: left; padding-top: 0px; padding-bottom: 0px">
                                      <span style="color: #DAA520; font-weight: bold">
                                      <strong>[{{ item.questionCategory }}]</strong>
                                      </span>
                                      <strong> {{ item.title }} </strong>
                                    </v-card-subtitle>

                                    <v-card-subtitle style="width: 100%; font-size: 13px; text-align: left; padding-top: 0px; padding-bottom: 0px">

                                      <span style="color: black" v-if="item.openStatus === false">
                                        <v-icon size="16" color="grey">mdi-lock-outline</v-icon>&nbsp;
                                      </span>
                                      <span style="color: grey" v-else>
                                        <v-icon size="16" color="grey">mdi-lock-open-variant-outline</v-icon>&nbsp;
                                      </span>

                                      {{ item.answerStatus }} | {{ item.regDate | date }}
                                    </v-card-subtitle>


                                    <v-card-subtitle style="width: 100%; font-size: 13px; text-align: left; padding-top: 0px; padding-bottom: 0px">
                                      <strong>▶ {{ item.questionTitle }} ( {{item.writer}} )</strong>
                                    </v-card-subtitle>

                                    <v-card-title style="padding-top: 0px; font-weight: bolder; font-size: 20px; color: #2F4F4F">
                                      Q
                                      <v-card-title style="font-weight: normal; font-size: 15px">
                                        {{ item.questionContent }}
                                      </v-card-title>
                                    </v-card-title>

                                  </v-card>

                                  <!--문의 본문-->
                                  <v-textarea style="margin-top: 10px"
                                      v-model="qnaAnswer" label="🖊️ " counter outlined clearable
                                      placeholder="답변 내용을 작성해주세요"
                                      row-height="50" clear-icon="mdi-close-circle" color="#2F4F4F" auto-grow required
                                      :rules="contentRule"/>

                                </v-card>

                                <v-btn style="margin-top: 10px; margin-bottom: 30px; background-color: #DAA520; color: white"
                                       width="500px"  elevation="0"
                                       @click="registerAnswer(item.qnaNo)"
                                >
                                  답변 등록
                                </v-btn>
                              </div>
                            </v-card>
                          </v-dialog>
                        </v-card-title>
                      </v-card-title>
                    </v-card>


                  </v-card>

                </v-layout>
              </v-card>

            </td>
          </template>

          <!--등록된 문의가 없을 때-->
          <template slot="no-data">
            <v-alert :value="true" color="transparent">
              등록된 문의가 없습니다.
            </v-alert>
          </template>

          <!--답변상태 chip-->
          <template v-slot:[`item.answerStatus`]="{ item }">
            <v-chip color="green"
                    small
                    outlined
                    v-if="item.answerStatus === 'ANSWER_COMPLETE'">
              답변 완료
            </v-chip>
            <v-chip v-else
                    small
                    color="#DAA520"
                    outlined>
              답변 대기
            </v-chip>
          </template>

          <!--비밀글에 따른 제목 변경-->
          <template v-slot:[`item.title`]="{ item }">
            <span style="color: black; font-family: 'Nanum Gothic'"
                  v-if="item.openStatus === false">
                    {{ item.title }} <v-icon size="20" color="grey">mdi-lock-outline</v-icon>
            </span>

            <span style="color: black; font-family: 'Nanum Gothic'"
                  v-else>
                    {{ item.title }}
            </span>
          </template>

          <!--문의유형 표시-->
          <template v-slot:[`item.questionCategory`]="{ item }">
            <span style="font-weight: bold; font-size: small; color: #2F4F4F">
              [{{ item.questionCategory }}]
            </span>
          </template>

          <!--Date format-->
          <template v-slot:[`item.regDate`]="{ item }">
            <span style="font-weight: normal; color: #2F4F4F">
              {{ item.regDate | date }}
            </span>
          </template>

        </v-data-table>

        <v-pagination
            class="mt-10 mb-5"
            v-model="page"
            :length="pageCount"
            total-visible="5"
            color="#2F4F4F"
            circle
            flat
        >
        </v-pagination>
      </div>

    </v-container>


    <!--문의 답변완료 리스트-->
    <v-container style="width: 1400px">
      <buyer-my-page-top-nav :countByInfo="countByInfo"/>


      <div>
        <v-card-title style="font-size: 20px; font-weight: bold; color: #2F4F4F">
          <v-icon size="30" color="#2F4F4F">mdi-bullhorn-variant-outline</v-icon>&nbsp;
          답변 완료 상태의 글
          <v-spacer></v-spacer>
          총 {{ qnaCompleteList.length }}건
        </v-card-title>

        <hr color="#DAA520" width="100%">
        <v-data-table class="elevation-0 "
                      :headers="headers2"
                      :items="qnaCompleteList"
                      item-key="questionTitle"
                      :expanded.sync="expanded2"
                      :single-expand="singleExpand2"
                      hide-default-footer
                      :items-per-page="7"
                      :page.sync="page2"
                      @page-count="pageCount2 = $event"
                      @click:row="expandRow"
        >
          <template v-slot:expanded-item="{ headers, item }">
            <td :colspan="headers.length">


              <v-card style="width: 100%; height: auto; border: 1px solid transparent" flat>
                <v-layout style="height: 100%; width: 100%">

                  <v-card width="100%" height="auto" color="#f5f5f5" style="border-bottom: 1px solid #eaebee" flat tile>

                    <!--삭제버튼-->
                    <v-icon style="color: #666666; margin-top: 5px; margin-left: 96%" @click="dialog = true">
                      mdi-close-circle-outline
                    </v-icon>
                    <v-dialog
                        v-model="dialog"
                        max-width="500"
                    >
                      <v-card align="center">
                        <v-card-title class="justify-center">
                          정말 삭제하시겠습니까?
                        </v-card-title>
                        <br>
                        <v-card-actions>
                          <v-spacer></v-spacer>
                          <v-btn class="white--text" color="#DAA520" @click="dialog = false">
                            취소
                          </v-btn>
                          <v-btn class="white--text" color="#2F4F4F" @click="onDelete(item.qnaNo)">
                            삭제
                          </v-btn>
                          <v-spacer></v-spacer>
                        </v-card-actions>
                      </v-card>
                    </v-dialog>


                    <v-card width="100%" flat color="#f5f5f5" style="padding-bottom: 0px">
                      <v-card-subtitle style="width: 100%; font-size: 13px; padding-top: 0px; padding-bottom: 0px">

                        <span style="color: black" v-if="item.openStatus === false">
                          <v-icon size="16" color="grey">mdi-lock-outline</v-icon>&nbsp;
                        </span>

                        <span style="color: black" v-else>
                           <v-icon size="16" color="grey">mdi-lock-open-variant-outline</v-icon>&nbsp;
                        </span>

                        <strong>{{ item.writer }}</strong> | <strong> {{ item.questionTitle }} </strong>

                      </v-card-subtitle>

                      <v-card-title style="padding-top: 0px; font-weight: bolder; font-size: 20px; color: #2F4F4F">
                        Q
                        <v-card-title style="font-weight: normal; font-size: 15px">
                          {{ item.questionContent }}
                        </v-card-title>
                      </v-card-title>

                    </v-card>

                    <v-card
                        width="100%" height="auto" flat color="#f5f5f5" style="border-top: 1px solid transparent" tile
                        class="card-p"
                        v-show="item.answerStatus != 'BEFORE_ANSWER'"
                    >
                      <v-card-title style="font-weight: bolder; font-size: 20px; color: #DAA520">
                        A

                        <v-card-title style="font-weight: normal; font-size: 15px;">

                        </v-card-title>
                      </v-card-title>
                    </v-card>

                    <v-card
                        width="100%" height="auto" flat color="#f5f5f5" style="border-top: 1px solid transparent" tile
                        class="card-p"
                        v-show="item.answerStatus == 'ANSWER_COMPLETE'"
                    >

                      <v-card-title style="font-weight: bolder; font-size: 20px; color: #DAA520">
                        A

                        <v-card-title style="font-weight: normal; font-size: 15px">
                          {{ item.answer }}
                        </v-card-title>
                      </v-card-title>
                    </v-card>

                  </v-card>

                </v-layout>
              </v-card>

            </td>
          </template>

          <!--등록된 문의가 없을 때-->
          <template slot="no-data">
            <v-alert :value="true" color="transparent">
              답변이 완료된 문의가 없습니다.
            </v-alert>
          </template>

          <!--답변상태 chip-->
          <template v-slot:[`item.answerStatus`]="{ item }">
            <v-chip color="green"
                    small
                    outlined
                    v-if="item.answerStatus === 'ANSWER_COMPLETE'">
              답변 완료
            </v-chip>
            <v-chip v-else
                    small
                    color="#DAA520"
                    outlined>
              답변 대기
            </v-chip>
          </template>

          <!--비밀글에 따른 제목 변경-->
          <template v-slot:[`item.title`]="{ item }">
            <span style="color: black; font-family: 'Nanum Gothic'"
                  v-if="item.openStatus === false">
              {{ item.title }} <v-icon size="20" color="grey">mdi-lock-outline</v-icon>
            </span>

            <span style="color: black; font-family: 'Nanum Gothic'"
                  v-else>
              {{ item.title }}
            </span>
          </template>

          <!--문의유형 표시-->
          <template v-slot:[`item.questionCategory`]="{ item }">
            <span style="font-weight: bold; font-size: small; color: #2F4F4F">
              [{{ item.questionCategory }}]
            </span>
          </template>

          <!--Date format-->
          <template v-slot:[`item.regDate`]="{ item }">
            <span style="font-weight: normal; color: #2F4F4F">
              {{ item.regDate | date }}
            </span>
          </template>

        </v-data-table>

        <v-pagination
            class="mt-10 mb-5"
            v-model="page2"
            :length="pageCount2"
            total-visible="5"
            color="#2F4F4F"
            circle
            flat
        >
        </v-pagination>
      </div>
    </v-container>


  </v-container>
</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";
import {mapActions, mapState} from "vuex";
export default {
  name: "QnaManageForm",
  components: {SellerNavi},
  computed: {
    ...mapState([
        'qnaBeforeAnswerList',
        'qnaCompleteList',
    ])
  },
  data() {
    return {
      expanded: [],
      singleExpand: true,
      page: 1,
      pageCount: 0,
      headers: [
        {text: '유형', value: 'questionCategory', width: "80px"},
        {text: '상품', value: 'title', width: "300px"},
        {text: 'date ', value: 'regDate', width: "100px"},
        {text: '답변상태 ', value: 'answerStatus', width: "50px"},
      ],
      contentRule: [
        v => !(v.length >= 500) || '500자 이상 입력할 수 없습니다.'
      ],
      qnaAnswer: '',
      dialog: false,

      expanded2: [],
      singleExpand2: true,
      page2: 1,
      pageCount2: 0,
      headers2: [
        {text: '유형', value: 'questionCategory', width: "80px"},
        {text: '상품', value: 'title', width: "300px"},
        {text: 'date ', value: 'regDate', width: "100px"},
        {text: '답변상태 ', value: 'answerStatus', width: "50px"},
      ],
    }
  },
  filters: {
    date: function (data) {
      const reqdString = data.split("").slice(0, 10).join("");
      if (data.length < 10) {
        return reqdString
      } else {
        return reqdString;
      }
    }
  },
  methods: {
    ...mapActions([
        'requestAnswerRegisterToSpring'
    ]),
    expandRow(item, event) {
      if (event.isExpanded) {
        var index = this.expanded.findIndex(i => i === item);
        this.expanded.splice(index, 1)
      } else {
        this.expanded.push(item);
      }
    },
    fn_cancel() {
      this.dialog = false
    },
    async registerAnswer(qnaNo) {
      console.log("qnaNo: "+ qnaNo)
      const answer = this.qnaAnswer

      await this.requestAnswerRegisterToSpring({qnaNo, answer})
    },

    onDelete(qnaNo) {
      console.log("qnaNo: " + qnaNo)
      this.requestDeleteQnaFromSpring(qnaNo)
    }
  }
}
</script>

<style scoped>
table {
  width: 100%;
  text-align: center;
  border-collapse: collapse;
  border-spacing: 0;
  font-family: 'Nanum Gothic', sans-serif !important;
}
.v-data-table >>> .v-data-table__wrapper tbody tr.v-data-table__expanded__content {
  box-shadow: none;
}
</style>