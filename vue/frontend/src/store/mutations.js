import {
    REQUEST_ID_PASS_CHECK,
    REQUEST_SIGN_IN_TOKEN_FROM_SPRING
} from './mutation-types'

export default {
    [REQUEST_ID_PASS_CHECK](state, passingData) {
        state.unDuplicateIdPass = passingData
    },
    [REQUEST_SIGN_IN_TOKEN_FROM_SPRING] (state, passingData) {
        state.userToken = passingData
    }
}