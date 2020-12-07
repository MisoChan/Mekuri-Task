
-- タスク予定ヘッダ の ROWを取得 + ついでにデータも取る
with task_plan_headers  as (
	SELECT 
	 row_number() OVER() as ROWS ,
	 task_uuid

	FROM public.t_task_plan_headers
)
INSERT INTO public.t_task_plan_lists
(
	task_uuid
	, task_sub_uuid
	, hierarkey_num
	, seq_num
	, title
	, task_memo
	, plan_start_date
	, plan_end_date
	, created_at
	, updated_at
	, created_user_uuid
)
select  
	task_uuid
	, gen_random_uuid() as task_sub_uuid
	
	, mod(row_number() over()/2 ,2) + 1  as hierarkey_num
	, mod(row_number() over(),3)+1 as seq_num
	, 'ないようタイトル'|| mod(row_number() over(),3)+1 as title
	, 'ないようメモ'|| mod(row_number() over(),3)+1 as task_memo
	, now() as plan_start_date
	, now() as plan_end_date
	, now() as created_at
	, now() as updated_at
	, gen_random_uuid() as created_user_uuid
from  task_plan_headers
-- このへんで ３ずつのROWNUM（Oracle表記）を取る。
left join (
	select numbers.nums / 3 as numbers
	from (
		select row_number() over() as nums 
		
		from generate_series(3,1000)
	) as numbers
)rowdivs 
-- 最後にタスク予定ヘッダのROWと 作ったROWNUMをLEFT_JOINで突き合わせる
on rowdivs.numbers = task_plan_headers.rows