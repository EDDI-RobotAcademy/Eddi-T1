import {
    REQUEST_ID_PASS_CHECK,

} from './mutation-types'

export default {
    [REQUEST_ID_PASS_CHECK](state, passingData) {
        state.unDuplicateIdPass = passingData
    }
}