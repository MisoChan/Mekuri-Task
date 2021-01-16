<template>
         <div class="row">
            <!-- メイン部分  -->
            <div class="col-9" >

                    <!-- タスク一覧部分 -->
                    <div class="tasks">
                    
                        <ul style="list-style:none">
                            <li class="task_header_li" ><span class="task_header">いもいも</span> 

                            </li>
                        
                            <ul style="list-style:none" class="task_detail">
                                いもぽてと
                            </ul>
                            
                        </ul>
                                
                    </div>



            </div>
     
   

        
            <div class="col-3 right">
                <ul id="right-sidebar" class="nav-sidebar" style="list-style: none; padding-left: 0;">
                
                        <li class="mt-1">
                            <div id="calender" >
                                <a href="#">ここにカレンダー。</a>

                            </div>
                        </li>
                   
               
                        <li class="mt-5">
                            <div id="time_clock">
                                <a href="#">ここに現在時刻</a>
                                https://www.google.co.jp/     </div>
                        </li>
                    
                    
                        <li class="mt-2">
                            <button type="button" class="btn btn-primary">タスク消化スタート！</button>
                        </li>


                 
                </ul>
                
            </div>
        </div>
</template>

<script>
export default {

}
</script>