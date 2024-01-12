<template>
  <div class="container is-widescreen">
    <section class="hero">
      <div class="hero-body">
        <p class="title has-text-centered">Buy History</p>
      </div>
    </section>
    <section class="section" id="app">
      <div class="content">
        <div class="columns">
          <div class="column is-2">
            <router-link to="/">
              <input class="button is-info" type="button" value="กลับหน้าหลัก" />
            </router-link>
          </div>
          <div class="column is-3 is-offset-9">
            <router-link to="/user/chat">
              <input class="button is-primary" type="button" value="Chat" />
            </router-link>
          </div>
        </div>
      </div>

      <div class="content">
        <div class="columns is-multiline">
          <div class="column is-2" v-for="inventory in inventorys" :key="inventory.item_id">
            <div class="card card-equal-height" v-if="inventory.own_by_id === user.id">
              <div class="card-image pt-5">
                <figure class="image is-4by3">
                  <img
                    :src="'http://localhost:3000/' + inventory.item_image"
                    alt="Placeholder image"
                  />
                </figure>
              </div>
              <div class="card-content">
                <!-- <div class="title has-text-centered">{{ user.id }}</div>
                <div class="title has-text-centered">{{ inventory.own_by_id }}</div>
                <div class="title has-text-centered">{{ inventory.item_id }}</div> -->
                <div class="title has-text-centered">{{ inventory.item_name }}</div>
                <div class="content">
                  <span>
                    {{ inventory.item_desc }}
                    <!-- {{ inventory.status }} -->
                  </span>
                </div>
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
        inventorys: null,
        user: null
      };
    },
    created() {
    axios
      .get("http://localhost:3000/inventory/")
      .then((response) => {
        this.inventorys = response.data.inventory;
        console.log(this.inventorys);
      })
      .catch((err) => {
        console.log(err.response.data.message);
      });
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
    }
  };
  </script>
  