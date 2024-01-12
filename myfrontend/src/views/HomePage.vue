<style scoped>
.card-equal-height {
  display: flex;
  flex-direction: column;
  height: 100%;
}
.card-equal-height .card-footer {
  margin-top: auto;
}
.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  border-radius: 0.5rem;
}
.card img {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 30px 0 rgba(0, 0, 0, 0.19);
  border-radius: 0.5rem;
  max-width: 96.5%;
  max-height: 96.5%;
  margin: 0 auto;
  margin-top: -3.5%;
}
</style>
<template>
  <div class="container is-widescreen">
    <section class="hero">
      <div class="hero-body">
        <p class="title has-text-centered">Black Market</p>
      </div>
    </section>
    <section class="section" id="app">
      <div class="content">
        <div class="columns">
          <div class="column is-2">
            <router-link to="/blog/create">
              <input class="button is-info" type="button" value="Create New Blog" />
            </router-link>
          </div>
          <div class="column is-3 is-offset-9">
            <router-link to="/chat/">
              <input class="button is-primary" type="button" value="Chat" />
            </router-link>
          </div>
        </div>
      </div>

      <div class="content">
        <div class="columns is-multiline">
          <div class="column is-3" v-for="blog in blogs" :key="blog.id">
            <div class="card card-equal-height has-background-info-light">
              <div class="card-image pt-5">
                <figure class="image is-4by3">
                  <img
                    :src="'http://localhost:3000/' + blog.item_image"
                    alt="Placeholder image"
                  />
                </figure>
              </div>
              <div class="card-content">
                <div class="title has-text-centered">{{ blog.title }}</div>
                <div class="content">
                  <span>
                    {{ blog.item_name }}
                  </span>
                </div>
              </div>
              <footer class="card-footer">
                <router-link :to="'/detail/' + blog.id">
                  <a class="card-footer-item">ดูรายละเอียดโพสต์</a>
                </router-link>
              </footer>
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
  props: ["user"],
  data() {
    return {
      blogs: null,
    };
  },
  created() {
    axios
      .get("http://localhost:3000/")
      .then((response) => {
        this.blogs = response.data;

        console.log(this.blogs);
      })
      .catch((err) => {
        console.log(err.message);
      });
  },
};
</script>

<style scoped></style>
