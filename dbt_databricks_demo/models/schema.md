{% docs order_status %}
	
One of the following values: 

| status         | definition                                       |
|----------------|--------------------------------------------------|
| placed         | Order placed, not yet shipped                    |
| shipped        | Order has been shipped, not yet been delivered   |
| completed      | Order has been received by customers             |
| return pending | Customer indicated they want to return this item |
| returned       | Item has been returned                           |

{% enddocs %}

{% docs payment_method %}
	
One of the following values: 

| status         | definition     |
|----------------|----------------|
| gift_card      | Gift card      |
| coupon         | Coupon         |
| credit_card    | Credit Card    |
| bank_transfer  | Bank transfer  |

{% enddocs %}

{% docs payment_status %}
	
One of the following values: 

| status       | definition  |
|--------------|-------------|
| success      | Success     |
| fail         | Fail        |

{% enddocs %}
