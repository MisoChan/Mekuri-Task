<template>
  <div class="row">
    <!-- メイン部分  -->
    <div id="task_lists" class="col-9">
      <!-- タスク入力部分 -->
      <div id="task_input_box" class="tasks">
        <div id="head_title table-responsive">
          <table class="table table-borderless ">
            <tr >
              <td class="col-10">
                {{today}} のタスク一覧
              </td>
              
              <td  align="right" >
                + ADD TASK 
              </td>
            </tr>
          </table>

          <hr />
        </div>
        <ul style="list-style: none">
          <li class="task_input_li">
            <div class="head_timeset">
              
              <li class="task_input_li ">
               
                <input
                type="text"
                id="taskhead_titleinput"
                class="col-8"
                v-model="task_head_title"
                placeholder="タスク タイトル"
                @keydown.prevent.enter="selectId('taskhead_timeinput_from')"
              />
               
                <input
                  type="text"
                  id="taskhead_timeinput_from"
                  
                   v-model="task_date_begin_time"
                  class="task_input_times"
                  placeholder="開始時間"
                  @keydown.prevent.enter="selectId('taskhead_timeinput_to')"
                />
                <a>- ></a>
                <input
                  type="text"
                  id="taskhead_timeinput_to"
                  v-model="task_date_end_time"
                  class="task_input_times"
                  placeholder="終了時間"
                />

              
 
              </li>
              <li>
                <input
                  type="text"
                  id="taskhead_plansinput"
                  v-model="task_head_memo"
                  class="col-11"
                  placeholder="メモを入力…"
                />
              </li>
            </div>
          </li>
          <hr />
          <div v-for="(plan,index) in taskplans" v-bind:key="plan.key">
            <li class="task_input_li task_plans" v-bind:data-planid="plan.key" >
              
              <input
                type="text"
                class="col-9 taskplan_titles"
                v-model="plan.title"
                placeholder="内容を入力…"
                v-bind:id="plan.key"
                @keydown.prevent.enter="selectId(plan.key+'_TIME')"
              />
              <input
                type="text"
                class="col-2"
                v-model="plan.reqtime"
                v-bind:id="plan.key+'_TIME'"
                v-bind:data-nextkey="plan.nextkey"
                @keypress="validateNum"
                @input="plan.reqtime = format(plan.reqtime)"
              @keydown.prevent.enter="dupeTaskPlanLists(index)"

                placeholder="所要時間（分）"
              />
              <button type="button" class="btn btn-primary plan_delete"  @click="deleteTaskPlan(index)">削除</button>
            </li>
          </div>
        </ul>
        <ul style="list-style: none">
           <li class="task_input_li" > 
            <button type="button" class="btn btn-primary" @click="dupeTaskPlan()">こまかい内容追加</button>
          </li>  
        </ul>
        <div class="text-right">
          <button type="button" class="btn btn-primary " @click="sendAddTaskRequest()">登録</button>
        </div>
      </div>

      <!-- タスク一覧部分 -->
      <div v-for="item in tasklist" v-bind:key="item.id">
        <div class="tasks">
          <label for="checkdone" class="task_head_text">
            {{ item.order_num }} 番目
          </label>
          <ul style="list-style: none">
            <li class="task_header_li">
              <input
                type="checkbox"
                class="taskheader_checkbox"
                v-bind:id="item.id"
                v-bind:value="item.id"
                @change="checkHeaders(item.id)"
              />
              <label for="checkdone" class="task_head_text">
                {{ item.title }}
              </label>
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
              <label for="checkdone" class="task_detail_text">
                {{ details.title }}
              </label>
            </ul>
          </ul>
        </div>
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
import Mixins from "./modules/common_vue_mixin.js";

export default {
  mixins: [Mixins],
  data: function() {
    
    return {
      task_head_title: "",
      task_date_begin: "",
      task_date_end: "",
      task_date_begin_time: "",
      task_date_end_time: "",
      task_head_memo: "",
      DatePickerFormat: 'yyyy-MM-dd',
      checkdone: [],
      tasklist: [],
      taskplans: [
        { key: 0,
        title: "",
        reqtime:""
        }
        ],
      today:(new Date()),
      modelConfig: {
        type: 'string',
      },
      //内容の追加を行ってもいいか
      canAddPlan : false
    };
  },
  methods: {
 
    //ヘッダがチェックされたときに発火するやつ。
    checkHeaders: function(headid) {
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

    async reverseTaskPlanLists(list_index){

    },

    //内容追加ボタン用 タスク内容の新規追加を行う
    dupeTaskPlan(){
      var list_index = this.taskplans.length-1;
      this.dupeTaskPlanLists(list_index);
    },
    //タスク内容の新規追加を行う。
    async dupeTaskPlanLists(list_index){
    
    var randid = Math.random().toString(36).slice(8);
    //インデックスを取得
      var index = this.taskplans[list_index];

      var canSelect = false;
      var canAddPlan = false;
      var isTitleInput = !index.title ;
      var isReqTimeInput = !index.reqtime;
      //直近の入力項目がEmptyではない？
      if(!isTitleInput && !isReqTimeInput){
        //次のインデックスが存在する？
        if(list_index === (this.taskplans.length-1)){
          //empty→追加
          this.addTaskPlan(randid);
          canAddPlan = true;
        }else{
          
          canSelect=true
        }
        
      }
     // DOM が更新されるのを待つ
      await this.$nextTick();
        //選択可能？
        if(canSelect){
          var next_index = this.taskplans[list_index+1].key;
          this.selectId(next_index);
        }
        //それとも新規追加？
        else if(canAddPlan){
          var plans = document.getElementById(randid);
          plans.select();
      }
    },

    async addTaskPlan(randid){
      var taskplan_datatemplate  = 
                  { key: randid,
                  title: "",
                  reqtime:""
                  };
                  
        this.taskplans.push(taskplan_datatemplate);
        
    },

    
    //タスク内容の削除を行う。
    deleteTaskPlan(index){
      this.taskplans.splice(index,1);
    },
    //タスクリストの登録処理
    sendAddTaskRequest: function(){
      var task_title_txt = document.getElementById('taskhead_titleinput').value;


      axios.defaults.headers.common = {
         'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      }
      axios.post("/task_lists",{
        task_head_title: this.task_head_title,
        task_date_begin: this.task_date_begin,
        task_date_end: this.task_date_end,
        task_head_memo: this.task_head_memo,
        task_date_begin_time: this.task_date_begin_time,
        task_date_end_time: this.task_date_end_time,
        task_plans:this.taskplans
      }    
      ).then(function (response){
        console.log(response)
      });
     
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
  mounted() {

  },
  //値の変更監視
  watch(){

  }
};
</script>
