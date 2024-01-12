<template>
  <div>
    <section class="hero">
      <div class="hero-body ml-5">
        <p class="title has-text-centered">Create a New Blog</p>
      </div>
    </section>
    <section class="container">
      <div class="content">
        <div class="field">
          <label class="label">Title</label>
          <input
            class="input"
            type="text"
            name="title"
            placeholder="Blog title"
            v-model="title"
          />
        </div>
        <section>
          <div class="content">
        <div class="field">
          <label class="label">Item Name</label>
          <input
            class="input"
            type="text"
            name="item"
            placeholder="Item Name"
            v-model="item"
          />
        </div>
        <div class="field">
          <label class="label">Item Description</label>
          <input
            class="input"
            type="text"
            name="item_desc"
            placeholder="Item Info"
            v-model="item_desc"
          />
        </div>
        <div class="file" style="padding:8px 0px">
          <label class="file-label">
            <input
              class="file-input"
              type="file"
              name="item_image"
              id="file"
              ref="file"
              @change="handleFileUpload()"
            />
            <span class="file-cta">
              <span class="file-icon">
                <i class="fas fa-upload"></i>
              </span>
              <span class="file-label"> Choose an image… </span>
            </span>
          </label>
        </div>
        </div>
        </section>
        <div class="field">
          <label class="label">Description</label>
          <div class="control">
            <textarea
              class="textarea"
              placeholder="Textarea"
              name="description"
              v-model="description"
            ></textarea>
          </div>
        </div>
        
        
        <div class="field is-grouped mt-3">
          <div class="control">
            <input
              type="button"
              class="button is-link"
              value="Submit"
              @click="submit()"
            />
          </div>
          <div class="control">
            <input
              type="button"
              class="button is-warning"
              value="Back to home"
              @click="bth()"
            />
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
      title: "",
      description: "",
      item: "",
      item_desc: "",
      file: null,
    };
  },
  methods: {
    handleFileUpload() {
      this.file = this.$refs.file.files[0];
    },
    submit() {
      var formData = new FormData();
      formData.append("item_image", this.file);
      formData.append("title", this.title);
      formData.append("item_name", this.item);
      formData.append("item_desc", this.item_desc);
      formData.append("description", this.description);
      
      axios
        
        .post("http://localhost:3000/blogs", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
          
        })
        
        .then((response) => {
          console.log(response);
          this.$router.push({ name: "Home" }); // Success! -> redirect to home page
        })
        .catch((error) => {
          console.log(error.message);
        });
        
    },
    bth() {
          this.$router.push({ name: "Home" }); // Success! -> redirect to home page
    },
  },
};
</script>
