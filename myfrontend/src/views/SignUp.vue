 <template>
  <div class="container is-fluid mt-5">
    <div class="columns is-centered">
      <div class="column is-4">
        <h1 class="title">Sign Up</h1>
        <!-- Sign up form -->
        
        <div class="file">
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

        <div class="field">
          <label class="label">Username</label>
          <div class="control has-icons-left">
            <input
              v-model="$v.username.$model"
              :class="{ 'is-danger': $v.username.$error }"
              class="input"
              type="text"
            />
            <span class="icon is-small is-left">
              <i class="fas fa-user"></i>
            </span>
          </div>
          <template v-if="$v.username.$error">
            <p class="help is-danger" v-if="!$v.username.required">
              This field is required
            </p>
            <p class="help is-danger" v-if="!$v.username.minLength">
              Username must be at least 5 charector
            </p>
            <p class="help is-danger" v-if="!$v.username.maxLength">
              Username must not more than 20 charector
            </p>
          </template>
        </div>

        <div class="field">
          <label class="label">Password</label>
          <div class="control has-icons-left has-icons-right">
            <input
              v-model="$v.password.$model"
              :class="{ 'is-danger': $v.password.$error }"
              class="input"
              type="password"
            />
            <span class="icon is-small is-left">
              <i class="fas fa-lock"></i>
            </span>
          </div>
          <template v-if="$v.password.$error">
            <p class="help is-danger" v-if="!$v.password.required">
              This field is required
            </p>
            <p class="help is-danger" v-if="!$v.password.minlength">
              password must be at least 8 charector
            </p>
            <p class="help is-danger" v-if="!$v.password.complexPassword">
              password is too easy
            </p>
          </template>
        </div>

        <div class="field">
          <label class="label">Confirm Password</label>
          <div class="control has-icons-left has-icons-right">
            <input
              v-model="$v.confirm_password.$model"
              :class="{ 'is-danger': $v.confirm_password.$error }"
              class="input"
              type="password"
            />
            <span class="icon is-small is-left">
              <i class="fas fa-lock"></i>
            </span>
          </div>
          <template v-if="$v.confirm_password.$error">
            <p class="help is-danger" v-if="!$v.confirm_password.sameAs">
              Password do not match
            </p>
          </template>
        </div>

        <div class="field">
          <label class="label">Email</label>
          <div class="control has-icons-left has-icons-right">
            <input
              v-model="$v.email.$model"
              :class="{ 'is-danger': $v.email.$error }"
              class="input"
              type="text"
            />
            <span class="icon is-small is-left">
              <i class="fas fa-envelope"></i>
            </span>
          </div>
          <template v-if="$v.email.$error">
            <p class="help is-danger" v-if="!$v.email.required">
              This field is required
            </p>
            <p class="help is-danger" v-if="!$v.email.email">Invalid Email</p>
          </template>
        </div>

        <div class="field">
          <label class="label">phone Number</label>
          <div class="control has-icons-left has-icons-right">
            <input
              v-model="$v.phone.$model"
              :class="{ 'is-danger': $v.phone.$error }"
              class="input"
              type="text"
            />
            <span class="icon is-small is-left">
              <i class="fas fa-phone"></i>
            </span>
          </div>
          <template v-if="$v.phone.$error">
            <p class="help is-danger" v-if="!$v.phone.required">
              This field is required
            </p>
            <p class="help is-danger" v-if="!$v.phone.phone">
              Invalid phone Number
            </p>
          </template>
        </div>

        <div class="field">
          <label class="label">First Name</label>
          <div class="control has-icons-left has-icons-right">
            <input
              v-model="$v.first_name.$model"
              :class="{ 'is-danger': $v.first_name.$error }"
              class="input"
              type="text"
            />
          </div>
          <template v-if="$v.first_name.$error">
            <p class="help is-danger" v-if="!$v.first_name.required">
              This field is required
            </p>
            <p class="help is-danger" v-if="!$v.first_name.maxLength">
              Firstname must not more than 200 charector
            </p>
          </template>
        </div>

        <div class="field">
          <label class="label">Last Name</label>
          <div class="control has-icons-left has-icons-right">
            <input
              v-model="$v.last_name.$model"
              :class="{ 'is-danger': $v.last_name.$error }"
              class="input"
              type="text"
            />
          </div>
          <template v-if="$v.last_name.$error">
            <p class="help is-danger" v-if="!$v.last_name.required">
              This field is required
            </p>
            <p class="help is-danger" v-if="!$v.last_name.maxLength">
              Firstname must not more than 200 charector
            </p>
          </template>
        </div>

        <button class="button is-primary is-fullwidth" @click="submit()">
          Sign Up
        </button>

        <!-- <p class="my-3">Already have an account? <a href="#">Login</a></p> -->
        <p class="my-3">
          Already have an account? <a href="#/user/login/">Login</a>
        </p>
      </div>
    </div>
  </div>
</template>
 
 <script>
import axios from "@/plugins/axios";

import {
  required,
  email,
  minLength,
  maxLength,
  sameAs,
} from "vuelidate/lib/validators";
function phone(value) {
  return !!value.match(/0[0-9]{9}/);
}

function complexPassword(value) {
  if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
    return false;
  }
  return true;
}
export default {
  data() {
    return {
      username: "",
      password: "",
      confirm_password: "",
      email: "",
      phone: "",
      first_name: "",
      last_name: "",
      file: null,
    };
  },
  validations: {
    email: {
      required: required,
      email: email,
    },
    phone: {
      required: required,
      phone: phone,
    },
    password: {
      required: required,
      minLength: minLength(8),
      complex: complexPassword,
    },
    confirm_password: {
      sameAs: sameAs("password"),
    },
    username: {
      required: required,
      minLength: minLength(5),
      maxLength: maxLength(20),
    },
    first_name: {
      required: required,
      maxLength: maxLength(200),
    },
    last_name: {
      required: required,
      maxLength: maxLength(200),
    },
  },
  methods: {
    handleFileUpload() {
      this.file = this.$refs.file.files[0];
    },
    submit() {
      // Validate all fields
      this.$v.$touch();

      // เช็คว่าในฟอร์มไม่มี error
      if (!this.$v.$invalid) {
        let formData = new FormData();
        formData.append("username", this.username);
        formData.append("password", this.password);
        formData.append("confirm_password", this.confirm_password);
        formData.append("email", this.email);
        formData.append("first_name", this.first_name);
        formData.append("last_name", this.last_name);
        formData.append("phone", this.phone);

        formData.append("user_image", this.file);


        axios
          .post("http://localhost:3000/user/signup", formData, {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          })
          .then((res) => {
            console.log(res);
            alert("Sign up Success");
            this.$router.push({ name: "Login" });
          })
          .catch((err) => {
            alert(err.response.data.message);
          });
      }
    },
  },
};
</script>