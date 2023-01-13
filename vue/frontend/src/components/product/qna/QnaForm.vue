<template>

  <div>

  <hr color="#DAA520" width="100%">

  <v-data-table class="elevation-0 "
                :headers="headers"
                :items="productQnaList"
                item-key="qnaNo"
                :expanded.sync="expanded"
                :single-expand="singleExpand"
                hide-default-footer
                show-expand
                :items-per-page="7"
                :page.sync="page"
                @page-count="pageCount = $event"
  >
    <template v-slot:expanded-item="{ headers, item }">
      <td :colspan="headers.length">

        <v-card style="width: 100%; height: auto; border: 1px solid transparent" flat>
          <v-layout style="height: 100%; width: 100%">

            <v-card width="100%" height="auto" flat color="#f5f5f5" style="border-bottom: 1px solid #eaebee" tile>

              <!--삭제버튼(본인글만 삭제 버튼 보이게)-->
              <span v-show="item.writer === $store.state.memberInfoAfterSignIn.nickname">
              <v-icon
                  style="color: #666666; margin-top: 5px; margin-left: 96%" @click="dialog = true">mdi-close-circle-outline</v-icon>
              <v-dialog
                  v-model="dialog"
                  max-width="500"
              >
                <v-card align="center">
                  <v-card-title class="justify-center">
                    정말 삭제하시겠습니까?
                  </v-card-title><br>
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
              </span>

              <v-card width="100%" flat color="#f5f5f5" style="padding-bottom: 0px">
                <v-card-subtitle style="width: 100%; font-size: 13px; padding-top: 0px; padding-bottom: 0px">
                  [{{ item.questionCategory }}] {{ item.title }}

                </v-card-subtitle>

                <v-card-title style="padding-top: 0px; font-weight: bolder; font-size: 20px; color: #2F4F4F">
                  Q
                  <v-card-title style="font-weight: normal; font-size: 15px" >
                    {{item.questionContent}}
                  </v-card-title>
                </v-card-title>

              </v-card>


              <v-card
                  width="100%" height="auto" flat color="#f5f5f5" style="border-top: 1px solid transparent" tile
                  class="card-p"
                  v-show="item.answerStatus != 'BEFORE_ANSWER'"
              >
                <v-card-title style="font-weight: bolder; font-size: 20px; color: #DAA520" >
                  A

                  <v-card-title style="font-weight: normal; font-size: 15px;" >
                    아직 답변이 등록되지 않았습니다.
                  </v-card-title>
                </v-card-title>

              </v-card>

              <v-card
                  width="100%" height="auto" flat color="#f5f5f5" style="border-top: 1px solid transparent" tile
                  class="card-p"
                  v-show="item.answerStatus == 'ANSWER_COMPLETE'"
              >

                <v-card-title style="font-weight: bolder; font-size: 20px; color: #DAA520" >
                  A

                  <v-card-title style="font-weight: normal; font-size: 15px" >
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
      <v-alert :value="true" color="transparent" >
        등록된 문의가 없습니다.
      </v-alert>
    </template>

    <!--답변상태 chip-->
    <template v-slot:[`item.answerStatus`]="{ item }">
      <v-chip color="green"
              small
              outlined
              v-if="item.answerStatus === '답변 완료'">
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
    <template v-slot:[`item.questionTitle`]="{ item }">
      <span style="color: grey; font-family: 'Nanum Gothic'"
            v-if="item.openStatus === false">
              {{ item.questionTitle }} <v-icon size="20" color="grey">mdi-lock-outline</v-icon>
      </span>

      <span style="color: black; font-family: 'Nanum Gothic'"
            v-else>
              {{ item.questionTitle }}
      </span>
    </template>

    <!--Date format-->
    <template v-slot:[`item.regDate`]="{ item }">
            <span style="font-weight: normal; color: #2F4F4F">
              {{ item.regDate | date }}
            </span>
    </template>

    <!--본인이 작성한 글이 아닐시 닉네임 가리기-->
    <template v-slot:[`item.writer`]="{ item }">
      <span style="font-weight: normal; color: #2F4F4F"
      v-if="item.writer !== $store.state.memberInfoAfterSignIn.nickname">
              {{ item.writer | nameFormat }}
      </span>
      <span style="font-weight: normal; color: #2F4F4F"
            v-if="item.writer === $store.state.memberInfoAfterSignIn.nickname">
              {{ item.writer }}
      </span>
    </template>

    <!--본인글 아닌 비밀글 열람 불가-->
    <template v-slot:[`item.data-table-expand`]="{ item, expand, isExpanded }">
      <span style="font-weight: normal; color: #2F4F4F"
            v-if="item.writer !== $store.state.memberInfoAfterSignIn.nickname && item.openStatus === false">
      </span>

      <span v-else>
          <v-btn icon
                 @click="expand(!isExpanded)"
                 class="v-data-table__expand-icon"
                 :class="{'v-data-table__expand-icon--active' : isExpanded}">
            <v-icon>mdi-chevron-down</v-icon>
          </v-btn>
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
</template>

<script>
import {mapActions, mapState} from "vuex";

export default {
  name: "QnaForm",
  props: {
    productNo: {
      type: String,
      required: true,
    },
  },
  computed: {
    ...mapState([
        'productQnaList'
    ])
  },
  data() {
    return {
      expanded: [],
      singleExpand: true,
      page: 1,
      pageCount: 0,

      headers: [
        { text: '제목', value: 'questionTitle', width: "300px" },
        { text: '작성자', value: 'writer', width: "70px" },
        { text: 'date ', value: 'regDate', width: "100px" },
        { text: '답변상태 ', value: 'answerStatus', width: "50px" },
        {text:'', value:'data-table-expand' ,width:'5px'}
      ],

      dialog : false,

    }
  },
  filters: {
    date : function(data){
      const reqdString = data.split("").slice(0, 10).join("");
      if (data.length < 10) {
        return reqdString
      } else {
        return reqdString ;
      }
    },
    nameFormat(val){
      return String(val).replace(/(?<=.{2})./gi,"*");
    }
  },
  methods: {
    ...mapActions([
        'requestProductQnaListFromSpring',
        'requestDeleteQnaFromSpring'
    ]),
    onDelete (qnaNo) {
      console.log("qnaNo: " + qnaNo)
      this.requestDeleteQnaFromSpring(qnaNo)
    }
  },
  async mounted() {
    const productNo = this.productNo
    await this.requestProductQnaListFromSpring(productNo)
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