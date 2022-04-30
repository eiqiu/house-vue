export default {
    state:{
        categoryList: []
    },
    getters:{
        getCategoryList(state) {
            return state.categoryList;
        }
    },
    mutations: {
        setCategoryList(state, data) {
            state.categoryList = data;
        }
    },
    actions: {
        setCategoryList({commit}, data) {
            commit('setCategoryList', data);
        }
    }
}
