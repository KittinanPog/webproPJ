import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    meta: { login: true },
    component: () => import('./views/HomePage.vue') // set home as path '/'
  },
  {
    path: '/blog/create',
    name: 'Create new blog',
    meta: { login: true },
    component: () => import('./views/blogs/CreateBlog.vue') // set create blog as path '/blog/create'
  },
  {
    path: '/detail/:id',
    name: 'Detail blog',
    meta: { guess: true },
    component: () => import('./views/blogs/BlogDetail.vue') // set create blog as path '/detail/:id'
  },
  {
    path: "/user/login",
    name: "Login",
    meta: { guess: true },
    component: () => import("./views/LoginPage.vue")
  },
  {
    path: "/user/signup",
    name: "Signup",
    meta: { guess: true },
    component: () => import("./views/SignUp.vue")
  },
  {
    path: "/user/profile",
    name: "View profile",
    meta: { guess: true },
    component: () => import("./views/UserProfile.vue")
  },
  {
    path: "/user/history",
    name: "Buy History",
    meta: { guess: true },
    component: () => import("./views/BuyHistory.vue")
  },
  {
    path: "/chat/",
    name: "Chat Selection",
    meta: { guess: true },
    component: () => import("./views/chat/ChatSelect.vue")
  },
  {
    path: "/user/:blogId/chat/:chatId",
    name: "Chat",
    meta: { guess: true },
    component: () => import("./views/chat/UserChat.vue")
  },
  
]

const router = new VueRouter({ routes });
router.beforeEach((to, from, next) => {
  const isLoggedIn = !!localStorage.getItem("token");

  if (to.meta.login && !isLoggedIn) {
    alert("Please login first!");
    next({ path: "/user/login" });
  }

  next();
});

export default router