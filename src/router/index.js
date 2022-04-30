import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/house',
    name: 'House',
    component: () => import('../views/House')
  },
  {
    path: '/house/details',
    name: 'Details',
    component: () => import('../views/Detail')
  },
  {
    path: '/house/editMyHouse',
    name: 'EditMyHouse',
    component: () => import('../views/EditHouse')
  },
  {
    path: '/sellHouse',
    name: 'SellHouse',
    component: () => import('../views/SellHouse')
  },
  {
    path: '/collect',
    name: 'Collect',
    component: () => import('../views/Collect')
  },
  {
    path: '/myHouse',
    name: 'MyHouse',
    component: () => import('../views/MyHouse')
  },
  {
    path: '/testImg',
    name: 'TestImg',
    component: () => import('../views/TestImg')
  },
  {
    path: '/testUpload',
    name: 'TestUpload',
    component: () => import('../views/TestUpload')
  }
]

const router = new VueRouter({
  routes
})

export default router
