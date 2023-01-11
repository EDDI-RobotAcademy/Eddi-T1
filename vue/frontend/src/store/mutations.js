import {
    REQUEST_ID_PASS_CHECK,
    REQUEST_SIGN_IN_TOKEN_FROM_SPRING,
    REQUEST_NICKNAME_MODIFY_FROM_SPRING,
    SING_IN_CHECK_VALUE,
    USER_TOKEN,
    REQUEST_SHOPPING_BUCKET_ITEM_LIST_TO_SPRING,
    REQUEST_PRODUCT_LIST_BY_HANDMADE_TO_SPRING,
    REQUEST_PRODUCT_LIST_BY_KNOWHOW_TO_SPRING,
    REQUEST_PRODUCT_LIST_BY_HOBBY_TO_SPRING,
    REQUEST_PRODUCT_IMG_LIST_BY_HANDMADE,
    REQUEST_PRODUCT_IMG_LIST_BY_KNOWHOW,
    REQUEST_PRODUCT_IMG_LIST_BY_HOBBY,
    REQUEST_PRODUCT_FROM_SPRING,
    REQUEST_PRODUCT_LIST_FROM_SPRING,
    REQUEST_MY_ORDER_INFO_LIST_FROM_SPRING,
    REQUEST_SEARCH_BY_SEARCH_TERM_TO_SPRING


} from './mutation-types'

export default {
    [REQUEST_ID_PASS_CHECK](state, passingData) {
        state.unDuplicateIdPass = passingData
    },
    [REQUEST_SIGN_IN_TOKEN_FROM_SPRING] (state, passingData) {
        state.memberInfoAfterSignIn = passingData
    },
    [REQUEST_NICKNAME_MODIFY_FROM_SPRING](state, passingData) {
        state.memberInfoAfterSignIn = passingData
    },
    [SING_IN_CHECK_VALUE](state, passingData) {
        state.signInCheckValue = passingData
    },
    [USER_TOKEN](state, passingData) {
        state.userToken = passingData
    },
    [REQUEST_SHOPPING_BUCKET_ITEM_LIST_TO_SPRING](state, passingData) {
        state.shoppingBucketProductItemList = passingData
    },
    [REQUEST_PRODUCT_LIST_BY_HANDMADE_TO_SPRING](state, passingData){
        state.mainPageProductListByHandmade = passingData
    },
    [REQUEST_PRODUCT_LIST_BY_KNOWHOW_TO_SPRING](state, passingData) {
        state.mainPageProductListByKnowHow = passingData
    },
    [REQUEST_PRODUCT_LIST_BY_HOBBY_TO_SPRING](state, passingData) {
        state.mainPageProductListByHobby = passingData
    },
    [REQUEST_PRODUCT_IMG_LIST_BY_HANDMADE](state, passingData) {
        state.mainPageProductImgListByHandmade.push(passingData)
    },
    [REQUEST_PRODUCT_IMG_LIST_BY_KNOWHOW](state, passingData) {
        state.mainPageProductImgListByKnowHOw.push(passingData)
    },
    [REQUEST_PRODUCT_IMG_LIST_BY_HOBBY](state, passingData) {
        state.mainPageProductImgListByHobby.push(passingData)
    },
    [REQUEST_PRODUCT_FROM_SPRING](state, passingData) {
        state.product = passingData
    },
    [REQUEST_PRODUCT_LIST_FROM_SPRING] (state, passingData) {
        console.log("mutation " + passingData[0])
        state.productList = passingData
    },
    [REQUEST_MY_ORDER_INFO_LIST_FROM_SPRING](state, passingData) {
        state.myOrderInfoList = passingData
    },
    [REQUEST_SEARCH_BY_SEARCH_TERM_TO_SPRING](state, passingData) {
        state.searchResultList = passingData
    },
}