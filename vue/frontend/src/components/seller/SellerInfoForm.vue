<template>

  <v-container>

    <!--Seller Navigation Drawer-->
    <seller-navi/>

    <!--Top bar-->
    <v-app-bar color="white" elevate-on-scroll height="80" app elevation="3">
      <v-toolbar-title class="ml-3" style="color: #2F4F4F">
        📌 Seller Profile
      </v-toolbar-title>
    </v-app-bar>


    <v-container
        id="seller-profile"
        fluid
        tag="section"
    >
      <v-row justify="center">
        <v-col
            cols="12"
            md="7"
        >

          <v-card>
            <v-form>
              <v-container class="py-0">
                <v-row>
                  <v-col
                      cols="12"
                      md="6"
                  >
                    <v-text-field
                        label="판매자명"
                        class="purple-input"
                    />
                  </v-col>

                  <v-col
                      cols="12"
                      md="6"
                  >
                    <v-text-field
                        label="업체명"
                        class="purple-input"
                    />
                  </v-col>

                  <v-col cols="12">
                    <v-text-field
                        label="업체주소"
                        class="purple-input"
                    />
                  </v-col>

                  <v-col
                      cols="12"
                      md="4"
                  >
                    <v-text-field
                        label="City"
                        class="purple-input"
                    />
                  </v-col>

                  <v-col
                      cols="12"
                      md="4"
                  >
                    <v-text-field
                        label="Country"
                        class="purple-input"
                    />
                  </v-col>

                  <v-col
                      cols="12"
                      md="4"
                  >
                    <v-text-field
                        class="purple-input"
                        label="Postal Code"
                        type="number"
                    />
                  </v-col>

                  <v-col cols="12">
                    <v-text-field
                        label="업체주소"
                        class="purple-input"
                    />
                  </v-col>



                  <v-col cols="12">
                    <v-textarea
                        class="purple-input"
                        label="About Me"
                        value="Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                    />
                  </v-col>

                  <v-col
                      cols="12"
                      class="text-right"
                  >

                    <v-btn
                        color="success"
                        class="mr-0"
                    >
                      Update Profile
                    </v-btn>
                  </v-col>
                </v-row>
              </v-container>
            </v-form>
          </v-card>

        </v-col>

        <v-col
            cols="12"
            md="4"
        >
          <v-card class="v-card-profile">


            <v-card-text class="text-center">

              <v-avatar
                :tile="tile"
                :size="100"
                color="grey lighten-4"
            >
              <img src="@/assets/default_profile_image.png" alt="avatar">

            </v-avatar>

              <h4 class="display-2 mb-1 grey--text">
                nickname
              </h4>

              <p class="font-weight-light grey--text">
                Don't be scared of the truth because we need to restart the human foundation in truth And I love you like Kanye loves Kanye I love Rick Owens’ bed design but the back is...
              </p>

              <v-btn
                  color="success"
                  rounded
                  class="mr-0"
              >
                Follow
              </v-btn>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-container>

  </v-container>

</template>

<script>
import SellerNavi from "@/components/seller/SellerNavi";

export default {
  name: "SellerInfoForm",
  components: {SellerNavi}
}
</script>

<style scoped>

</style>