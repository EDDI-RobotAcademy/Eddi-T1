import {
    REQUEST_ID_PASS_CHECK,

} from './mutation-types'

import axios from 'axios'

export default {

    requestCheckDuplicateIdToSpring({commit}, payload) {
        console.log('requestCheckDuplicateEmailToSpring()')

        const {memberId} = payload

        return axios.post('http://localhost:8888/member/check-id/${memberId}')
            .then((res) => {
                if (res.data) {
                    alert("사용 가능한 아이디입니다.")
                    commit(REQUEST_ID_PASS_CHECK, res.data)
                } else {
                    alert("이미 등록되어 있는 아이디입니다.")
                }
            })
    }
}