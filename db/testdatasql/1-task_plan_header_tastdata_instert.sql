INSERT INTO public.t_task_plan_headers( 
	 id,
	 title,
	 memo,
	 order_num,
	 plan_start_date,
	 plan_end_date,
	 created_at,
	 updated_at,
	 created_user_uuid )
select 
	gen_random_uuid() as id
	, 'ヘッダタイトルその'||row_number() OVER() as title
	,'MEMO'|| row_number() OVER() as memo
	, mod(row_number() over(),6)+1 as order_num
	, now() as plan_start_data
	, now() as plan_end_data
	, now() as created_at
	, now() as updated_at
	, gen_random_uuid() as created_user_uuid 
from 
	pg_catalog.generate_series(1,1000)