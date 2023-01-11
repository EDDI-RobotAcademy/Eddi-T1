<template>

  <div>

  <hr color="#DAA520" width="100%">
  <v-data-table class="elevation-0 "
                :headers="headers"
                :items="qnaLists"
                item-key="qnaNo"
                :expanded.sync="expanded"
                :single-expand="singleExpand"
                hide-default-footer
                show-expand
                :items-per-page="7"
                :page.sync="page"
                @page-count="pageCount = $event"
  >
    <template v-slot:expanded-item="{ headers }">
      <td :colspan="headers.length">


          <v-card style="width: 100%; height: auto; border: 1px solid transparent" flat>
            <v-layout style="height: 100%; width: 100%" justify-center>


              <v-card width="100%" height="auto" flat color="#f5f5f5" style="border-bottom: 1px solid #eaebee" tile>

                  <v-card width="100%" flat color="#f5f5f5">
                    <v-card-title style="font-weight: bolder; font-size: 20px; color: #2F4F4F">
                      Q
                    </v-card-title>
                    <v-card-title style="font-weight: normal; font-size: 15px; color: #2F4F4F">
                      <v-textarea
                          solo
                          flat
                          auto-grow
                          no-resize
                          readonly
                          background-color="transparent"
                          value="item.questionContent"
                          color="#f5f5f5"
                      ></v-textarea>
<!--                      지난주에 주문했는데 아직입니다. 배송언제오나요?-->
                    </v-card-title>
                  </v-card>


                <v-card width="100%" height="auto" flat color="#f5f5f5" style="border-top: 1px solid transparent" tile
                        class="card-p"
                >
                  <v-card-title style="font-weight: bolder; font-size: 20px; color: #DAA520" >
                    A
                  </v-card-title>
                  <v-card-title style="font-weight: normal; font-size: 15px; color: #DAA520">
                    <v-textarea
                        solo
                        flat
                        auto-grow
                        no-resize
                        readonly
                        background-color="transparent"
                        color="#f5f5f5"
                    ></v-textarea>
<!--                    안녕하세요. 판매자입니다
                    믿고 찾아주신 상품에 불편을 드려 정말 죄송합니다
                    고객님의 불편하셨던 사항은 고객행복센터를 통해 안내 받으신 점 확인하였습니다.
                    불편을 드려 정말 죄송할 따름이며, 고객님께 늘 최상의 상품을 불편 없이 전달드리기 위해 최선을 다하는 판매자 되겠습니다.
                    shop 드림-->
                  </v-card-title>
                </v-card>

              </v-card>

            </v-layout>
          </v-card>

      </td>
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
      <span style="color: grey"
            v-if="item.openStatus === 0">
       비밀글입니다. <v-icon size="20" color="grey">mdi-lock-outline</v-icon>
      </span>

      <span style="color: black"
            v-else>
       {{ item.questionTitle }}
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
export default {
  name: "QnaForm",
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

      qnaLists: [
        {
          qnaNo: 1,
          answer: '',
          regDate:'2022-12-11 10:38',
          answerStatus: '답변 대기',
          openStatus: 0,
          questionCategory: '배송 문의',
          questionContent: "지난주에 주문했는데 아직입니다. 배송언제오나요?",
          questionTitle: "배송 문의드립니다",
          writer: 'dada',
        },
        {
          qnaNo: 2,
          answer: '',
          regDate:'2023-02-11 10:38',
          answerStatus: '답변 완료',
          openStatus: 1,
          questionCategory: "환불 / 취소 문의",
          questionContent: "유통기한이 지난게 왔습니다 환불해주세요",
          questionTitle: "환불해주세요",
          writer: 'rara',
        },
        {
          qnaNo: 3,
          answer: '',
          regDate:'2023-02-11 10:38',
          answerStatus: '답변 완료',
          openStatus: 0,
          questionCategory: "환불 / 취소 문의",
          questionContent: "유통기한이 지난게 왔습니다 환불해주세요",
          questionTitle: "환불해주세요",
          writer: 'rara',
        },
        {
          qnaNo: 4,
          answer: '',
          regDate:'2023-02-11 10:38',
          answerStatus: '답변 완료',
          openStatus: 0,
          questionCategory: "환불 / 취소 문의",
          questionContent: "유통기한이 지난게 왔습니다 환불해주세요",
          questionTitle: "환불해주세요",
          writer: 'rara',
        },
        {
          qnaNo: 5,
          answer: '',
          regDate:'2023-02-11 10:38',
          answerStatus: '답변 완료',
          openStatus: 1,
          questionCategory: "환불 / 취소 문의",
          questionContent: "유통기한이 지난게 왔습니다 환불해주세요",
          questionTitle: "환불해주세요",
          writer: 'rara',
        },
        {
          qnaNo: 6,
          answer: '',
          regDate:'2023-02-11 10:38',
          answerStatus: '답변 완료',
          openStatus: 1,
          questionCategory: "환불 / 취소 문의",
          questionContent: "유통기한이 지난게 왔습니다 환불해주세요",
          questionTitle: "환불해주세요",
          writer: 'rara',
        },
        {
          qnaNo: 7,
          answer: '',
          regDate:'2023-02-11 10:38',
          answerStatus: '답변 완료',
          openStatus: 1,
          questionCategory: "환불 / 취소 문의",
          questionContent: "유통기한이 지난게 왔습니다 환불해주세요",
          questionTitle: "환불해주세요",
          writer: 'rara',
        },
        {
          qnaNo: 8,
          answer: '',
          regDate:'2023-02-11 10:38',
          answerStatus: '답변 완료',
          openStatus: 1,
          questionCategory: "환불 / 취소 문의",
          questionContent: "유통기한이 지난게 왔습니다 환불해주세요",
          questionTitle: "환불해주세요",
          writer: 'rara',
        },
        {
          qnaNo: 9,
          answer: '',
          regDate:'2022-12-11 10:38',
          answerStatus: '답변 대기',
          openStatus: 0,
          questionCategory: '배송 문의',
          questionContent: "지난주에 주문했는데 아직입니다. 배송언제오나요?",
          questionTitle: "배송 문의드립니다",
          writer: 'dada',
        },
      ],

    }
  },
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