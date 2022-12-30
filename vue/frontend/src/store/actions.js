import {
    REQUEST_ID_PASS_CHECK, REQUEST_SIGN_IN_TOKEN_FROM_SPRING,
    REQUEST_SHOPPING_BUCKET_ITEM_LIST_TO_SPRING,
    REQUEST_PRODUCT_LIST_BY_HANDMADE_TO_SPRING,
    REQUEST_PRODUCT_LIST_BY_KNOWHOW_TO_SPRING,
    REQUEST_PRODUCT_LIST_BY_HOBBY_TO_SPRING,
    REQUEST_PRODUCT_IMG_LIST_BY_HANDMADE,
    REQUEST_PRODUCT_IMG_LIST_BY_KNOWHOW,
    REQUEST_PRODUCT_IMG_LIST_BY_HOBBY
} from './mutation-types'

import axios from 'axios'
import router from "@/router";
import states from "@/store/states";
import store from "@/store/index";

export default {
    /**
     * 아이디 중복 확인 요청 axios
     * @param commit
     * @param payload memberId
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    requestCheckDuplicateIdToSpring({commit}, payload) {
        console.log('requestCheckDuplicateIdToSpring()')

        const {memberId} = payload

        return axios.post(`http://localhost:8888/member/check-id/${memberId}`)
            .then((res) => {
                if (res.data) {
                    alert("사용 가능한 아이디입니다.")
                    commit(REQUEST_ID_PASS_CHECK, res.data)
                } else {
                    alert("이미 등록되어 있는 아이디입니다.")
                }
            })
    },
    /**
     * 닉네임 중복 확인 axios
     * @param commit
     * @param payload nickname
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    requestCheckDuplicateNicknameToSpring({commit}, payload) {
        console.log('requestCheckDuplicateNicknameToSpring()')

        const {nickname, memberType} = payload

        return axios.post(`http://localhost:8888/member/check-nickname/${nickname}`)
            .then((res) => {
                if (res.data) {
                    alert(`사용 가능한 ${memberType}입니다.`)
                    commit(REQUEST_ID_PASS_CHECK, res.data)
                } else {
                    alert(`이미 등록되어 있는 ${memberType}입니다.`)
                }
            })
    },
    /**
     * 판매자 회원가입 요청 axios
     * @param payload memberId, nickname, password, memberType
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    // eslint-disable-next-line no-empty-pattern
    requestSellerSignUpToSpring({ }, payload) {
        console.log('requestSellerSignUpToSpring')

        const {memberId, nickname, password, memberType} = payload

        return axios.post('http://localhost:8888/member/sign-up', {memberId, nickname, password, memberType})
            .then((res) => {
                if (res.data) {
                    alert("회원 가입이 완료되었습니다! 로그인 페이지로 이동합니다.")
                    router.push({name: 'SignInView'});
                }
            })
            .catch((error) => {
                alert(error)
            })
    },
    /**
     * 일반회원 가입 요청 axios
     * @param payload memberId, nickname, password, memberType
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    // eslint-disable-next-line no-empty-pattern
    requestBuyerSignUpToSpring({ }, payload) {
        console.log('requestBuyerSignUpToSpring')

        const {memberId, nickname, password, memberType} = payload

        return axios.post('http://localhost:8888/member/sign-up', {memberId, nickname, password, memberType})
            .then((res) => {
                if (res.data) {
                    alert("회원 가입이 완료되었습니다! 로그인 페이지로 이동합니다.")
                    router.push({name: 'SignInView'});
                }
            })
            .catch((error) => {
                alert(error)
            })
    },
    /**
     * 로그인 요청 axios
     * @param commit Token
     * @param payload memberId, password
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    async requestBuyerSignInToSpring({commit}, payload) {
        console.log('requestBuyerSignInToSpring')

        const {memberId, password, memberType} = payload

        await axios.post('http://localhost:8888/member/sign-in', {memberId, password, memberType})
            .then((res) => {
                if (localStorage.getItem("userToken") == null){
                    alert("로그인 되었습니다.")
                    commit(REQUEST_SIGN_IN_TOKEN_FROM_SPRING, res.data)
                    states.userToken = res.data.userToken

                    if (localStorage.getItem("userToken") != states.userToken){
                        store.commit("USER_TOKEN", res.data.userToken)
                    }

                    store.commit('SING_IN_CHECK_VALUE', true)

                    if (res.data.memberType == "일반회원"){
                        router.push({name: "HomeView"})
                    } else if (res.data.memberType == "판매자") {
                        router.push({name: "OrderManageView"})
                    }

                } else {
                    alert("이미 로그인 되어있습니다.")
                }
            })
            .catch(() => {
                alert("아이디 혹은 비밀번호가 존재하지 않거나 틀렸습니다.")
            })
    },
    /**
     * 닉네임 수정 axios
     * @param commit
     * @param payload nickname
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    // eslint-disable-next-line no-empty-pattern
    async requestNicknameModifyFromSpring({ },payload){
        console.log("requestNicknameModifyFromSpring")
        console.log(payload)
        const {nickname, currentNickname} = payload

        await axios.post('http://localhost:8888/member/nickname-modify', {nickname, currentNickname})
            .then((res) => {
                store.commit("REQUEST_NICKNAME_MODIFY_FROM_SPRING", res.data)
                alert("수정 되었습니다.")
            });
    },
    /**
     * 회원탈퇴 axios
     * @param commit
     * @param payload nickname
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    // eslint-disable-next-line no-empty-pattern
    async requestCurrentUserAccountDropToSpring({ }, payload) {
        console.log("requestCurrentUserAccountDropToSpring")
        const  {currentUserToken} = payload

        await axios.post(`http://localhost:8888/member/memberDrop/${currentUserToken}`)
            .then(() => {
                localStorage.removeItem("vuex")
                store.commit("SING_IN_CHECK_VALUE", false)
            });
    },

    /**
     *  상품 등록 axios
     *  @param commit
     *  @param payload title, category, stock, price, deliveryFee, content, files, information, writer
     *  @returns {Promise<axios.AxiosResponse<any>>}
     */
    // eslint-disable-next-line no-empty-pattern
    requestRegisterProductToSpring({ }, payload) {
        console.log('requestRegisterProductToSpring()')

        const { title, category, stock, price, deliveryFee, content, files, infoNotice, nickname} = payload

        let formData = new FormData()
        let product = {
            title, category, stock, price, deliveryFee, content, infoNotice, nickname
        }
        formData.append('product', new Blob([JSON.stringify(product)], {type: "application/json"}))

        for (let i = 0; i < files.length; i++) {
            formData.append('files', files[i].file)
        }

        axios.post('http://localhost:8888/product/register', formData, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        })
            .then(() => {
                alert('상품이 등록되었습니다')
                router.push({name: 'ProductManageView'})
            })
            .catch(() => {
                alert('오류가 발생하였습니다.')
            })
    },

    /**
     *  일반회원 사용자 장바구니 상품 리스트 요청 axios
     *  @param commit
     *  @param payload memberToken
     *  @returns {Promise<axios.AxiosResponse<any>>}
     */
    async requestShoppingBucketItemListToSpring({commit}, payload) {
        console.log('requestShoppingBucketItemListToSpring')

        const nickname = payload

        await axios.post(`http://localhost:8888/order/shopping-bucket-list/${nickname}`)
            .then((res) => {
                commit(REQUEST_SHOPPING_BUCKET_ITEM_LIST_TO_SPRING,res.data)
            });
    },

    /**
     *  메인페이지 카테고리별 상품 요청 axios
     *  @param commit
     *  @param payload category, productSize
     *  @returns {Promise<axios.AxiosResponse<any>>}
     */
    async requestProductListByCategoryToSpring({ commit }, payload) {
        console.log("requestProductListByCategoryToSpring")


        await axios.get('http://localhost:8888/product/list', {
            params: {
                category: payload.category,
                productSize: payload.productSize
            }})
            .then((res) => {
                if (payload.category == "핸드메이드"){
                    commit(REQUEST_PRODUCT_LIST_BY_HANDMADE_TO_SPRING, res.data)
                } else if (payload.category == "노하우") {
                    commit(REQUEST_PRODUCT_LIST_BY_KNOWHOW_TO_SPRING, res.data)
                } else {
                    commit(REQUEST_PRODUCT_LIST_BY_HOBBY_TO_SPRING, res.data)
                }
            });
    },

    /**
     *  메인페이지 카테고리별 상품 이미지 요청 axios
     *  @param commit
     *  @param payload productNo, category
     *  @returns {Promise<axios.AxiosResponse<any>>}
     */
    async requestProductImgListToSpring({ commit }, payload) {
        console.log("requestProductImgListToSpring")
        const {productNo, category} = payload

        await axios.get(`http://localhost:8888/product/image/thumbnail/${productNo}`)
            .then((res) => {

                if (category == '핸드메이드'){
                    commit(REQUEST_PRODUCT_IMG_LIST_BY_HANDMADE, res.data.editedName)
                } else if (category == '노하우') {
                    commit(REQUEST_PRODUCT_IMG_LIST_BY_KNOWHOW, res.data.editedName)
                } else {
                    commit(REQUEST_PRODUCT_IMG_LIST_BY_HOBBY, res.data.editedName)
                }
            });
    },

    /**
     * 사업자정보 입력후 사업자등록 요청 axios.
     * @param payload
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    // eslint-disable-next-line no-empty-pattern
    requestRegisterSellerInfoToSpring ({ }, payload) {
        console.log('requestRegisterSellerInfoToSpring()')

        const { seller,  city, street, addressDetail, zipcode, companyPhoneNumber, companyRegisterNumber } = payload
        return axios.post('http://localhost:8888/seller-info/register',
            { seller,  city, street, addressDetail, zipcode, companyPhoneNumber, companyRegisterNumber })
            .then(() => {
                alert('사업자 등록 성공')
                router.push({name: 'ProductManageView'})
            })
            .catch(() => {
                alert('오류가 발생하였습니다.')
            })
    },
}