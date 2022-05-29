/**
 * 但是如果需要vuex中的多个数据的这时候，这样写就太啰嗦了，我们可以将它定义在computed中
 * props，methods,data和 computed 的初始化都是在 beforeCreated和 created之间完成的。
 */
export default {
    // state 类似vue中的data，通过stste来存放共享的状态
    state: {
        user: "", // 登录的用户
        showLogin: false, // 用于控制是否显示登录组件
        showInformation: false, // 展示个人信息界面
        showMessage: false // 消息显示组件
    },
    // getters相当于vue中的计算属性，能拿到state里面最新的值,而且getters允许传参，第一个参数就是state
    getters: {
        getUser (state) {
            return state.user
        },
        getShowLogin (state) {
            return state.showLogin
        },
        getShowInformation (state) {
            return state.showInformation
        },
        getShowMessage (state) {
            return state.showMessage
        }
    },
    mutations: {
        setUser (state, data) {
            state.user = data;
        },
        setShowLogin (state, data) {
            state.showLogin = data;
        },
        setShowInformation (state, data) {
            state.showInformation = data
        },
        setShowMessage (state, data) {
            state.showMessage = data
        }
    },
    actions: {
        setUser ({ commit }, data) {
            commit('setUser', data);
        },
        setShowLogin ({ commit }, data) {
            commit('setShowLogin', data);
        },
        setShowInformation ({ commit }, data) {
            commit('setShowInformation', data);
        },
        setShowMessage({ commit }, data) {
            commit('setShowMessage', data)
        }
    }
}
