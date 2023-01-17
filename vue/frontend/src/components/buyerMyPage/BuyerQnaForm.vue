<template>
  <div>
    <buyer-nav/>

    <v-container style="width: 1400px">
      <buyer-my-page-top-nav :countByInfo="countByInfo"/>


      <div style="margin-top: 80px">
        <v-card-title style="font-size: 20px; font-weight: bold; color: #2F4F4F">
          <v-icon size="30" color="#2F4F4F">mdi-bullhorn-variant-outline</v-icon>&nbsp;
          {{ this.$store.state.memberInfoAfterSignIn.nickname }}님의 상품 문의
          <v-spacer></v-spacer>
          총 {{ myQnaList.length }}건
        </v-card-title>

        <hr color="#DAA520" width="100%">
        <v-data-table class="elevation-0 "
                      :headers="headers"
                      :items="myQnaList"
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

                  <v-card width="100%" height="auto" flat color="#f5f5f5" style="border-bottom: 1px solid #eaebee" tile>

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
                        [{{ item.nickname }}] {{ item.title }}

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
                        v-show="item.answerStatus != '답변 완료'"
                    >
                      <v-card-title style="font-weight: bolder; font-size: 20px; color: #DAA520">
                        A

                        <v-card-title style="font-weight: normal; font-size: 15px;">
                          아직 답변이 등록되지 않았습니다.
                        </v-card-title>
                      </v-card-title>

                    </v-card>

                    <v-card
                        width="100%" height="auto" flat color="#f5f5f5" style="border-top: 1px solid transparent" tile
                        class="card-p"
                        v-show="item.answerStatus == '답변 완료'"
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

          <!--문의유형 표시-->
          <template v-slot:[`item.questionCategory`]="{ item }">
            <span style="font-weight: normal; color: #2F4F4F">
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

  </div>
</template>

<script>
import BuyerNav from "@/components/buyerMyPage/BuyerNav";
import {mapActions, mapState} from "vuex";
import BuyerMyPageTopNav from "@/components/buyerMyPage/BuyerMyPageTopNav";

export default {
  name: "BuyerQnaForm",
  components: {BuyerMyPageTopNav, BuyerNav},
  computed: {
    ...mapState([
      'myQnaList',
      'myOrderInfoList',
      'myReviewList',
      'recentlyViewedProductList'
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
        {text: '제목', value: 'questionTitle', width: "300px"},
        {text: 'date ', value: 'regDate', width: "100px"},
        {text: '답변상태 ', value: 'answerStatus', width: "50px"},
      ],
      dialog: false,
      countByInfo: []
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
      'requestDeleteQnaFromSpring'
    ]),
    expandRow(item, event) {
      if (event.isExpanded) {
        var index = this.expanded.findIndex(i => i === item);
        this.expanded.splice(index, 1)
      } else {
        this.expanded.push(item);
      }
    },

    onDelete(qnaNo) {
      console.log("qnaNo: " + qnaNo)
      this.requestDeleteQnaFromSpring(qnaNo)
    }
  },
  async created() {
    const infoNum = new Array
    infoNum.push(this.myOrderInfoList.length)
    infoNum.push(this.myQnaList.length)
    infoNum.push(this.myReviewList.length)
    infoNum.push(this.recentlyViewedProductList.length)

    this.countByInfo = infoNum
  }
}
</script>

<style scoped>
.v-data-table >>> .v-data-table__wrapper tbody tr.v-data-table__expanded__content {
  box-shadow: none;
}
</style>