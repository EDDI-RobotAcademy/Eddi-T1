import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import SignUpChoiceView from "@/views/account/SignUpChoiceView";
import SellerSignUpView from "@/views/account/SellerSignUpView";
import SignInView from "@/views/account/SignInView";
import BuyerSignUpView from "@/views/account/BuyerSignUpView";
import ProductRegisterView from "@/views/product/ProductRegisterView";
import SellerProductView from "@/components/myPage/SellerProductView";

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'HomeView',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () => import(/* webpackChunkName: "about" */ '../views/AboutView.vue')
  },
  {
    path: '/sign-up-choice',
    name: 'SignUpChoiceView',
    component: SignUpChoiceView
  },
  {
    path: '/seller-sign-up',
    name: 'SellerSignUpView',
    component: SellerSignUpView
  },
  {
    path: '/buyer-sign-up',
    name: 'BuyerSignUpView',
    component: BuyerSignUpView
  },
  {
    path: '/sign-in',
    name: 'SignInView',
    component: SignInView
  },
  {
    path: '/seller-product-view',
    name: 'SellerProductView',
    component: SellerProductView
  },
  {
    path: '/product-register',
    name: 'ProductRegisterView',
    component: ProductRegisterView
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router