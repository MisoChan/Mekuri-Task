<template>
  <!-- タスク一覧部分 -->

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
</template>

<script>
import Mixins from "../modules/common_vue_mixin.js";
export default {
  mixins: [Mixins],
  props: {
    item: {
      type: Object,
      reqired: true,
    },
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
  },
};
</script>
