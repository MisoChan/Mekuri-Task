<template>
  <div class="row">
    <!-- メイン部分  -->
    <div id="task_lists" class="col-9">
      <!-- タスク入力欄 -->
      <Taskinput></Taskinput>

      <div v-for="itemProp in tasklist" v-bind:key="itemProp.id">
       
        <Taskplan :item='itemProp'></Taskplan>
      </div>
    </div>
    <div class="col-2 right">
      <ul
        id="right-sidebar"
        class="nav-sidebar"
        style="list-style: none; padding-left: 0"
      >
        <li class="mt-1">
          <div id="calender">
             <v-date-picker
                :Format=DatePickerFormat
                  v-model="today"
                  is-required
                />
          </div>
        </li>

        <li class="mt-5">
          <div id="time_clock">
            <a href="#">ここに現在時刻</a>
          </div>
        </li>

        <li class="mt-2">
          <button type="button" class="btn btn-primary">
            タスク消化スタート！
          </button>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import { csrfToken } from "rails-ujs";
import Taskinput from "./components/Taskinput.vue";
import Taskplan from "./components/TaskPlans.vue";

export default {
  
  components:{
    Taskinput,
    Taskplan
  },
  data: function() {
    
    return {

      DatePickerFormat: 'yyyy-MM-dd',
      checkdone: [],
      tasklist: [],
      
      modelConfig: {
        type: 'string',
      },
      
    };
  },
  methods: {

  
  
  },
    //DOMが出来上がる前にやっとく処理
    created() {
       //タスク一覧リストの取得
      axios.defaults.headers.common = csrfToken();
      axios
        .get("/task_lists/show")
        .then((response) => (this.tasklist = response.data));
      
    },

    //DOMが出来上がった時点の処理
    mounted() {
     
    },
    //値の変更監視
    watch(){

    }
};
</script>
