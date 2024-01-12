<template>
  <div class="container is-widescreen">
    <section class="hero">
      <div class="hero-body">
        <p class="title">ชื่อโพสต์ : {{ blog.title }}</p>
      </div>
    </section>
    <section class="section" id="app">
      <div class="content">
        <div class="card has-background-info-light">
          <div class="card-content">
            <div class="content">ชื่อไอเทม : {{ blog.item_name }}</div>
          </div>
          <div class="card-content">
            <div class="content">รายละเอียดไอเทม : {{ blog.item_desc }}</div>
          </div>
          <div class="card-image pt-5">
            <div class="columns">
              <div class="column">
                <figure class="image">
                  <img
                    :src="'http://localhost:3000/' + blog.item_image"
                    alt="Placeholder image"
                  />
                </figure>
              </div>
            </div>
          </div>
          <div class="card-content">
            <div class="content">รายละเอียดโพสต์ : {{ blog.description }}</div>
            <div class="container">
              <p class="subtitle">ความคิดเห็น</p>
              <div class="field">
                <div class="control is-expanded" style="padding-bottom:20px">
                  <input
                    type="text"
                    class="input"
                    v-model="commTxt"
                    placeholder="เขียนความคิดเห็น..."
                  />
                </div>
                <div class="control" style="padding-bottom:20px">
                  <button @click="addComment()" class="button is-info">
                    <span>เพิ่มความคิดเห็น</span>
                      <span class="icon is-small">
                      <i class="fas fa-comment"></i>
                    </span>
                  </button>
                </div>
              </div>
            </div>
            <div
              v-for="(comment, index) in comments"
              :key="comment.comment_id"
              class="box"
            >
              <article class="media">
                <div class="media-left">
                  <figure class="image is-96x96">
                    <img
                      :src="
                        comment.image
                          ? 'http://localhost:3000/' + comment.image
                          : 'https://cdn.discordapp.com/attachments/949601244719218708/1109552956308717609/3237472.png'
                      "
                      alt="Profile Picture"
                    />
                  </figure>
                </div>
                <div v-if="index === editToggle" class="media-content">
                  <div class="content">
                    <input
                      v-model="editCommentMessage"
                      class="input"
                      type="text"
                    />
                    <p class="is-size-7">{{ comment.comment_date }}</p>
                  </div>
                  <nav class="level">
                    <div class="level-right">
                      <div class="level-item">
                        <button
                          @click="saveEditComment(comment.comment_id, index)"
                          class="button is-primary"
                        >
                          <span>Save Comment</span>
                          <span class="icon is-small">
                            <i class="fas fa-edit"></i>
                          </span>
                        </button>
                      </div>
                      <div class="level-item">
                        <button
                          @click="editToggle = -1"
                          class="button is-info is-outlined"
                        >
                          <span>Cancel</span>
                          <span class="icon is-small">
                            <i class="fas fa-times"></i>
                          </span>
                        </button>
                      </div>
                    </div>
                  </nav>
                </div>
                <div v-else class="media-content">
                  <div class="content">
                    <h1>{{ comment.first_name }}</h1>
                    <p>{{ comment.content }}</p>
                    <p class="is-size-7">{{ comment.comment_date }}</p>
                  </div>
                  <nav class="level">
                    <div class="level-right">
                      <div class="level-item">
                        <button
                          v-if="isCommentOwner(comment)"
                          @click="
                            editToggle = index;
                            editCommentMessage = comment.content;
                          "
                          class="button is-warning"
                        >
                          <span>Edit</span>
                          <span class="icon is-small">
                            <i class="fas fa-edit"></i>
                          </span>
                        </button>
                      </div>
                      <div class="level-item">
                        <button
                          v-if="isCommentOwner(comment)"
                          @click="deleteComment(comment.comment_id, index)"
                          class="button is-danger is-outlined"
                        >
                          <span>Delete</span>
                          <span class="icon is-small">
                            <i class="fas fa-times"></i>
                          </span>
                        </button>
                      </div>
                    </div>
                  </nav>
                </div>
                <div class="media-content">
                <div class="content">
                  <nav class="level">
                    <div class="level-right">
                      <div class="level-item">
                        <button
                          v-if="isBlogOwner(blog)"
                          @click="addChat(comment.comment_by_id, comment.first_name)"
                          class="button is-link"
                        >
                          <span>Chat</span>
                          <span class="icon is-small">
                            <i class="fas fa-edit"></i>
                          </span>
                        </button>
                      </div>
                    </div>
                  </nav>
                </div>
                <nav class="level"></nav>
              </div>
              </article>
            </div>
          </div>
          <footer class="card-footer">
            <a class="card-footer-item" href="/">กลับหน้าหลัก</a>
          </footer>
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
      blog: null,
      comments: null,
      chats: null,
      error: null,
      commTxt: "",
      editToggle: -1,
      chatToggle: -1,
      editCommentMessage: "",
    };
  },
  created() {
    axios
      .get("http://localhost:3000/blogs/" + this.$route.params.id)
      .then((response) => {
        this.blog = response.data.blog;
        this.comments = response.data.comments;
        this.chats = response.data.chats;
        console.log(this.blog);

        // console.log(this.comments);
      })
      .catch((err) => {
        console.log(err.data.message);
      });
  },

  methods: {
    // handleFileUpload() {
    //   this.file = this.$refs.file.files[0];
    // },
    addComment() {
      var formData = new FormData();
      formData.append("content", this.commTxt);
      axios
        .post(`http://localhost:3000/${this.blog.id}/comments`, formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then((response) => {
          this.commTxt = "";
          this.comments.push(response.data);
          this.$router.push({ name: "Detail blog" });
          console.log(response);
        })
        .catch((error) => {
          console.log(error);
        });
      window.location.reload();
    },
    saveEditComment(commentId, index) {
      axios
        .put(`http://localhost:3000/comments/${commentId}`, {
          content: this.editCommentMessage,
        })
        .then((response) => {
          this.comments[index].content = response.data.content;
          this.editToggle = -1;
        })
        .catch((error) => {
          this.error = error.message;
        });
      window.location.reload();
    },
    deleteComment(commentId, index) {
      const result = confirm(`Are you sure you want to delete this comment`);
      if (result) {
        axios
          .delete(`http://localhost:3000/comments/${commentId}`)
          .then(response => {
            console.log(response);
            this.comments.splice(index, 1);
          })
          .catch(error => {
            this.error = error.message;
          });
      }
    },
    addChat(commentBy, commentsName) {
      const result = confirm(
        `Are you sure you want to chat with '${commentsName}'`
      );
      if (result) {
        axios
          .post(`http://localhost:3000/${this.blog.id}/chats/${this.blog.create_by_id}/${commentBy}`)
          .then((response) => {
            this.$router.push("/chat/");
            console.log(response);
          })
          .catch((error) => {
            alert(error.response.data.message);
          });
      }
    },
    deleteBlog() {
      const result = confirm(
        `Are you sure you want to chat with '${this.blog.id}'`
      );
      if (result) {
        axios
          .delete(`http://localhost:3000/blogs/${this.blog.id}`)
          .then((response) => {
            this.$router.push("/");
            console.log(response);
          })
          .catch((error) => {
            alert(error.response.data.message);
          });
      }
    },
    isBlogOwner(blog) {
      if (this.user.role === "admin") return true;
      if (!this.user) return false;
      return blog.create_by_id === this.user.id;
    },
    isCommentOwner(comment) {
      if (this.user.role === "admin") return true;
      if (!this.user) return false;
      return comment.comment_by_id === this.user.id;
    },
    
    // submit() {
    //   var formData = new FormData();
    //   formData.append("commTxt", this.commTxt);

    //   axios.all([

    //     axios.post("http://localhost:3000/blogs", formData, {
    //       headers: {
    //         "Content-Type": "multipart/form-data",
    //       },

    //     })
    //     ])
    //     .then((response) => {
    //       console.log(response);
    //       this.$router.push({ path: "/" }); // Success! -> redirect to home page
    //     })
    //     .catch((error) => {
    //       console.log(error.message);
    //     });
    // },
  },
};
</script>
<style scoped></style>
