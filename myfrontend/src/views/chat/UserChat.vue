<style scoped>
.card-equal-height {
  display: flex;
  flex-direction: column;
  height: 650px;
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
.card-content {
  overflow: auto;
}
.card-header {
  justify-content: center;
}
.is-horizontal-center {
  justify-content: center;
}
</style>
<template>
  <div class="container is-widescreen">
    <div>
      <router-link :to="'/chat'">
        <a>ย้อนกลับ</a>
      </router-link>

      <div class="card-content has-text-centered">
        <div class="content">ชื่อไอเทม: {{ blog.item_name }}</div>
      </div>
      <div class="card-content has-text-centered">
        <div class="content">รายละเอียดไอเทม: {{ blog.item_desc }}</div>
      </div>

      <div class="card-image pt-5 is-flex is-horizontal-center">
        <div class="columns">
          <div class="column is-half">
            <figure class="image is-96x96">
              <img
                :src="'http://localhost:3000/' + blog.item_image"
                alt="Placeholder image"
              />
            </figure>
          </div>
        </div>
      </div>

      <div v-if="isChatOwner(chats)" class="has-text-centered">
        <button @click="conFirm(chats.chat_to_id, blog.item_id)" class="button is-primary">
          <span>ยืนยันการขาย</span>
        </button>
      </div>
    </div>
    <section class="section" id="app">
      <div class="content">
        <div class="columns">
          <div class="column is-6">
            <div class="card card-equal-height">
              <div class="card-header">YOU</div>
              <div class="card-content">
                <div
                  class="content has-text-centered"
                  v-for="message in messages"
                  :key="message.message_id"
                >
                  <div class="box">
                    <article class="media">
                      <div class="media-left">
                        <figure class="image is-96x96">
                          <img
                            :src="
                              message.m_image
                                ? 'http://localhost:3000/' + message.m_image
                                : 'https://cdn.discordapp.com/attachments/949601244719218708/1109552956308717609/3237472.png'
                            "
                            alt="Profile Picture"
                          />
                        </figure>
                      </div>
                      <div class="media-content">
                        <div class="content">
                          <h1>{{ message.first_name }}</h1>
                          <p>{{ message.message }}</p>
                          <p class="is-size-7">{{ message.m_timestamp }}</p>
                        </div>
                      </div>
                      <div class="media-content">
                        <nav class="level"></nav>
                      </div>
                    </article>
                  </div>
                </div>
              </div>
              <footer v-if="isChatOwner(chats)" class="card-footer">
                <input
                  type="text"
                  class="input"
                  v-model="chatTxt1"
                  placeholder="เขียนข้อความ..."
                />
                <button @click="addMessage()" class="button is-primary">
                  <span>ส่ง</span>
                  <span class="icon is-small">
                    <i class="fas fa-comment"></i>
                  </span>
                </button>
              </footer>
            </div>
          </div>

          <div class="column is-6">
            <div class="card card-equal-height">
              <div class="card-header">opp</div>
              <div class="card-content">
                <div class="content has-text-centered">
                  <div
                    v-for="message in messagesto"
                    :key="message.message_id"
                    class="box"
                  >
                    <article class="media">
                      <div class="media-left">
                        <figure class="image is-96x96">
                          <img
                            :src="
                              message.m_image
                                ? 'http://localhost:3000/' + message.m_image
                                : 'https://cdn.discordapp.com/attachments/949601244719218708/1109552956308717609/3237472.png'
                            "
                            alt="Profile Picture"
                          />
                        </figure>
                      </div>
                      <div class="media-content">
                        <div class="content">
                          <h1>{{ message.first_name }}</h1>
                          <p>{{ message.message }}</p>
                          <p class="is-size-7">
                            {{ message.m_timestamp }}
                          </p>
                        </div>
                      </div>
                      <div class="media-content">
                        <nav class="level"></nav>
                      </div>
                    </article>
                  </div>
                </div>
              </div>
              <footer v-if="isChatTo(chats)" class="card-footer">
                <input
                  type="text"
                  class="input"
                  v-model="chatTxt2"
                  placeholder="เขียนข้อความ..."
                />
                <button @click="addMessageTo()" class="button is-primary">
                  <span>ส่ง</span>
                  <span class="icon is-small">
                    <i class="fas fa-comment"></i>
                  </span>
                </button>
              </footer>
            </div>
          </div>
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
      blog: null,
      chats: null,
      messages: null,
      messagesto: null,
      error: null,
      chatTxt1: "",
      chatTxt2: "",
      chatToggle: -1,
    };
  },
  created() {
    axios
      .get(
        "http://localhost:3000/chats/" +
          this.$route.params.blogId +
          "/" +
          this.$route.params.chatId
      )
      .then((response) => {
        this.chats = response.data.chat;
        this.messages = response.data.messageby;
        this.messagesto = response.data.messageto;
        this.blog = response.data.blog;
        console.log(this.chats);
        console.log(this.messages);
        console.log(this.messagesto);
      })
      .catch((err) => {
        console.log(err.message);
      });
  },

  methods: {
    // handleFileUpload() {
    //   this.file = this.$refs.file.files[0];
    // },
    formatJoinDate(joinDate) {
      const date = new Date(joinDate);
      const formattedDate = date.toLocaleString("en-US", {
        year: "numeric",
        month: "long",
        day: "numeric",
        hour: "numeric",
        minute: "numeric",
      });
      return formattedDate;
    },
    addMessage() {
      var formData = new FormData();
      formData.append("message", this.chatTxt1);
      axios
        .post(
          `http://localhost:3000/${this.$route.params.chatId}/messages`,
          formData,
          {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          }
        )
        .then((response) => {
          this.chatTxt1 = "";
          this.messages.push(response.data);
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
      window.location.reload();
    },
    addMessageTo() {
      var formData = new FormData();
      formData.append("message", this.chatTxt2);
      axios
        .post(
          `http://localhost:3000/${this.$route.params.chatId}/messages`,
          formData,
          {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          }
        )
        .then((response) => {
          this.chatTxt2 = "";
          this.messages.push(response.data);
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
      window.location.reload();
    },

    isChatOwner(chats) {
      if (!this.user) return false;
      return chats.chat_by_id === this.user.id;
    },
    isChatTo(chats) {
      if (!this.user) return false;
      return chats.chat_to_id === this.user.id;
    },
    conFirm(buyId, itemId) {
      const result = confirm(
        `คุณยืนยันที่จะขายไอเท็มนี้หรือไม่`
      );
      if (result) {
        axios
          .put(
            `http://localhost:3000/items/${this.blog.id}/${this.$route.params.chatId}/${buyId}/${itemId}`
          )
          .then((response) => {
            this.$router.push("/");
            console.log(response);
          })
          .catch((error) => {
            alert(error.response.data.message);
          });
      }
    },
  },
};
</script>

