

-- Test 1.1
DBCC DROPCLEANBUFFERS; DBCC FREEPROCCACHE;
-- Small Range Queries
select product_sk, product_bk, category, subcategory, product_bk, [description] from dim_product_100K where product_sk in (50000,50001,50002,50003,50004)  option(label='test_1_1_01_small_range_dim_product_100K_01');
select product_sk, product_bk, category, subcategory, product_bk, [description] from dim_product_100K where product_bk in ('bk_50001','bk_50003','bk_50005','bk_50007','bk_5')  option(label='test_1_1_02_small_range_dim_product_100K_02');
select customer_sk, customer_bk, category_id, subcategory, full_name, [description] from dim_customer_1M where customer_sk in (500001,500000,500003,500002,500005)  option(label='test_1_1_03_small_range_dim_customer_1M_01');
select customer_sk, customer_bk, category_id, subcategory, full_name, [description] from dim_customer_1M where customer_bk in ('bk_000005','bk_100005','bk_300005','bk_500005','bk_700005')  option(label='test_1_1_04_small_range_dim_customer_1M_02');
select customer_sk, customer_bk, category_id, subcategory, full_name, [description] from dim_customer_10M where customer_sk in (5000000,5000001,5000003,5000005,5000007)  option(label='test_1_1_05_small_range_dim_customer_10M_01');
select customer_sk, customer_bk, category_id, subcategory, full_name, [description] from dim_customer_10M where customer_bk in ('bk_0000005','bk_2000005','bk_4000005','bk_6000005','bk_1000005')  option(label='test_1_1_06_small_range_dim_customer_10M_02');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M where order_id = 500000  option(label='test_1_1_07_small_range_fact_order_line_10M_01');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M where customer_10M_sk = 9253173  option(label='test_1_1_08_small_range_fact_order_line_10M_02');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M where order_id = 5000000  option(label='test_1_1_09_small_range_fact_order_line_100M_01');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M where customer_10M_sk = 9253173  option(label='test_1_1_10_small_range_fact_order_line_100M_02');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B where order_id = 5000000  option(label='test_1_1_11_small_range_fact_order_line_1B_01');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B where customer_10M_sk = 9253173  option(label='test_1_1_12_small_range_fact_order_line_1B_02');
  -- Bigger Range 
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M  where product_100K_sk = 12343 option(label='test_1_1_13_big_range_fact_order_line_10M_01');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M where product_100K_sk = 12343 option(label='test_1_1_14_big_range_fact_order_line_100M_01');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_1_15_big_range_fact_order_line_100M_02');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B   where product_100K_sk = 12343 option(label='test_1_1_16_big_range_fact_order_line_1B_01');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B   where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_1_17_big_range_fact_order_line_1B_02');
  -- Full Scan
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M option(label='test_1_1_18_full_scan_fact_order_line_10M');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M option(label='test_1_1_19_full_scan_fact_order_line_100M');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B option(label='test_1_1_20_full_scan_fact_order_line_1B');


-- Test 1.2
DBCC DROPCLEANBUFFERS; DBCC FREEPROCCACHE;
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B      where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_2_01_fact_order_line_1B');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B_ord2 where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_2_02_fact_order_line_1B_ord2');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B_ord3 where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_2_03_fact_order_line_1B_ord3');
DBCC DROPCLEANBUFFERS; DBCC FREEPROCCACHE;
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B      where order_timestamp between '2021-02-01' and '2021-02-10' option(label='test_1_2_04_fact_order_line_1B_');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B_ord2 where order_timestamp between '2021-02-01' and '2021-02-10' option(label='test_1_2_05_fact_order_line_1B_ord2_');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_1B_ord3 where order_timestamp between '2021-02-01' and '2021-02-10' option(label='test_1_2_06_fact_order_line_1B_ord3_');


-- Test 1.3
DBCC DROPCLEANBUFFERS; DBCC FREEPROCCACHE;
select customer_sk, customer_bk, category_id, subcategory, full_name, [description] from dim_customer_10M where customer_sk in (5000000,5000001,5000003,5000005,5000007)  option(label='test_1_3_01_small_range_dim_customer_10M_01');
select customer_sk, customer_bk, category_id, subcategory, full_name, [description] from dim_customer_10M_cl where customer_sk in (5000000,5000001,5000003,5000005,5000007)  option(label='test_1_3_02_small_range_dim_customer_cl_10M_01');
select count(*), min(customer_bk), max(full_name) from dim_customer_10M where category_id = 204 option(label='test_1_3_03_bigger_range_dim_customer_10M');
select count(*), min(customer_bk), max(full_name) from dim_customer_10M_cl where category_id = 204 option(label='test_1_3_04_bigger_range_dim_customer_10M_idx');
select top 20 category_id, min(customer_bk), max(full_name) from dim_customer_10M group by category_id order by min(customer_bk) option(label='test_1_3_05_full_scan_dim_customer_10M'); 
select top 20 category_id, min(customer_bk), max(full_name) from dim_customer_10M_cl group by category_id order by min(customer_bk) option(label='test_1_3_06_full_scan_dim_customer_10M');



-- Test 1.4
DBCC DROPCLEANBUFFERS; DBCC FREEPROCCACHE;
select count(*) from fact_order_line_1B where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_4_1column');
select count(*), sum(total_amount) from fact_order_line_1B where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_4_2columns');
select count(*), sum(total_amount), sum(shipping_amount) from fact_order_line_1B where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_4_3columns');
select count(*), sum(total_amount), sum(shipping_amount), sum(tax_amount) from fact_order_line_1B where order_timestamp between '2021-02-01' and '2021-03-01' option(label='test_1_4_4columns');
select count(*), sum(total_amount), sum(shipping_amount), sum(tax_amount) from fact_order_line_1B where order_timestamp between '2021-02-01' and '2021-03-01' and order_date_sk between 20210201 and 20210301 option(label='test_1_4_5columns');


-- Test 1.5
DBCC DROPCLEANBUFFERS; DBCC FREEPROCCACHE;
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M where order_id = 500000  option(label='test_1_5_01_small_range_fact_order_line_10M');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M_rep where order_id = 500000  option(label='test_1_5_02_small_range_fact_order_line_10M_rep');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M_rr where order_id = 500000  option(label='test_1_5_03_small_range_fact_order_line_10M_rr');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M  where product_100K_sk = 12343 option(label='test_1_5_05_big_range_fact_order_line_10M');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M_rep  where product_100K_sk = 12343 option(label='test_1_5_06_big_range_fact_order_line_10M_rep');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M_rr  where product_100K_sk = 12343 option(label='test_1_5_07_big_range_fact_order_line_10M_rr');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M option(label='test_1_5_09_full_scan_fact_order_line_10M');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M_rep option(label='test_1_5_10_full_scan_fact_order_line_10M_rep');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_10M_rr option(label='test_1_5_11_full_scan_fact_order_line_10M_rr');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M where order_id = 500000  option(label='test_1_5_21_small_range_fact_order_line_100M');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M_rep where order_id = 500000  option(label='test_1_5_22_small_range_fact_order_line_100M_rep');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M_rr where order_id = 500000  option(label='test_1_5_23_small_range_fact_order_line_100M_rr');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M  where product_100K_sk = 12343 option(label='test_1_5_25_big_range_fact_order_line_100M');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M_rep  where product_100K_sk = 12343 option(label='test_1_5_26_big_range_fact_order_line_100M_rep');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M_rr  where product_100K_sk = 12343 option(label='test_1_5_27_big_range_fact_order_line_100M_rr');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M option(label='test_1_5_29_full_scan_fact_order_line_100M');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M_rep option(label='test_1_5_30_full_scan_fact_order_line_100M_rep');
select count(*), sum(total_amount), sum(shipping_amount), avg(tax_amount) from fact_order_line_100M_rr option(label='test_1_5_31_full_scan_fact_order_line_100M_rr');




DBCC DROPCLEANBUFFERS; DBCC FREEPROCCACHE;
--------------------------------------------------------------------------------------------------
-- Test Large to Small Tables;
--------------------------------------------------------------------------------------------------
-- Test 2.1
select top 50 d.date_sk, max(d.day), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_10M f 
       inner join dim_date d on f.order_date_sk = d.date_sk
 group by d.date_sk
 order by d.date_sk
option(label='2_1_f10m_d100');


select top 50 d.date_sk, max(d.day), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M f 
       inner join dim_date d on f.order_date_sk = d.date_sk
 group by d.date_sk
 order by d.date_sk
option(label='2_1_f100m_d100');

select top 50 d.date_sk, max(d.day), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B f 
       inner join dim_date d on f.order_date_sk = d.date_sk
 group by d.date_sk
 order by d.date_sk
option(label='2_1_f1B_d100');


-- Join to 10K dimension
select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_10M f 
       inner join dim_product_10K d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f10m_d10K');


select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M f 
       inner join dim_product_10K d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f100m_d10K');

select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B f 
       inner join dim_product_10K d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f1B_d10K');



-- Join to 100K dimension
select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_10M f 
       inner join dim_product_100K d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f10m_d100K');

select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M f 
       inner join dim_product_100K d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f100m_d100K');

select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B f 
       inner join dim_product_100K d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f1B_d100K');



-- Join to 1M dimension
select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_10M f 
       inner join dim_customer_1M d on f.customer_1M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f10m_d1M');


select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M f 
       inner join dim_customer_1M d on f.customer_1M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f100m_d1M');


select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B f 
       inner join dim_customer_1M d on f.customer_1M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_1_f1B_d1M');




-- Test #2.2: More Dimension Tables to Join
select top 50 max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_3 f 
       inner join dim_customer_1M d on f.customer_1M_1_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_2_f100m_d1M_1time');

select top 50 max(dp1.category), max(dp2.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_3 f 
       inner join dim_customer_1M dp1 on f.customer_1M_1_sk = dp1.customer_sk
       inner join dim_customer_1M dp2 on f.customer_1M_2_sk = dp2.customer_sk
 group by dp1.category_id, dp2.category_id
 order by sum(f.total_amount) desc
option(label='2_2_f100m_d1M_2times');


select top 50 max(dp1.category), max(dp2.category), max(dp3.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_3 f 
       inner join dim_customer_1M dp1 on f.customer_1M_1_sk = dp1.customer_sk
       inner join dim_customer_1M dp2 on f.customer_1M_2_sk = dp2.customer_sk
       inner join dim_customer_1M dp3 on f.customer_1M_3_sk = dp3.customer_sk
 group by dp1.category_id, dp2.category_id, dp3.category_id
 order by sum(f.total_amount) desc
option(label='2_2_f100m_d1M_3times');


select top 50 max(dp1.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_3 f 
       inner join dim_product_100K dp1 on f.product_100K_1_sk = dp1.product_sk
 group by dp1.category_id
 order by sum(f.total_amount) desc
option(label='2_2_f100m_d100K_1time');

select top 50 max(dp1.category), max(dp2.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_3 f 
       inner join dim_product_100K dp1 on f.product_100K_1_sk = dp1.product_sk
       inner join dim_product_100K dp2 on f.product_100K_2_sk = dp2.product_sk
 group by dp1.category_id, dp2.category_id
 order by sum(f.total_amount) desc
option(label='2_2_f100m_d100K_2times');

select top 50 max(dp1.category), max(dp2.category), max(dp3.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_3 f 
       inner join dim_product_100K dp1 on f.product_100K_1_sk = dp1.product_sk
       inner join dim_product_100K dp2 on f.product_100K_2_sk = dp2.product_sk
       inner join dim_product_100K dp3 on f.product_100K_3_sk = dp3.product_sk
 group by dp1.category_id, dp2.category_id, dp3.category_id
 order by sum(f.total_amount) desc
option(label='2_2_f100m_d100K_3times');




-- Test 2.3
select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_10M f 
       inner join dim_product_100K_cl d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_3_f10m_d100K_cl');

select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M f 
       inner join dim_product_100K_cl d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_3_f100m_d100K_cl');

select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B f 
       inner join dim_product_100K_cl d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_3_f1B_d100K_cl');


select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_10M f 
       inner join dim_customer_1M_cl d on f.customer_1M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_3_f10m_d1M_cl');


select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M f 
       inner join dim_customer_1M_cl d on f.customer_1M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_3_f100m_d1M_cl');


select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B f 
       inner join dim_customer_1M_cl d on f.customer_1M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_3_f1B_d1M_cl');


-- Test 2.4
select top 50 d.date_sk, max(d.day), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_rep f 
       inner join dim_date d on f.order_date_sk = d.date_sk
 group by d.date_sk
 order by d.date_sk
option(label='2_4_f100m_d100_rep_rep');

select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_rep f 
       inner join dim_product_10K d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_4_f100m_d10K_rep_rep');

select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_rep f 
       inner join dim_product_100K d on f.product_100K_sk = d.product_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_4_f100m_d100K_rep_rep');

select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_rep f 
       inner join dim_customer_1M d on f.customer_1M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='2_4_f100m_d1M_rep_rep');



-- Test 3.1
select d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B_cust_hash f 
       inner join dim_customer_100M_hash d on f.customer_100M_1_sk = d.customer_sk
 group by d.category_id
option(label='3_1_f1B_d100M_hash_02');

select d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B_cust_hash f 
       inner join dim_customer_100M_hash_bk d on f.customer_100M_2_sk = d.customer_sk
 group by d.category_id
option(label='3_1_f1B_d100M_hash_bk_02');

select d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B_cust_hash f 
       inner join dim_customer_100M d on f.customer_100M_2_sk = d.customer_sk
 group by d.category_id
option(label='3_1_f1B_d100M_nohash_02');


-- Test 3.2
select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B_cust_hash f 
       inner join dim_customer_100M_hash d on f.customer_100M_1_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='3_1_f1B_d100M_hash');


select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_1B_cust_hash f 
       inner join dim_customer_100M d on f.customer_100M_2_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='3_1_f1B_d100M_nohash');




select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M_cust_hash f 
       inner join dim_customer_10M_hash d on f.customer_10M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='3_1_f100m_d10M_hash');


select top 50 d.category_id, max(d.category), avg(f.tax_amount), sum(f.total_amount), sum(f.shipping_amount)
  from fact_order_line_100M f 
       inner join dim_customer_10M d on f.customer_10M_sk = d.customer_sk
 group by d.category_id
 order by sum(f.total_amount) desc
option(label='3_1_f100m_d10M_nohash');
















