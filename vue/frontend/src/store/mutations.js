import {
    REQUEST_ID_PASS_CHECK,
    REQUEST_SIGN_IN_TOKEN_FROM_SPRING,
    REQUEST_NICKNAME_MODIFY_FROM_SPRING,
    SING_IN_CHECK_VALUE,
    USER_TOKEN,
    REQUEST_SHOPPING_BUCKET_ITEM_LIST_TO_SPRING

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

}