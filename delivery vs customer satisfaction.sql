use olist;
#Investigate whether late deliveries result in lower customer ratings. Compare order counts and average review score
#for On Time and Late deliveries. Also investigate early deliveries if useful.

select case
when o.order_delivered_customer_date > o.order_estimated_delivery_date then "Late" 
else "On Time"
end as delivery_status,
count(*),
round(avg(review_score),2) as Average_Review_score
 from olist_order_reviews_dataset as r
 left join olist_orders_dataset o
on o.order_id = r.order_id
where o.order_delivered_customer_date is not null
and o.order_estimated_delivery_date is not null
group by delivery_status; 
#Result =
# On Time	   255	 4.16
# Late	       24	 2.50

