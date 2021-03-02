<template>
  <div class="row">
    <!-- メイン部分  -->
    <div id="task_lists" class="col-9">
      <!-- タスク入力部分 -->
      <div id="task_input_box" class="tasks">
        <ul style="list-style: none">
          <li class="task_input_li">
            <div class="form-group">
              <input
                type="text"
                id="taskhead_titleinput"
                class="col-11"
                placeholder="タスク タイトル"
              />
              <li class="task_input_li">
                <input
                  type="text"
                  id="taskhead_dateinput_from "
                  class="task_input_date "
                  placeholder="開始日"
                />
                <input
                  type="text"
                  id="taskhead_timeinput_from"
                  class="task_input_times"
                  placeholder="開始時間"
                />
                - >
                <input
                  type="text"
                  id="taskhead_dateinput_to"
                  class="task_input_date"
                   placeholder="終了日"
                />
                <input
                  type="text"
                  id="taskhead_timeinput_to"
                  class="task_input_times"
                  placeholder="終了時間"
                />
              </li>
            </div>
          </li>
          <hr>
          <li class="task_input_li">
            
            <input type="text" id="taskhead_plansinput" class="col-9" placeholder="内容を入力…" />
            <input type="text" id="taskhead_time_spend" class="col-2" placeholder="所要時間（分）" />
            <br/>
            <input type="text" id="taskhead_plansinput" class="col-11" placeholder="メモを入力…" />
            <br>
            <button type="button" class="btn btn-primary" >追加</button>
          </li>
         
       
        </ul>
        <div class="text-right">
          <button type="button" class="btn btn-primary ">登録</button>
        </div>
      </div>

      <!-- タスク一覧部分 -->
      <div v-for="item in tasklist" v-bind:key="item.id">

        <div class="tasks">
          <label for="checkdone" class="task_head_text"> {{ item.order_num }} 番目 </label>
          <ul style="list-style: none">

           
            <li class="task_header_li">
              
              <input
                type="checkbox"
                class="taskheader_checkbox"
                v-bind:id="item.id"
                v-bind:value="item.id"
                @change="checkHeaders(item.id)"
              />
              <label for="checkdone" class="task_head_text"> {{ item.title }} </label>
            </li>

            <ul
              v-for="details in item.task_plan_lists"
              v-bind:key="details.id"
              style="list-style: none"
              class="task_detail"
            >
              <input
                type="checkbox"
                class="tasklist_checkbox"
                v-bind:id="details.id"
                v-bind:value="details.id"
                v-bind:data-task-header="item.id"
                @change="planCheckBoxSelected(item.id, details.id)"
              />
              <label for="checkdone" class="task_detail_text" > {{ details.title }} </label>
            </ul>
          </ul>
        </div>
      </div>
    </div>

    <div class="col-3 right">
      <ul
        id="right-sidebar"
        class="nav-sidebar"
        style="list-style: none; padding-left: 0"
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
      checkdone: [],
      tasklist: [],
    };
  },
  methods: {
    //ヘッダがチェックされたときに発火するやつ。
    checkHeaders(headid) {
      let headerelem = document.getElementById(headid);
      //ヘッダのチェックがFalseの場合のみチェックをつける。
      if (headerelem.checked != false) {
        this.checkPlanListByHeaderId(headid, true);
      }
    },
    //ヘッダIDチェック時の処理
    checkPlanListByHeaderId(dataval, checked) {
      //チェックをつけたときだけ子要素のチェックを完了させる
      let elems = this.getTaskHeaderElem(dataval);
      for (let i = 0; i < elems.length; i++) {
        elems[i].checked = checked;
      }
    },
    //内容チェックボックスが押されたときの処理
    planCheckBoxSelected(headid, planid) {
      let headerelement = document.getElementById(headid);
      let planelement = document.getElementById(planid);

      //ヘッダのチェックボックスがfalseかつ、内容のチェックボックスOFFのときはヘッダを自動でOffにする
      if ((planelement.checked != true) & (headerelement.checked != true)) {
        headerelement.checked = true;
      }
      let elems = this.getTaskHeaderElem(headid);
      let allchecked = false;
      let counts = 0;
      for (let i = 0; i < elems.length; i++) {
        //TRUEならカウントに追加
        counts = elems[i].checked ? counts + 1 : counts;
      }
      //総数がカウントと同数ならヘッダチェックをつける
      allchecked = counts === elems.length;

      headerelement.checked = allchecked;
    },
    //タスクヘッダの要素を取得する
    getTaskHeaderElem(dataval) {
      return document
        .getElementById("task_lists")
        .querySelectorAll('[data-task-header="' + dataval + '"]');
    },
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
