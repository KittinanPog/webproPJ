<template>
    <div>
      <section class="hero">
        <div class="hero-body ml-5">
          <p class="title has-text-centered">Your Profile</p>
        </div>
      </section>
      <section class="section">
    <div class="container">
      <div class="columns">
        <div class="column is-half is-offset-one-quarter">
          <div class="card has-background-warning-light">
            <div class="card-content">
              <div class="media">
                <div class="media-left">
                  <figure class="image is-64x64">
                    <img :src="user.picture ? 'http://localhost:3000/' + user.picture : 'https://cdn.discordapp.com/attachments/949601244719218708/1109552956308717609/3237472.png'" alt="Profile Picture">
                  </figure>
                </div>
                <div class="media-content">
                  <p class="title is-4">Profile: {{ user.username }}</p>
                </div>
              </div>

              <div class="content">
                <p><strong>User ID :</strong> {{ user.id }}</p>
                <p><strong>Username :</strong> {{ user.username }}</p>
                <p><strong>First Name :</strong> {{ user.first_name }}</p>
                <p><strong>Last Name :</strong> {{ user.last_name }}</p>
                <p><strong>Email :</strong> {{ user.email }}</p>
                <p><strong>Phone :</strong> {{ user.phone }}</p>
                <p><strong>วันที่สมัคร :</strong> {{ user.join_date | formatDate }}</p>
              </div>
              <footer class="card-footer">
            <a class="card-footer-item" href="/">กลับหน้าหลัก</a>
          </footer>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
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
    filters: {
    formatDate(value) {
    const date = new Date(value);
    return date.toLocaleDateString();
    }
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
    }
  };
  </script>
  