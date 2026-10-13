use olist;

#1)What is the average delivery time?
select avg(concat( datediff(order_delivered_customer_date,order_purchase_timestamp),"days",
 mod(TIMESTAMPDIFF(hour, order_delivered_customer_date,order_purchase_timestamp),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_delivered_customer_date,order_purchase_timestamp),60),"minutes")) as delivery_time
 from olist_orders_dataset;
 
 # 2) What is the minimum delivery time?
 select min(concat( datediff(order_delivered_customer_date,order_purchase_timestamp),"days",
 mod(TIMESTAMPDIFF(hour, order_delivered_customer_date,order_purchase_timestamp),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_delivered_customer_date,order_purchase_timestamp),60),"minutes")) as delivery_time
 from olist_orders_dataset;
 
 # 3)What is the maximum delivery time?
 select max(concat( datediff(order_delivered_customer_date,order_purchase_timestamp),"days",
 mod(TIMESTAMPDIFF(hour, order_delivered_customer_date,order_purchase_timestamp),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_delivered_customer_date,order_purchase_timestamp),60),"minutes")) as delivery_time
 from olist_orders_dataset;
 
 # 4)Which states have the fastest delivery?
select customer_state,min(concat( datediff(order_delivered_customer_date,order_purchase_timestamp),"days",
 mod(TIMESTAMPDIFF(hour, order_delivered_customer_date,order_purchase_timestamp),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_delivered_customer_date,order_purchase_timestamp),60),"minutes"))as delivery_time
 from olist_orders_dataset as o
 left join olist_customers_dataset as c
 on o.customer_id=c.customer_id
 group by customer_state
 order by delivery_time 
 limit 1;
 
 # 5)Which states have the slowest delivery?
 select customer_state,max(concat( datediff(order_delivered_customer_date,order_purchase_timestamp),"days",
 mod(TIMESTAMPDIFF(hour, order_delivered_customer_date,order_purchase_timestamp),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_delivered_customer_date,order_purchase_timestamp),60),"minutes"))as delivery_time
 from olist_orders_dataset as o
 left join olist_customers_dataset as c
 on o.customer_id=c.customer_id
 group by customer_state
 order by delivery_time desc
 limit 3;
 #result =
#GO	     9days0hours0minutes
#MG	     9days0hours0minutes
#SP	     9days0hours0minutes
 
 # 6)Which cities experience the longest delivery times?
  select customer_city,max(concat( datediff(order_delivered_customer_date,order_purchase_timestamp),"days",
 mod(TIMESTAMPDIFF(hour, order_delivered_customer_date,order_purchase_timestamp),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_delivered_customer_date,order_purchase_timestamp),60),"minutes"))as delivery_time
 from olist_orders_dataset as o
 left join olist_customers_dataset as c
 on o.customer_id=c.customer_id
 group by customer_city
 order by delivery_time desc
 limit 3;
 #Result=
#paranaiguara	            9days0hours0minutes
#sao bernardo do campo  	9days0hours0minutes
#itaborai	                9days0hours0minutes

# 7)How many orders arrived before the estimated delivery date?
 select count(order_id) from olist_orders_dataset
 where (concat( datediff(order_estimated_delivery_date,order_delivered_customer_date),"days",
 mod(TIMESTAMPDIFF(hour, order_estimated_delivery_date,order_delivered_customer_date),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_estimated_delivery_date,order_delivered_customer_date),60),"minutes"))>0;
 #Result= 88649
 
 # 8)How many orders arrived after the estimated delivery date?
 select count(order_id) from olist_orders_dataset
 where (concat( datediff(order_estimated_delivery_date,order_delivered_customer_date),"days",
 mod(TIMESTAMPDIFF(hour, order_estimated_delivery_date,order_delivered_customer_date),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_estimated_delivery_date,order_delivered_customer_date),60),"minutes"))<0;
 #Result= 6535
 
 # 9)What percentage of orders were delivered late?
 select count(order_id),
 round(count(order_id)*100/(select count(order_id) from olist_orders_dataset),2) as percentage
 from olist_orders_dataset
 where (concat( datediff(order_estimated_delivery_date,order_delivered_customer_date),"days",
 mod(TIMESTAMPDIFF(hour, order_estimated_delivery_date,order_delivered_customer_date),24),"hours",
 mod(TIMESTAMPDIFF(minute, order_estimated_delivery_date,order_delivered_customer_date),60),"minutes"))<0;
 #Result= 6.57  
 
 #Calculate actual delivery time as Delivered Customer Date - Purchase Date.
#CASE
#WHEN order_delivered_customer_date >order_estimated_delivery_dateTHEN 'Late'ELSE 'On Time'END
