<template>
  <div class="row">
    <!-- メイン部分  -->
    <div class="col-9">
      <!-- タスク一覧部分 -->
      <div v-for="item in tasklist" v-bind:key="item.id">
        <div class="tasks">
          <ul style="list-style:none">
            <li class="task_header_li">
              <span class="task_header">{{ item.title }}</span>
            </li>

            <ul
              v-for="details in item.task_plan_lists"
              v-bind:key="details.id"
              style="list-style:none"
              class="task_detail"
            >
              {{
                details.title
              }}
            </ul>

 
          </ul>
        </div>
      </div>
    </div>

    <div class="col-3 right">
      <ul
        id="right-sidebar"
        class="nav-sidebar"
        style="list-style: none; padding-left: 0;"
      >
        <li class="mt-1">
          <div id="calender">
            <a href="#">ここにカレンダー。</a>
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
export default {
  data: function() {
    return {
     
     tasklist: [],
    };
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
  mounted() {},
};
</script>
