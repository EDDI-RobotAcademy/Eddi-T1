import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import SignUpChoiceView from "@/views/account/SignUpChoiceView";
import SellerSignUpView from "@/views/account/SellerSignUpView";
import SignInView from "@/views/account/SignInView";
import BuyerSignUpView from "@/views/account/BuyerSignUpView";
import ProductRegisterView from "@/views/product/ProductRegisterView";
import ProductManageView from "@/views/seller/ProductManageView";
import OrderManageView from "@/views/seller/OrderManageView";
import SellerInfoView from "@/views/seller/SellerInfoView";
import ReviewManageView from "@/views/seller/ReviewManageView";
import InquiryManageView from "@/views/seller/InquiryManageView";
import DeliveryManageView from "@/views/seller/DeliveryManageView";
import BuyerMyPageView from "@/views/buyerMyPage/BuyerMyPageView";
import BuyerInfoView from "@/views/buyerMyPage/BuyerInfoView";
import ProductReadView from "@/views/product/ProductReadView";
import OrderForm from "@/components/order/OrderForm";
import ShoppingCartView from "@/views/shoppingCart/ShoppingCartView";
import ProductModifyView from "@/views/product/ProductModifyView";

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'HomeView',
    component: HomeView
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
    path: '/product-manage',
    name: 'ProductManageView',
    component: ProductManageView
  },
  {
    path: '/seller-info',
    name: 'SellerInfoView',
    component: SellerInfoView
  },
  {
    path: '/order-manage',
    name: 'OrderManageView',
    component: OrderManageView
  },
  {
    path: '/review-manage',
    name: 'ReviewManageView',
    component: ReviewManageView
  },
  {
    path: '/inquiry-manage',
    name: 'InquiryManageView',
    component: InquiryManageView
  },
  {
    path: '/delivery-manage',
    name: 'DeliveryManageView',
    component: DeliveryManageView
  },

  {
    path: '/product-register',
    name: 'ProductRegisterView',
    component: ProductRegisterView
  },
  {
    path: '/product-read',
    name: 'ProductReadView',
    component: ProductReadView
  },
  {
    path: '/product-modify',
    name: 'ProductModifyView',
    component: ProductModifyView
  },
  {
    path: '/my-page',
    name: 'BuyerMyPageView',
    component: BuyerMyPageView
  },
  {
    path: '/buyer-info',
    name: 'BuyerInfoView',
    component: BuyerInfoView
  },
  {
    path: '/order-form',
    name: 'OrderForm',
    component: OrderForm
  },
  {
    path: '/shoppingCart',
    name: 'ShoppingCartView',
    component: ShoppingCartView
  },


]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router