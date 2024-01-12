<template>
  <div id="app">
    <!-- nav bar -->
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">

        <a
          role="button"
          class="navbar-burger"
          aria-label="menu"
          aria-expanded="false"
          data-target="navbarBasicExample"
        >
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div class="navbar-menu">
        <div class="navbar-end">
          
          <div v-if="user" class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link">
              <figure class="image is-24x24 my-auto">
                <img :src="user.picture ? 'http://localhost:3000/' + user.picture : 'https://cdn.discordapp.com/attachments/949601244719218708/1109552956308717609/3237472.png'" alt="Profile Picture" class="is-rounded">
              </figure>
              <span class="pl-3"
                >{{ user.first_name }}</span
              >
            </a>
            <div class="navbar-dropdown">
              <a class="navbar-item" @click="proFile">Profile</a>
              <a class="navbar-item" @click="buyHistory">Inventory</a>
              <a class="navbar-item" @click="logOut">Log out</a>
            </div>
          </div>

          <div v-if="!user" class="navbar-item">
            <router-link to="/user/login">
              <strong>Login</strong>
            </router-link>
          </div>
          <div v-if="!user" class="navbar-item">
            <router-link to="/user/signup">
              <strong>Signup</strong>
            </router-link>
          </div>
        </div>
      </div>
    </nav>

    <router-view :key="$route.fullPath" @auth-change="onAuthChange" :user="user" />
  </div>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  data() {
    return {
      user: null
    };
  },
  mounted() {
    this.onAuthChange();
  },
  methods: {
    onAuthChange() {
      const token = localStorage.getItem("token");
      if (token) {
        this.getUser();
      }
    },
    getUser() {
      axios.get("/user/me").then(res => {
        this.user = res.data;
      });
    },
    logOut() {
      localStorage.clear();
      this.$router.push("/user/login");
      this.user = null
    },
    proFile() {
      this.$router.push("/user/profile");
    },
    buyHistory() {
      this.$router.push("/user/history");
    },
  }
};
</script>
