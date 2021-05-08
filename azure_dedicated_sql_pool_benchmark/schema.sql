drop table dim_product_10K;
create table dim_product_10K (
    product_sk      int not null, -- identity (1, 1) not null,
    product_bk      varchar(255),
    start_date      datetime,
    end_date        datetime,
    category_id     int,
    category        varchar(255),
    subcategory_id  int,
    subcategory     varchar(255),
    product         varchar(255),
    description     varchar(1024)
    constraint [pk_dim_product_10K] primary key nonclustered (product_sk asc) not enforced
)
with (clustered columnstore index, distribution = replicate);

drop table dim_product_100K;
create table dim_product_100K (
    product_sk      int not null, -- identity (1, 1) not null,
    product_bk      varchar(255),
    start_date      datetime,
    end_date        datetime,
    category_id     int,
    category        varchar(255),
    subcategory_id  int,
    subcategory     varchar(255),
    product         varchar(255),
    description     varchar(1024)
    constraint [pk_dim_product_100K] primary key nonclustered (product_sk asc) not enforced
)
with (clustered columnstore index, distribution = replicate);


drop table dim_customer_1M;
create table dim_customer_1M (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_1M] primary key nonclustered (customer_sk asc) not enforced
)
with (clustered columnstore index, distribution = replicate);

drop table dim_customer_10M;
create table dim_customer_10M (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_10M] primary key nonclustered (customer_sk asc) not enforced
)
with (clustered columnstore index, distribution = replicate);


drop table dim_customer_10M_hash;
create table dim_customer_10M_hash (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_10M_hash] primary key nonclustered (customer_sk asc) not enforced
)
with (clustered columnstore index, distribution = hash(customer_sk));



drop table dim_customer_100M;
create table dim_customer_100M (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_100M] primary key nonclustered (customer_sk asc) not enforced
)
with (clustered columnstore index, distribution = replicate);


drop table dim_customer_100M_hash;
create table dim_customer_100M_hash (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_100M_hash] primary key nonclustered (customer_sk asc) not enforced
)
with (clustered columnstore index, distribution = hash(customer_sk));


drop table dim_customer_100M_hash_bk;
create table dim_customer_100M_hash_bk (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_100M_hash_bk] primary key nonclustered (customer_sk asc) not enforced
)
with (clustered columnstore index, distribution = hash(customer_bk));




drop table dim_customer_10M_ord;
create table dim_customer_10M_ord (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_10M_ord] 
      primary key nonclustered (customer_sk asc) not enforced
)
with (clustered columnstore index order(subcategory_id), distribution = replicate);




drop table dim_date;
create table dim_date (
    date_sk          int not null, -- identity (1, 1) not null,
    day              date,
    month_id         int,
    month            varchar(255),
    year             int,
    constraint [pk_dim_date] primary key nonclustered (date_sk asc) not enforced
)
with (clustered columnstore index, distribution = replicate);


drop table fact_order_line_10M;
create table fact_order_line_10M (
    order_id bigint,
    line_item_id int,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_10M] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = hash(order_id));


drop table fact_order_line_10M_rep;
create table fact_order_line_10M_rep (
    order_id bigint,
    line_item_id int,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_10M_rep] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = replicate);


drop table fact_order_line_10M_rr;
create table fact_order_line_10M_rr (
    order_id bigint,
    line_item_id int,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_10M_rr] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = round_robin);



drop table fact_order_line_10M_heap;
create table fact_order_line_10M_heap (
    order_id bigint,
    line_item_id int,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_10M_heap] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (heap);




drop table fact_order_line_100M_2;
create table fact_order_line_100M_2 (
    order_id bigint,
    line_item_id bigint,
    order_timestamp datetime,
    order_date_sk bigint,
    product_100K_1_sk bigint,
    product_100K_2_sk bigint,
    product_100K_3_sk bigint,
    customer_1M_1_sk bigint,
    customer_1M_2_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_100M_2] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = hash(order_id));

drop table fact_order_line_100M_3;
create table fact_order_line_100M_3 (
    order_id bigint,
    line_item_id bigint,
    order_timestamp datetime,
    order_date_sk bigint,
    product_100K_1_sk bigint,
    product_100K_2_sk bigint,
    product_100K_3_sk bigint,
    customer_1M_1_sk bigint,
    customer_1M_2_sk bigint,
    customer_1M_3_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_100M_3] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = hash(order_id));



drop table fact_order_line_100M;
create table fact_order_line_100M (
    order_id bigint,
    line_item_id bigint,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_100M] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = hash(order_id));



drop table fact_order_line_100M_cust_hash;
create table fact_order_line_100M_cust_hash (
    order_id bigint,
    line_item_id bigint,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_100M_cust_hash] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = hash(customer_10M_sk));







drop table fact_order_line_100M_rep;
create table fact_order_line_100M_rep (
    order_id bigint,
    line_item_id bigint,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_100M_rep] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = replicate);

drop table fact_order_line_100M_rr;
create table fact_order_line_100M_rr (
    order_id bigint,
    line_item_id bigint,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_100M_rr] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = round_robin);

drop table fact_order_line_100M_heap;
create table fact_order_line_100M_heap (
    order_id bigint,
    line_item_id bigint,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_100M_heap] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (heap);





drop table fact_order_line_1B;
create table fact_order_line_1B (
    order_id bigint,
    line_item_id int,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_1B] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = hash(order_id));




drop table fact_order_line_1B_cust_hash;
create table fact_order_line_1B_cust_hash (
    order_id bigint,
    line_item_id int,
    order_timestamp datetime,
    order_date_sk bigint,
    customer_100M_1_sk bigint,
    customer_100M_2_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_1B_cust_hash] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index, distribution = hash(customer_100M_1_sk));



drop table fact_order_line_1B_ord;
create table fact_order_line_1B_ord (
    order_id bigint,
    line_item_id int,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_1B_ord] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index order (order_timestamp), distribution = hash(order_id));



drop table fact_order_forecast_4M;
create table fact_order_forecast_4M (
    sk bigint not null,
    month_id int not null,
    customer_category_id int, 
    product_category_id int,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_forecast_4M] 
      primary key nonclustered (
        month_id, customer_category_id, product_category_id
      ) not enforced
)
with (clustered columnstore index, distribution = hash(sk));


drop table fact_order_forecast_40M;
create table fact_order_forecast_40M (
    sk bigint not null,
    order_date_sk bigint,
    customer_category_id int, 
    product_category_id int,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_forecast_40M] 
      primary key nonclustered (
        order_date_sk, customer_category_id, product_category_id
      ) not enforced
)
with (clustered columnstore index, distribution = hash(sk));



------------------------------------------------------------------------------------------------------------
-- Ordered
------------------------------------------------------------------------------------------------------------
drop table fact_order_line_100M_ord;
create table fact_order_line_100M_ord (
    order_id bigint,
    line_item_id bigint,
    order_timestamp datetime,
    order_date_sk bigint,
    product_10K_sk bigint,
    product_100K_sk bigint,
    customer_1M_sk bigint,
    customer_10M_sk bigint,
    shipping_amount  numeric (22, 4) null,
    tax_amount  numeric (22, 4) null,
    total_amount  numeric (22, 4) null,
    constraint [pk_fact_order_line_100M_ord] primary key nonclustered (order_id asc, line_item_id) not enforced
)
with (clustered columnstore index order ([order_timestamp]), distribution = hash ( [order_timestamp] ));

create table fact_order_line_100m_ord2 
with (distribution = hash(order_timestamp), 
    clustered columnstore index order(order_timestamp) 
)
as select * from fact_order_line_100m
option (maxdop 1);    


create table fact_order_line_1b_ord2 
with (distribution = hash(order_timestamp), 
    clustered columnstore index order(order_timestamp) 
)
as select * from fact_order_line_1b
option (maxdop 1); 



create table fact_order_line_1b_ord3
with (distribution = hash(order_id), 
    clustered columnstore index order(order_timestamp) 
)
as select * from fact_order_line_1b
option (maxdop 1); 





drop table dim_customer_10M_cl;
create table dim_customer_10M_cl (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_10M_cl] 
      primary key nonclustered (customer_sk asc) not enforced
)
with (clustered index(customer_sk), distribution = replicate);

CREATE NONCLUSTERED INDEX [idx_01_dim_customer_10M_cl] ON [dbo].[dim_customer_10M_cl]
(
    [category_id] ASC
)WITH (DROP_EXISTING = OFF)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [idx_dim_customer_10M_cl] ON [dbo].[dim_customer_10M_cl]
(
    [category_id] ASC,
    [subcategory] ASC
)WITH (DROP_EXISTING = OFF)
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [idx_dim_customer_10M_cl_bk] ON [dbo].[dim_customer_10M_cl]
(
    [customer_bk] ASC
)WITH (DROP_EXISTING = OFF)
GO
CREATE NONCLUSTERED INDEX [idx_dim_customer_10M_cl_subcat] ON [dbo].[dim_customer_10M_cl]
(
    [subcategory_id] ASC
)WITH (DROP_EXISTING = OFF)
GO



drop table dim_customer_1M_cl;
create table dim_customer_1M_cl (
    customer_sk      int not null, -- identity (1, 1) not null,
    customer_bk      varchar(255),
    category_id      int,
    category         varchar(255),
    subcategory_id   int,
    subcategory      varchar(255),
    full_name        varchar(255),
    description      varchar(1024)
    constraint [pk_dim_customer_1M_cl] 
      primary key nonclustered (customer_sk asc) not enforced
)
with (clustered index(customer_sk), distribution = replicate);

create nonclustered index idx_01_dim_customer_1m_cl on dim_customer_1M_cl(category_id);



drop table dim_product_100K_cl;
create table dim_product_100K_cl (
    product_sk      int not null, -- identity (1, 1) not null,
    product_bk      varchar(255),
    start_date      datetime,
    end_date        datetime,
    category_id     int,
    category        varchar(255),
    subcategory_id  int,
    subcategory     varchar(255),
    product         varchar(255),
    description     varchar(1024)
    constraint [pk_dim_product_100K_cl] primary key nonclustered (product_sk asc) not enforced
)
with (clustered index(product_sk), distribution = replicate);

create nonclustered index idx_01_dim_product_100K_cl on dim_product_100K_cl(category_id);

