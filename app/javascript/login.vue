<template>
  <div class="login_form">

    <div class="login_input">
      <div id="login_title">ログイン
        <div id="greet_message">
        おかえりなさいまし。
      </div>

      </div>
      
      <ul class="login_form_input_li">
        <li>メールアドレス</li>
        <li><input type="text" class="login_input" v-model="user_email"/></li>
        
        <li>パスワード</li>
        <li><input type="password" class="login_input" v-model="user_pass"/></li>

        <li>
          <div>
          
          <button  id="button_login_submit" @click="request_login()">ログイン</button>
          <a>パスワード忘れた…</a>
        </div>
        </li>
        
      </ul>
      
    </div>
  </div>
</template>

<script>
import Mixins from "./modules/common_vue_mixin.js";
import axios from "axios";
export default {
  mixins: [Mixins],
  data() {
    return {
      user_email: "",
      user_pass: "",
    }
  },
  methods: {
    request_login(){
      axios.post("/login",{
        email_user : this.user_email,
        pass: this.user_pass
        }
      ).then(function(){
        //タスクリストにとりあえず飛ばす
        //window.location.href = '/task_lists';
      });
    }
  }
  
};
</script>
