<template>
  <div id='content'>
    <v-form @submit.prevent="onSubmit">

      <div id="title">
        <div>
          <v-layout>

            <!--뒤로가기-->
              <v-dialog persisten max-width="400">
                <template v-slot:activator="{ on }">
                  <v-icon v-on="on" large color="black">mdi-chevron-left</v-icon>
                </template>
                <template v-slot:default="dialog">
                  <v-card>
                    <v-card-title class="headline">
                      등록을 취소하시겠습니까?
                    </v-card-title>
                    <v-card-text >
                      * 작성하던 내용이 사라집니다
                    </v-card-text>
                    <v-card-actions>
                      <v-spacer></v-spacer>
                      <v-btn text color="#DAA520" @click="goBack()">
                        등록 취소
                      </v-btn>
                      <v-btn text @click="dialog.value=false">
                        계속 등록
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </template>
              </v-dialog>

            <v-col>
              <div>
                <h2>상품 등록하기</h2>
              </div>
            </v-col>
          </v-layout>
        </div>
      </div>

     <br/>


      <table>
        <!-- 상품명 -->
        <v-row>
          <v-col cols="2" class="label" ><h4>상품명</h4></v-col>

          <v-text-field outlined color="grey darken-1" placeholder="상품명를 입력해주세요."
                        v-model="title">
          </v-text-field>
        </v-row>


        <!-- 카테고리 -->
        <v-row>
          <v-col cols="2" class="label" ><h4>카테고리</h4></v-col>
          <v-combobox
              class="titleFloat"
              v-model="category"
              :items="items"
              label="category"
              filled
              style="width:200px; zoom:1"
              outlined
              dense
              color="grey darken-1">
          </v-combobox>


          <!-- 상품재고 -->
          <v-col cols="2" class="label" align="center"><h4>상품재고</h4></v-col>
          <v-text-field
              class="puple-input"
              type="number"
              outlined color="grey darken-1"
              dense
              placeholder="상품재고를 입력해주세요."
              v-model="stock">
          </v-text-field>
        </v-row>


        <!-- 가격 -->
        <v-row>
          <v-col cols="2" class="label" ><h4>가격</h4></v-col>
          <v-text-field
              class="puple-input"
              type="number"
              outlined color="grey darken-1"
              dense
              placeholder="가격를 입력해주세요(원)."
              v-model="price">
          </v-text-field>


          <!-- 배송비 -->
          <v-col cols="2" class="label" align="center"><h4>배송비</h4></v-col>

          <v-text-field
              class="puple-input"
              type="number"
              outlined color="grey darken-1"
              dense
              placeholder="배송비를 입력해주세요(원)."
              v-model="deliveryFee">
          </v-text-field>
        </v-row>



        <!-- 상세설명 -->
        <v-col cols="3" class="label2" ><h3>상품 상세 설명</h3></v-col>
        <v-row>
          <v-textarea style="white-space:pre-line" cols="75" rows="15"
                      outlined color="grey darken-1" placeholder="상품 상세 정보를 입력해주세요."
                      v-model="content">
          </v-textarea>
        </v-row>


        <!-- 사진 -->
        <p class="productImg"></p>
        <p class="productImgLabel"></p>

        <h3>상품 사진 ({{files.length}}/10) </h3>
        <span>* 최대 10장까지 등록 가능합니다.</span>

        <v-row id="image">
          <div v-if="this.files.length < 10">
            <input type="file" id="files" ref="files"
                   multiple v-on:change="handleFilesUpload()" hidden />
            <v-btn @click="chooseFile"  class="vbtn" color="#DAA520" style="color: white">
              이미지 업로드
            </v-btn>

          </div>

          <div v-else class="cancelFile">
            <v-btn @click="cancelFile" color="#DAA520" style="color: white">
              전체 취소
            </v-btn>
          </div>

          <div>
            <table>
              <tr>
                <td v-for="(none, index) in notImage" :key="index" >
                  <div v-if="files[index] == null">
                    <v-icon>
                      mdi-image
                    </v-icon>
                  </div>
                  <div v-else>
                    <img :src="files[index].preview" class="preview" width="100px" height="100px"/>
                    <v-icon @click="imgCancel(index)">
                      mdi-close
                    </v-icon>
                  </div>
                </td>
              </tr>

            </table>
          </div>


        </v-row>


        <!-- 상품 정보 제공 고시 -->
        <v-row justify>
          <v-col cols="12" class="label" >상품 정보 제공 고시</v-col>

          <v-text-field outlined color="grey darken-1" placeholder="상품명/ 제조자, 제조국 / 상품 관련 문의"
                        v-model="infoNotice">
          </v-text-field>
        </v-row>


        <!-- 등록하기 -->
        <v-row justify>
          <v-btn type="submit" block x-large color="#2F4F4F" style="color: white">
            등록하기
          </v-btn>
        </v-row>

      </table>
    </v-form>
  </div>

</template>

<script>
export default {
  name: "ProductRegisterForm",
  data() {
    return {
      title:'',
      category: [],
      items: [
        '핸드메이드',
        '노하우',
        '취미/특기'
      ],
      stock:'',
      price:'',
      deliveryFee:'',
      content:'',
      infoNotice:'',

      files: [],
      notImage: ['','','','','','','','','',''],
      fileNum: 0,

      nickname: '',
    }
  },
  mounted() {
    this.nickname = this.$store.state.memberInfoAfterSignIn.nickname
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },

    onSubmit () {
      if(this.files.length < 3) {
        alert('사진은 3장 이상 첨부해주세요')
      } else {
        const { title, category, stock, price, deliveryFee, content, files, infoNotice, nickname } = this
        this.$emit('submit', {  title, category, stock, price, deliveryFee, content, files, infoNotice, nickname  })
      }
    },

    handleFilesUpload () {
      if(this.$refs.files.files.length > 10) {
        alert("최대 10장까지 가능합니다!")
        this.$refs.files.value = ''
        return
      }
      this.fileNum += this.$refs.files.files.length
      console.log(this.fileNum)
      if(this.fileNum < 11){
        for (let i = 0; i < this.$refs.files.files.length; i++) {
          this.files = [
            ...this.files,
            {
              file: this.$refs.files.files[i],
              preview: URL.createObjectURL(this.$refs.files.files[i])
            }
          ]
        }

      }else {
        alert("최대 10장까지 가능합니다!")
        console.log(this.fileNum)
        this.fileNum -= this.$refs.files.files.length
        this.$refs.files.value = ''
      }

    },

    chooseFile() {
      document.getElementById("files").click()
    },

    cancelFile() {
      this.files = ''
      this.fileNum = 0
    },
    imgCancel(index) {
      //인덱스 어디부터 하나 삭제
      this.files.splice(index,1)
      this.fileNum -= 1
      console.log(this.files)
    }
  }
}

</script>

<style scoped>
table {
  margin-top: 10px;
  width: 100%;
}
.label2{
  margin-top: 20px;
}
#content{
  display: block;
  margin-top: 72px;
  margin: 30px;
  border: 1px solid #e9ecef;
  width: 800px;
  margin: 0 auto;
  padding: 40px;
  line-height: 24px;
  background: #fff;
  margin-bottom: 50px;
}
#title{
  display:flex;
}
#image{
  border: 2px solid #eaebee;
  box-sizing: border-box;
  border-radius: 6px;
  width: 104%;
  padding: 16px;
  resize: none;
}
.preview {
  position: sticky;
  margin-left: auto;
  margin-right:auto;
  max-width:60px;
  height:60px;
}
.productImg {
  margin: 20px 50px 10px 50px;
}
.productImgLabel  {
  font-size: 14px;
  position: relative;
  left: 50px;
  top: 30px;
}
#files {
  margin: 30px;
}
.vbtn {
  position: relative;
  left: 440%;
  bottom: 5px;
}
.cancelFile {
  position: relative;
  left: 85%;
  bottom: 5px;
}
td {
  border: 1px solid lightgray;
  width: 100px;
  height: 100px;
  text-align: center;
}
span {
  position: relative;
  left: 22%;
  bottom: 22px;
  font-size: 12px;
}
</style>