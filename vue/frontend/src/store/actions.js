import {
    REQUEST_ID_PASS_CHECK, REQUEST_SIGN_IN_TOKEN_FROM_SPRING,

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
    requestSellerSignUpToSpring({}, payload) {
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
    requestBuyerSignUpToSpring({}, payload) {
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
    requestBuyerSignInToSpring({commit}, payload) {
        console.log('requestBuyerSignInToSpring')

        const {memberId, password, memberType} = payload

        axios.post('http://localhost:8888/member/sign-in', {memberId, password, memberType})
            .then((res) => {
                if (localStorage.getItem("userToken") == null) {
                    alert("로그인 되었습니다.")
                    commit(REQUEST_SIGN_IN_TOKEN_FROM_SPRING, res.data)
                    states.userToken = res.data.userToken

                    if (localStorage.getItem("userToken") != states.userToken){
                        store.commit("USER_TOKEN", res.data.userToken)
                    }

                    store.commit('SING_IN_CHECK_VALUE', true)
                    router.push({name: "HomeView"})
                } else {
                    alert("이미 로그인 되어있습니다.")
                }
            })
            .catch(() => {
                alert("아이디 혹은 비밀번호가 존재하지 않거나 틀렸습니다.")
            })
    },

}