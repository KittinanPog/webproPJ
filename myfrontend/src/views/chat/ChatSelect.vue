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
    <section class="section" id="app">
      <div class="tile is-ancestor">
        <div class="tile is-parent">
          <article class="tile is-child notification is-white box">
            <section class="hero">
              <div class="hero-body">
                <p class="title has-text-centered">Chat From You</p>
              </div>
            </section>
            <div class="content">
              <div class="columns is-multiline">
                <div
                  class="column is-6"
                  v-for="chat in chats"
                  :key="chat.chat_id"
                >
                  <div class="card card-equal-height">
                    <div class="card-image pt-5">
                      <figure class="image is-4by3">
                        <img
                          :src="'http://localhost:3000/' + chat.picture"
                          alt="Placeholder image"
                        />
                      </figure>
                    </div>
                    <div class="card-content">
                      <div class="title has-text-centered">
                        {{ chat.first_name }}
                      </div>
                    </div>
                    <footer class="card-footer">
                      <router-link :to="'/user/'+ chat.form_blog_id +'/chat/' + chat.chat_id">
                        <a class="card-footer-item has-text-centered"
                          >Go to chat</a
                        >
                      </router-link>
                    </footer>
                  </div>
                </div>
              </div>
            </div>
          </article>
        </div>
        <div class="tile is-parent">
          <article class="tile is-child notification is-white box">
            <section class="hero">
              <div class="hero-body">
                <p class="title has-text-centered">Chat To You</p>
              </div>
            </section>
            <div class="content">
              <div class="columns is-multiline">
                <div
                  class="column is-6"
                  v-for="chatto in chatsTo"
                  :key="chatto.chat_id"
                >
                  <div class="card card-equal-height">
                    <div class="card-image pt-5">
                      <figure class="image is-4by3">
                        <img
                          :src="'http://localhost:3000/' + chatto.picture"
                          alt="Placeholder image"
                        />
                      </figure>
                    </div>
                    <div class="card-content">
                      <div class="title has-text-centered">
                        {{ chatto.first_name }}
                      </div>
                    </div>
                    <footer class="card-footer">
                      <router-link :to="'/user/'+ chatto.form_blog_id +'/chat/' + chatto.chat_id">
                        <a class="card-footer-item has-text-centered"
                          >Go to chat</a
                        >
                      </router-link>
                    </footer>
                  </div>
                </div>
              </div>
            </div>
          </article>
        </div>
      </div>
      <footer class="card-footer">
        <a class="card-footer-item" href="/">กลับหน้าหลัก</a>
      </footer>
    </section>
  </div>
</template>

<script>
import axios from "@/plugins/axios";

export default {
  props: ["user"],
  data() {
    return {
      chats: null,
      chatsTo: null,
    };
  },
  created() {
    axios
      .get("http://localhost:3000/chat")
      .then((response) => {
        this.chats = response.data.chatsby;
        this.chatsTo = response.data.chatsto;

        console.log(this.chats);
      })
      .catch((err) => {
        console.log(err.message);
      });
  },
};
</script>

<style scoped></style>
