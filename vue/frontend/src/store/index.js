import Vue from 'vue'
import Vuex from 'vuex'

import createPersistedState from "vuex-persistedstate"
import state from "@/store/states";
import actions from "@/store/actions";
import mutations from "@/store/mutations";
import getters from "@/store/getters";

Vue.use(Vuex)

export default new Vuex.Store({
  plugins:[
      createPersistedState({
        paths: [
            'signInCheckValue',
            'memberInfoAfterSignIn',
            'userToken',
            'searchResultList',
            'mainPageProductListByHandmade',
            'mainPageProductListByKnowHow',
            'mainPageProductListByHobby',
            'myOrderInfoList',
            'myReviewList',
            'hobbyFavoriteProductCheck',
            'knowhowFavoriteProductCheck',
            'handmadeFavoriteProductCheck',
            'favoriteProductList',
            'filterType'
        ]
      })
  ],
  state,
  actions,
  mutations,
  getters,
})
