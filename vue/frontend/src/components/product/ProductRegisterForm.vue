<template>
  <div id='content'>
    <v-form enctype="multipart/form-data" @submit.prevent="onSubmit">
      <div id="title">
        <div>
          <v-layout>
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
                      <v-btn text color="red" @click="goBack()">
                        등록 취소
                      </v-btn>
                      <v-btn text @click="dialog.value=false">
                        계속 등록
                      </v-btn>
                    </v-card-actions>
                  </v-card>
                </template>
              </v-dialog>
            </v-layout>
          </div>
          <div><h2 style="margin-top: 6px; margin-left: 250px;" >상품 등록하기</h2></div>
        </div>


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
          <v-text-field outlined color="grey darken-1" dense placeholder="상품재고를 입력해주세요." v-model="stock">
          </v-text-field>
        </v-row>

        <!-- 가격 -->
        <v-row>
          <v-col cols="2" class="label" ><h4>가격</h4></v-col>
          <v-text-field outlined color="grey darken-1" dense placeholder="가격를 입력해주세요(원)." v-model="price">
          </v-text-field>

          <!-- 배송비 -->
          <v-col cols="2" class="label" align="center"><h4>배송비</h4></v-col>

          <v-text-field outlined color="grey darken-1" dense placeholder="배송비를 입력해주세요(원)." v-model="deliveryFee">
          </v-text-field>
        </v-row>

        <!-- 상세설명 -->
        <v-col cols="3" class="label2" style="font-weight:bold" >상품 상세 설명</v-col>
        <v-row>
          <v-textarea style="white-space:pre-line" cols="75" rows="15"
                      outlined color="grey darken-1" placeholder="상품 상세 정보를 입력해주세요."
                      v-model="content">
          </v-textarea>
        </v-row>


        <!-- 상품사진 -->
        <v-row>
          <v-col><h3>상품 사진 ({{files.length}}/10) </h3></v-col>
          <v-col id="image" cols="12">
              <label for="files"><v-icon large>mdi-camera</v-icon></label>
              <input
                  type="file"
                  id="files"
                  ref="files"
                  dense
                  style="width: 0px"
                  multiple
                  v-on:change="handleFileUpload()"
              />

              <v-carousel hide-delimiters height="auto">
                <v-carousel-item
                    v-for="(file, index) in files" :key="index" style="text-align:center">
                  <img :src=file.preview class="preview"/>
                </v-carousel-item>
              </v-carousel>
          </v-col>
        </v-row>



        <v-row justify>
          <v-col cols="12" class="label" >상품 정보 제공 고시</v-col>

          <v-text-field outlined color="grey darken-1" placeholder="상품명/ 제조자, 제조국 / 상품 관련 문의"
                        v-model="information">
          </v-text-field>
        </v-row>

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
      files: [],
      filesPreview:[],
      title:'',
      stock:'',
      price:'',
      deliveryFee:'',
      content:'',
      information:'',
      image:'',
      category: [],
      items: [
          '핸드메이드',
          '노하우',
          '취미/특기'
      ]
    }
  },
  methods: {
    onBoardSubmit() {
      const {title, content, writer, stock, price, deliveryFee, image, category, information} = this

      let formData = new FormData();

      for (let idx = 0; idx < this.$refs.files.files.length; idx++) {
        formData.append('file', this.$refs.files.files[idx])
      }

      formData.append('title', title)
      formData.append('content', content)
      formData.append('writer', writer)
      formData.append('stock', stock)
      formData.append('price', price)
      formData.append('deliveryFee', deliveryFee)
      formData.append('image', image)
      formData.append('category', category)
      formData.append('information', information)
      this.$emit('submit', {formData})
      console.log(formData)
    },

    goBack() {
      this.$router.go(-1);
    },

    handleFileUpload() {
      console.log(this.$refs.files.files)
      if (this.$refs.files.files.length > 10) {
        alert("선택할 수 있는 이미지 개수를 초과하였습니다.")
        document.getElementById("files").value = "";
        return
      } else {
        for (let i = 0; i < this.$refs.files.files.length; i++) {
          this.files = [
            ...this.files,
            {
              file: this.$refs.files.files[i],
              preview: URL.createObjectURL(this.$refs.files.files[i])
            }
          ]
        }
        console.log(this.files)
      }
    },
  }



    /*handleFilesUpload () {
      if(this.$refs.files.files.length > 9){
        alert("최대 9장 까지 가능 합니다")
        this.$refs.files.value = ''
        return
      }
      this.fileNum += this.$refs.files.files.length
      console.log(this.fileNum)
      if(this.fileNum < 10){
        for (let i = 0; i < this.$refs.files.files.length; i++) {
          this.files = [
            ...this.files,
            {
              file: this.$refs.files.files[i],
              preview: URL.createObjectURL(this.$refs.files.files[i])
            }
          ]
        }

      }else{
        alert("최대 9장 까지 가능 합니다")
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
*/

}
</script>

<style scoped>
table {
  margin-top: 50px;
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
  width: 100%;
  padding: 16px;
  resize: none;
}
.preview {
  position: relative;
  margin-left: auto;
  margin-right:auto;
  max-width:700px;
  height:350px;
}
</style>