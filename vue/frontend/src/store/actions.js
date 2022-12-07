import {
    REQUEST_ID_PASS_CHECK, REQUEST_SIGN_IN_TOKEN_FROM_SPRING,

} from './mutation-types'

import axios from 'axios'
import router from "@/router";

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

        const {nickname} = payload

        return axios.post(`http://localhost:8888/member/check-nickname/${nickname}`)
            .then((res) => {
                if (res.data) {
                    alert("사용 가능한 닉네임입니다.")
                    commit(REQUEST_ID_PASS_CHECK, res.data)
                } else {
                    alert("이미 등록되어 있는 닉네임입니다.")
                }
            })
    },
    /**
     * 판매자 회원가입 요청 axios
     * @param payload
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    // eslint-disable-next-line no-empty-pattern
    requestSellerRegisterToSpring( { }, payload) {
        console.log('requestSellerRegisterToSpring')

        const { memberId, password, nickName,  memberType} = payload

        return axios.post('http://localhost:8888/member/register', { memberId, password, nickName, memberType })
            .then((res) => {
                if(res.data) {
                    alert("회원 가입이 완료되었습니다! 로그인 페이지로 이동합니다.")
                    router.push({ name: 'SignInView' });
                }
            })
            .catch((error) => {
                alert(error)
            })
    },
    /**
     * 일반회원 가입 요청 axios
     * @param payload
     * @returns {Promise<axios.AxiosResponse<any>>}
     */
    // eslint-disable-next-line no-empty-pattern
    requestBuyerRegisterToSpring( { }, payload) {
        console.log('requestBuyerRegisterToSpring')

        const { memberId, password, nickname,  memberType} = payload

        return axios.post('http://localhost:8888/member/register', { memberId, password, nickname, memberType })
            .then((res) => {
                if(res.data) {
                    alert("회원 가입이 완료되었습니다! 로그인 페이지로 이동합니다.")
                    router.push({ name: 'SignInView' });
                }
            })
            .catch((error) => {
                alert(error)
            })
    },

    requestBuyerSignInToSpring( { commit }, payload) {
        console.log('requestBuyerSignInToSpring')

        const { memberId, password } = payload

        return axios.post('http://localhost:8888/member/sign-in', { memberId, password })
            .then((res) => {
                if(res.data) {
                    commit(REQUEST_SIGN_IN_TOKEN_FROM_SPRING, res.data)
                    router.push({ name: 'HomeView' });
                }
            })
            .catch((error) => {
                alert(error)
            })
    }
}