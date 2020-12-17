
-- タスク予定ヘッダ と　タスク内容のテストデータをランダム生成する
 with task_plan_headers as (
select
	row_number() over() as rows ,
	id
from
	public.t_task_plan_headers ),
--タスクプランリストのIDのアレ
task_plan_lists as (
select
	id,
	row_number() over() as rows
from
	public.t_task_plan_lists )
	

INSERT INTO public.t_task_head_plan_linking
(t_task_plan_headers_id, t_task_plan_id, updated_at, created_at, created_user_uuid)


	
select
	--INSERT内容
 t_task_plan_headers_id ,
	task_plan_lists.id as t_task_plan_list_id
	, now() as created_at
	, now() as updated_at
	, gen_random_uuid() as created_user_uuid
from
	(
	--このへんでヘッダIDを３ずつ取得させる。
	select
		task_plan_headers.id as t_task_plan_headers_id ,
		row_number() over() as ROWS_ORIG
	from
		task_plan_headers
	left join (
		select
			numbers.nums / 3 as numbers
		from
			(
			select
				row_number() over() as nums
			from
				generate_series(3, 1000) ) as numbers )as rowdiv on
		rowdiv.numbers = task_plan_headers.rows ) HEAD
left join task_plan_lists on
	HEAD.ROWS_ORIG = task_plan_lists.rows