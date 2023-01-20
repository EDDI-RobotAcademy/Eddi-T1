import {
    REQUEST_ID_PASS_CHECK,
    REQUEST_SIGN_IN_TOKEN_FROM_SPRING,
    REQUEST_NICKNAME_MODIFY_FROM_SPRING,
    SIGN_IN_CHECK_VALUE,
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
    REQUEST_SEARCH_BY_SEARCH_TERM_TO_SPRING,
    REQUEST_PRODUCT_LIST_NEXT_PAGE_BY_CATEGORY_TO_SPRING,
    REQUEST_PRODUCT_LIST_IMG_NEXT_PAGE_BY_CATEGORY_TO_SPRING,
    REQUEST_MY_QNA_LIST_FROM_SPRING,
    REQUEST_SELLER_ORDER_LIST_FROM_SPRING,
    REQUEST_HANDMADE_PRODUCT_RATING_VALUE_TO_SPRING,
    REQUEST_KNOWHOW_PRODUCT_RATING_VALUE_TO_SPRING,
    REQUEST_HOBBY_PRODUCT_RATING_VALUE_TO_SPRING,
    REQUEST_PRODUCT_QNA_LIST_FROM_SPRING,
    REQUEST_PRODUCT_REVIEW_LIST_FROM_SPRING,
    REQUEST_REVIEW_IMAGE_FROM_SPRING,
    REQUEST_REVIEW_CNT_FROM_SPRING,
    REQUEST_QNA_LIST_BY_BEFORE_ANSWER_FROM_SPRING,
    REQUEST_QNA_LIST_BY_COMPLETE_FROM_SPRING,
    REQUEST_MY_REVIEW_LIST_TO_SPRING,
    REQUEST_PRODUCT_RATING_VALUE_TO_SPRING,
    REQUEST_PRODUCT_READ_RATING_VALUE_TO_SPRING,
    REQUEST_SELLER_ORDER_LIST_COUNT_FROM_SPRING,
    REQUEST_REVIEW_WRITE_CHECK_FROM_SPRING,
    REQUEST_SELLER_INFO_TO_SPRING,
    REQUEST_SELLER_TOTAL_INFO_FROM_SPRING,
    REQUEST_REVIEW_CNT_BY_HANDMADE_FORM_SPRING,
    REQUEST_REVIEW_CNT_BY_KNOWHOW_FORM_SPRING,
    REQUEST_REVIEW_CNT_BY_HOBBY_FORM_SPRING,
    FAVORITE_PRODUCT_CHECK_VALUE,
    REQUEST_FAVORITE_PRODUCT_INFO_TO_SPRING,
    REQUEST_FAVORITE_PRODUCT_RATING_VALUE_TO_SPRING, REQUEST_PRODUCT_LIST_BY_FILTER_FROM_SPRING


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
    [SIGN_IN_CHECK_VALUE](state, passingData) {
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
    [REQUEST_PRODUCT_LIST_NEXT_PAGE_BY_CATEGORY_TO_SPRING](state, passingData){
        state.mainPageNextProductList = passingData
    },
    [REQUEST_PRODUCT_LIST_IMG_NEXT_PAGE_BY_CATEGORY_TO_SPRING](state, passingData) {
        state.mainPageNextProductImgList.push(passingData)
    },
    [REQUEST_MY_QNA_LIST_FROM_SPRING](state, passingData) {
        state.myQnaList = passingData
    },
    [REQUEST_SELLER_ORDER_LIST_FROM_SPRING](state, passingData) {
        state.sellerOrderList = passingData
    },
    [REQUEST_HANDMADE_PRODUCT_RATING_VALUE_TO_SPRING](state, passingData) {
        state.handmadeProductRatingValue.push(passingData)
    },
    [REQUEST_KNOWHOW_PRODUCT_RATING_VALUE_TO_SPRING](state, passingData) {
        state.knowhowProductRatingValue.push(passingData)
    },
    [REQUEST_HOBBY_PRODUCT_RATING_VALUE_TO_SPRING](state, passingData) {
        state.hobbyProductRatingValue.push(passingData)
    },
    [REQUEST_PRODUCT_QNA_LIST_FROM_SPRING](state, passingData) {
        state.productQnaList = passingData
    },
    [REQUEST_PRODUCT_REVIEW_LIST_FROM_SPRING](state, passingData) {
        state.productReviewList = passingData
    },
    [REQUEST_REVIEW_IMAGE_FROM_SPRING](state, passingData) {
        state.reviewImage.push(passingData)
    },
    [REQUEST_REVIEW_CNT_FROM_SPRING](state, passingData) {
        state.productReviewCnt = passingData
    },
    [REQUEST_QNA_LIST_BY_BEFORE_ANSWER_FROM_SPRING](state, passingData) {
        state.qnaBeforeAnswerList = passingData
    },
    [REQUEST_QNA_LIST_BY_COMPLETE_FROM_SPRING](state, passingData) {
        state.qnaCompleteList = passingData
    },
    [REQUEST_MY_REVIEW_LIST_TO_SPRING](state, passingData) {
        state.myReviewList = passingData
    },
    [REQUEST_PRODUCT_RATING_VALUE_TO_SPRING](state, passingData){
        state.productRatingValue.push(passingData)
    },
    [REQUEST_PRODUCT_READ_RATING_VALUE_TO_SPRING](state, passingData){
        state.productReadRatingValue = passingData
    },
    [REQUEST_SELLER_ORDER_LIST_COUNT_FROM_SPRING](state, passingData){
        state.sellerOrderListCount = passingData
    },
    [REQUEST_REVIEW_WRITE_CHECK_FROM_SPRING](state, passingData){
        state.reviewWriteCheckValue = passingData
    },
    [REQUEST_SELLER_INFO_TO_SPRING](state, passingData) {
        state.sellerInfoData = passingData
    },
    [REQUEST_SELLER_TOTAL_INFO_FROM_SPRING](state, passingData) {
        state.sellerTotalInfo = passingData
    },
    [REQUEST_REVIEW_CNT_BY_HANDMADE_FORM_SPRING](state, passingData){
        state.handmadeReviewCnt.push(passingData)
    },
    [REQUEST_REVIEW_CNT_BY_KNOWHOW_FORM_SPRING](state, passingData){
        state.knowhowReviewCnt.push(passingData)
    },
    [REQUEST_REVIEW_CNT_BY_HOBBY_FORM_SPRING](state, passingData){
        state.hobbyReviewCnt.push(passingData)
    },
    [FAVORITE_PRODUCT_CHECK_VALUE](state, passingData){
        if (passingData.category === '취미/특기'){

            if (state.hobbyFavoriteProductCheck[passingData.index].checkValue){
                state.hobbyFavoriteProductCheck[passingData.index].checkValue = false
                state.hobbyFavoriteProductCheck[passingData.index].productNo = 0

                for (let i = 0; i < state.favoriteProductList.length; i++) {
                    if (passingData.productNo == state.favoriteProductList[i].productNo) {
                        state.favoriteProductList.splice(i, 1)
                        i--
                    }
                }
            } else {
                state.hobbyFavoriteProductCheck[passingData.index].checkValue = true
                state.hobbyFavoriteProductCheck[passingData.index].productNo = passingData.productNo
                state.favoriteProductList.push(passingData.item)
            }

        } else if (passingData.category === '노하우'){
            if (state.knowhowFavoriteProductCheck[passingData.index].checkValue){
                state.knowhowFavoriteProductCheck[passingData.index].checkValue = false
                state.knowhowFavoriteProductCheck[passingData.index].productNo = 0

                for (let i = 0; i < state.favoriteProductList.length; i++) {
                    if (passingData.productNo == state.favoriteProductList[i].productNo) {
                        state.favoriteProductList.splice(i, 1)
                        i--
                    }
                }
            } else {
                state.knowhowFavoriteProductCheck[passingData.index].checkValue = true
                state.knowhowFavoriteProductCheck[passingData.index].productNo = passingData.productNo
                state.favoriteProductList.push(passingData.item)
            }

        } else {
            if (state.handmadeFavoriteProductCheck[passingData.index].checkValue){
                state.handmadeFavoriteProductCheck[passingData.index].checkValue = false
                state.handmadeFavoriteProductCheck[passingData.index].productNo = 0

                for (let i = 0; i < state.favoriteProductList.length; i++) {
                    if (passingData.productNo == state.favoriteProductList[i].productNo) {
                        state.favoriteProductList.splice(i, 1)
                        i--
                    }
                }
            } else {
                state.handmadeFavoriteProductCheck[passingData.index].checkValue = true
                state.handmadeFavoriteProductCheck[passingData.index].productNo = passingData.productNo
                state.favoriteProductList.push(passingData.item)
            }
        }
    },
    [REQUEST_FAVORITE_PRODUCT_INFO_TO_SPRING](state, passingData) {
        state.favoriteProductInfoList.push(passingData)
    },
    [REQUEST_FAVORITE_PRODUCT_RATING_VALUE_TO_SPRING](state, passingData) {
        state.favoriteProductRatingValue.push(passingData)
    },
    [REQUEST_PRODUCT_LIST_BY_FILTER_FROM_SPRING](state, passingData){
        state.productListByFilter = passingData
    },
}