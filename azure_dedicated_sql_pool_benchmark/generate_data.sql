;with n10 as (
    select 0 n union select 1 union select 2 union select 3 union 
    select 4 union select 5 union select 6 union select 7 union select 8 union select 9
)
select n 
  into nn10 
  from n10 
;

with n100 as (select n1.n*10+n2.n as n from nn10 n1,nn10 n)
select n
  into nn100
  from n100 
;


with n1000 as (select n1.n*10+n2.n as n from nn100 n1,nn10 n2)
select *
  into nn1000
  from n1000 
;


create table nn1M with(distribution = replicate ,clustered columnstore index)
as
with nn1M as (
    select n1.n*1000+n2.n as n,
           dateadd(second, (n1.n*1000+n2.n)*8.64, '2021-01-01') as ts,
           cast(format(dateadd(second, (n1.n*1000+n2.n)*8.64, '2021-01-01'), 'yyyyMMdd') as bigint) dt
      from nn1000 n1,nn1000 n2
)
select *
  from nn1M 
;

create table nn10M with(distribution = replicate ,clustered columnstore index)
as
with nn10M as (
    select nn1M.n as o,
           nn10.n as l,
           nn1M.n*10+nn10.n as n,
           dateadd(second, (nn1M.n*10+nn10.n)*0.864, '2021-01-01') as ts,
           cast(format(dateadd(second, (nn1M.n*10+nn10.n)*0.864, '2021-01-01'), 'yyyyMMdd') as bigint) dt,
           product_10K_sk = abs(checksum(newid()))%10000,
           product_100K_sk = abs(checksum(newid()))%100000,
           customer_1M_sk = abs(checksum(newid()))%1000000,
           customer_10M_sk = abs(checksum(newid()))%10000000,
           shipping_amount = cast(abs(checksum(reverse(nn1M.n*10+nn10.n)))%10000 / 100. as numeric (22, 4)),
           tax_amount = cast(abs(checksum(reverse(nn1M.n*10+nn10.n)))%100000 / 100. * (5.+5.*abs(checksum(newid()))%100/100.) as numeric (22, 4)),
           total_amount = cast(abs(checksum(reverse(nn1M.n*10+nn10.n)))%100000 / 100. as numeric (22, 4))
      from nn1M, nn10
)
select *
  from nn10M
;

select top 1 * from nn10M;
update statistics nn10m;

/*************************************************************************************************
Table: dim_product, 10K and 100K records
*************************************************************************************************/
insert into dim_product_10K
select -- top 10
       product_sk = n1k.n*10 + n1k2.n,
       product_bk = 'bk_' + cast(reverse(n1k.n*10 + n1k2.n) as varchar),
       start_date = cast('2000-01-01 00:00:00' as datetime),
       end_date = cast('9999-12-31 23:59:59' as datetime),
       category_id = ntile(1000) over (order by n1k.n*10 + n1k2.n),
       category = 'category_' + cast(ntile(1000) over (order by n1k.n*10 + n1k2.n) as varchar),
       subcategory_id = ntile(2000) over (order by n1k.n*10 + n1k2.n),
       subcategory = 'subcategory_' + cast(ntile(2000) over (order by n1k.n*10 + n1k2.n) as varchar),
       product = 'product_' + cast(reverse(n1k.n*10 + n1k2.n) as varchar),
       description = 'prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description '
  from nn1000 n1k, nn10 n1k2
 where n1k.n*10 + n1k2.n < 9500 
 ; 
-- scd type 2 records
insert into dim_product_10K
select product_sk = n1k.n*10 + n1k2.n + 250 * c.c,
       product_bk = 'bk_' + cast(reverse(n1k.n*10 + n1k2.n) as varchar),
       start_date = case when c.c = 0 then cast('2000-01-01 00:00:00' as datetime) 
                         else dateadd(day, abs(checksum(n1k.n*10 + n1k2.n + 250))%100, '2021-01-01')
                    end,     
       end_date = case when c.c = 0 then dateadd(day, abs(checksum(n1k.n*10 + n1k2.n + 250 ))%100, '2021-01-01') 
                       else cast('9999-12-31 23:59:59' as datetime)
                  end, 
       category_id = ntile(25) over (order by n1k.n*10 + n1k2.n) + 1000,
       category = 'category_' + cast(ntile(25) over (order by n1k.n*10 + n1k2.n) + 1000 as varchar),
       subcategory_id = ntile(50) over (order by n1k.n*10 + n1k2.n) + 2000,
       subcategory = 'subcategory_' + cast(ntile(50) over (order by n1k.n*10 + n1k2.n) + 2000 as varchar),
       product = 'product_' + cast(reverse(n1k.n*10 + n1k2.n) as varchar) + case when c.c = 0 then '' else 'c' end,
       description = 'prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description '
  from nn1000 n1k, nn10 n1k2,
       (select 0 as c union all select 1 as c) c 
 where n1k.n*10 + n1k2.n >= 9500
   and n1k.n*10 + n1k2.n < 9750 
 ; 



insert into dim_product_100K
select -- top 10
       product_sk = n1k.n*100 + n1k2.n,
       product_bk = 'bk_' + cast(reverse(n1k.n*100 + n1k2.n) as varchar),
       start_date = cast('2000-01-01 00:00:00' as datetime),
       end_date = cast('9999-12-31 23:59:59' as datetime),
       category_id = ntile(1000) over (order by n1k.n*100 + n1k2.n),
       category = 'category_' + cast(ntile(1000) over (order by n1k.n*100 + n1k2.n) as varchar),
       subcategory_id = ntile(2000) over (order by n1k.n*100 + n1k2.n),
       subcategory = 'subcategory_' + cast(ntile(2000) over (order by n1k.n*100 + n1k2.n) as varchar),
       product = 'product_' + cast(reverse(n1k.n*100 + n1k2.n) as varchar),
       description = 'prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description '
  from nn1000 n1k, nn100 n1k2
 where n1k.n*100 + n1k2.n < 95000 
 ; 
-- scd type 2 records
insert into dim_product_100K
select product_sk = n1k.n*100 + n1k2.n + 250 * c.c,
       product_bk = 'bk_' + cast(reverse(n1k.n*100 + n1k2.n) as varchar),
       start_date = case when c.c = 0 then cast('2000-01-01 00:00:00' as datetime) 
                         else dateadd(day, abs(checksum(n1k.n*100 + n1k2.n + 250))%100, '2021-01-01')
                    end,     
       end_date = case when c.c = 0 then dateadd(day, abs(checksum(n1k.n*100 + n1k2.n + 250 ))%100, '2021-01-01') 
                       else cast('9999-12-31 23:59:59' as datetime)
                  end, 
       category_id = ntile(25) over (order by n1k.n*100 + n1k2.n) + 1000,
       category = 'category_' + cast(ntile(25) over (order by n1k.n*100 + n1k2.n) + 1000 as varchar),
       subcategory_id = ntile(50) over (order by n1k.n*100 + n1k2.n) + 2000,
       subcategory = 'subcategory_' + cast(ntile(50) over (order by n1k.n*100 + n1k2.n) + 2000 as varchar),
       product = 'product_' + cast(reverse(n1k.n*100 + n1k2.n) as varchar) + case when c.c = 0 then '' else 'c' end,
       description = 'prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description '
  from nn1000 n1k, nn100 n1k2,
       (select 0 as c union all select 1 as c) c 
 where n1k.n*100 + n1k2.n >= 95000
   and n1k.n*100 + n1k2.n < 97500 
 ; 




/*************************************************************************************************
Table: dim_customer, 1M and 10M records
*************************************************************************************************/
insert into dim_customer_1M
select -- top 10
       customer_sk = n1k.n*1000 + n1k2.n,
       customer_bk = 'bk_' + cast(reverse(n1k.n*1000 + n1k2.n) as varchar),
       category_id = ntile(1000) over (order by n1k.n*1000 + n1k2.n),
       category = 'customer_category_' + cast(ntile(1000) over (order by n1k.n*1000 + n1k2.n) as varchar),
       subcategory_id = ntile(10000) over (order by n1k.n*1000 + n1k2.n),
       subcategory = 'subcategory_' + cast(ntile(10000) over (order by n1k.n*1000 + n1k2.n) as varchar),
       full_name = 'Full_Name_' + cast(reverse(n1k.n*1000 + n1k2.n) as varchar),
       description = 'prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description '
  from nn1000 n1k, nn1000 n1k2 
 ; 


insert into dim_customer_10M
select -- top 10
       customer_sk = (n1k.n*1000 + n1k2.n)*10 + n10.n,
       customer_bk = 'bk_' + cast(reverse((n1k.n*1000 + n1k2.n)*10 + n10.n) as varchar),
       category_id = ntile(1000) over (order by (n1k.n*1000 + n1k2.n)*10 + n10.n),
       category = 'customer_category_' + cast(ntile(1000) over (order by (n1k.n*1000 + n1k2.n)*10 + n10.n) as varchar),
       subcategory_id = ntile(10000) over (order by (n1k.n*1000 + n1k2.n)*10 + n10.n),
       subcategory = 'subcategory_' + cast(ntile(10000) over (order by (n1k.n*1000 + n1k2.n)*10 + n10.n) as varchar),
       full_name = 'Full_Name_' + cast(reverse((n1k.n*1000 + n1k2.n)*10 + n10.n) as varchar),
       description = 'prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description '
  from  nn1000 n1k, nn1000 n1k2, nn10 n10
 ; 

insert into dim_customer_100M
select -- top 10
       customer_sk = nn10M.n*10 + n10.n,
       customer_bk = 'bk_' + cast(reverse((nn10M.n*10 + n10.n)) as varchar),
       category_id = ntile(100) over (order by (n10.n)),
       category = 'customer_category_' + cast(ntile(100) over (order by (n10.n)) as varchar),
       subcategory_id = ntile(10000) over (order by (nn10M.n*10 + n10.n)),
       subcategory = 'subcategory_' + cast(ntile(10000) over (order by (nn10M.n*10 + n10.n)) as varchar),
       full_name = 'Full_Name_' + cast(reverse((nn10M.n*10 + n10.n)) as varchar),
       description = 'prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description prety long description '
  from  nn10M, nn10 n10
 ; 



/*************************************************************************************************
Table: dim_date
*************************************************************************************************/

insert into dim_date
select date_sk = cast(format(dateadd(day, n.n, '2021-01-01'), 'yyyyMMdd') as int),
       day = cast(dateadd(day, n.n, '2021-01-01') as date),
       month_id = cast(format(dateadd(day, n.n, '2021-01-01'), 'yyyyMM') as int),
       month = format(dateadd(day, n.n, '2021-01-01'), 'yyyy-MMM'),
       month_id = cast(format(dateadd(day, n.n, '2021-01-01'), 'yyyy') as int)
  from nn100 n
;


/*************************************************************************************************
Table: fact_order_line
*************************************************************************************************/


insert into fact_order_line_10M
select order_id = nn1M.n,
       line_item_id = n10.n,
       order_timestamp = nn1M.ts,
       order_date_sk = nn1M.dt,
       product_10K_sk = abs(checksum(newid()))%10000,
       product_100K_sk = abs(checksum(newid()))%100000,
       customer_1M_sk = abs(checksum(newid()))%1000000,
       customer_10M_sk = abs(checksum(newid()))%10000000,
       shipping_amount = cast(abs(checksum(reverse(nn1M.n)))%10000 / 100. as numeric (22, 4)),
       tax_amount = cast(abs(checksum(reverse(nn1M.n)))%100000 / 100. * (5.+5.*abs(checksum(newid()))%100/100.) as numeric (22, 4)),
       total_amount = cast(abs(checksum(reverse(nn1M.n)))%100000 / 100. as numeric (22, 4))
  from nn1M, 
       nn10 n10
;

-- version 2
insert into fact_order_line_10M
select order_id = nn10M.o,
       line_item_id = nn10M.l,
       order_timestamp = nn10M.ts,
       order_date_sk = nn10M.dt,
       product_10K_sk = nn10M.product_10K_sk,
       product_100K_sk = nn10M.product_100K_sk,
       customer_1M_sk = nn10M.customer_1M_sk,
       customer_10M_sk = nn10M.customer_10M_sk,
       shipping_amount = nn10M.shipping_amount,
       tax_amount = nn10M.tax_amount,
       total_amount = nn10M.total_amount
  from nn10M
;





insert into fact_order_line_100M
select order_id = nn10M.n,
       line_item_id = nn10.n,
       order_timestamp = nn10M.ts,
       order_date_sk = nn10M.dt,
       product_10K_sk = nn10M.product_10K_sk,
       product_100K_sk = nn10M.product_100K_sk,
       customer_1M_sk = nn10M.customer_1M_sk,
       customer_10M_sk = nn10M.customer_10M_sk,
       shipping_amount = nn10M.shipping_amount,
       tax_amount = nn10M.tax_amount,
       total_amount = nn10M.total_amount
  from nn10M, nn10
;




insert into fact_order_line_100M_2
select order_id = nn10M.n,
       line_item_id = nn10.n,
       order_timestamp = nn10M.ts,
       order_date_sk = nn10M.dt,
       product_100K_1_sk = nn10M.product_100K_sk,
       product_100K_2_sk = nn10M.product_100K_sk,
       product_100K_3_sk = nn10M.product_100K_sk,
       customer_1M_1_sk = nn10M.customer_1M_sk,
       customer_1M_2_sk = nn10M.customer_1M_sk,
       shipping_amount = nn10M.shipping_amount,
       tax_amount = nn10M.tax_amount,
       total_amount = nn10M.total_amount
  from nn10M, nn10
;

insert into fact_order_line_100M_3
select order_id = nn10M.n,
       line_item_id = nn10.n,
       order_timestamp = nn10M.ts,
       order_date_sk = nn10M.dt,
       product_100K_1_sk = nn10M.product_100K_sk,
       product_100K_2_sk = nn10M.product_100K_sk,
       product_100K_3_sk = nn10M.product_100K_sk,
       customer_1M_1_sk = nn10M.customer_1M_sk,
       customer_1M_2_sk = nn10M.customer_1M_sk,
       customer_1M_3_sk = nn10M.customer_1M_sk,
       shipping_amount = nn10M.shipping_amount,
       tax_amount = nn10M.tax_amount,
       total_amount = nn10M.total_amount
  from nn10M, nn10
;



insert into fact_order_line_1B
select order_id = nn10M.n*10+nn10.n,
       line_item_id = n2.n,
       order_timestamp = nn10M.ts,
       order_date_sk = nn10M.dt,
       product_10K_sk = nn10M.product_10K_sk,
       product_100K_sk = nn10M.product_100K_sk,
       customer_1M_sk = nn10M.customer_1M_sk,
       customer_10M_sk = nn10M.customer_10M_sk,
       shipping_amount = nn10M.shipping_amount,
       tax_amount = nn10M.tax_amount,
       total_amount = nn10M.total_amount
  from nn10M, nn10, nn10 n2
;


insert into fact_order_line_1B_cust_hash
select order_id = nn10M.n*10+nn10.n,
       line_item_id = n2.n,
       order_timestamp = nn10M.ts,
       order_date_sk = nn10M.dt,
       customer_100M_1_sk = nn10M.customer_10M_sk * 10 + n2.n, 
       customer_100M_2_sk = nn10M.customer_10M_sk * 10 + nn10.n, 
       shipping_amount = nn10M.shipping_amount,
       tax_amount = nn10M.tax_amount,
       total_amount = nn10M.total_amount
  from nn10M, nn10, nn10 n2
;



insert into fact_order_line_100M_rep select * from fact_order_line_100M;
insert into fact_order_line_100M_rr select * from fact_order_line_100M;
insert into fact_order_line_100M_heap select * from fact_order_line_100M;
  
insert into fact_order_line_10M_rep select * from fact_order_line_10M;
insert into fact_order_line_10M_rr select * from fact_order_line_10M;
insert into fact_order_line_10M_heap select * from fact_order_line_10M;




insert into dim_customer_1M_cl select * from dim_customer_1M;
insert into dim_product_100K_cl select * from dim_product_100K;


insert into dim_customer_10M_hash select * from dim_customer_10M;
insert into dim_customer_100M_hash select * from dim_customer_100M;
insert into dim_customer_100M_hash_bk select * from dim_customer_100M;





insert into fact_order_line_100M_cust_hash select * from fact_order_line_100M;

