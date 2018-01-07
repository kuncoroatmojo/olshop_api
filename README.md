# API Function Documentation

**Product**
----
Returns available products
* **URL**

`GET` , `POST` ```/products```

`GET` ```/products/:id```

* **Success Response**

  Code: 200 <br/>
```
{
        "id": 47,
        "name": "Aerodynamic Plastic Computer",
        "price": "3.19",
        "quantity": 68
    }
```
* **Error Response**
```
"status": 404,
    "error": "Not Found",
```

**Coupon**
----
Returns available coupons
* **URL**

`GET` , `POST` ```/coupons```

`GET` ```/coupons/:id```

* **Success Response**

  Code: 200 <br/>
```
{
        "id": 18,
        "code": "StellarSale385388",
        "quantity": 90,
        "amount": "9.0",
        "amount_type": "percentage",
        "valid_start": "2017-12-06",
        "valid_end": "2018-02-19"
    }
```
* **Error Response**
```
"status": 404,
    "error": "Not Found",
```

**User**
----
Return available users. There are two types of users, customer and admin.
* **URL**

`GET` , `POST` ```/users```

`GET` ```/users/:id```
* **Success Response**

  Code: 200 <br/>
```
{
        "id": 78,
        "email": "rolando@towne.net",
        "name": "Mrs. Noemie Kunze",
        "user_type": "customer",
        "phone": "182.945.0893",
        "address": "243 Heller Tunnel, North Derrick",
        "created_at": "2018-01-07T13:46:16.525Z",
        "updated_at": "2018-01-07T13:46:16.525Z",
        "token": "B5S7X2ne18t3vN8AK3queh9H"
    }
```
* **Error Response**
```
"status": 404,
    "error": "Not Found",
```

**Customer Placing Product to be Ordered**
----

* **URL**

``POST`` ``/placements``
* **URL Params**
  **Required**

  ```quantity``` number of products to buy, ```product_id``` id of the product
* **HEADER**

```Authorization``` token of the user, to authenticate & authorize a customer account
* **Success Response**

  Code: 201 <br/>
```
{
    "id": 1,
    "product": {
        "id": 3,
        "name": "Intelligent Plastic Knife",
        "price": "89.65",
        "quantity": 70,
        "created_at": "2018-01-07T14:38:11.925Z",
        "updated_at": "2018-01-07T14:38:11.925Z"
    },
    "quantity": 2
}
```
* **Error Response**

  Code: 401 <br/>
```
{
    "errors": "Not authenticated"
}
```
* **Sample Call**

```
curl --request POST \
  --url https://murmuring-falls-22747.herokuapp.com/placements \
  --header 'Authorization: 7x3VoY53ubUX4zrwVZcE8QM1' \
  --form product_id=1 \
  --form quantity=2
```

**Customer Appling a Coupon**
----
* **URL**

``POST`` ``/placement_coupons``
* **URL Params**
  **Required**

  ```coupon_id``` id of the coupon
* **HEADER**

```Authorization``` token of the user, to authenticate & authorize a customer account
* **Success Response**

  Code: 201 <br/>
```
{
    "id": 1,
    "coupon": {
        "id": 6,
        "code": "StellarDeal230266",
        "valid_start": "2018-01-03",
        "valid_end": "2018-01-09",
        "quantity": 90,
        "amount": "15.0",
        "amount_type": "nominal",
        "created_at": "2018-01-07T14:38:12.410Z",
        "updated_at": "2018-01-07T14:38:12.410Z"
    }
}
```
* **Error Response**

  Code: 401 <br/>
```
{
    "errors": "Not authenticated"
}
```
* **Sample Call**

```
curl --request POST \
  --url https://murmuring-falls-22747.herokuapp.com/placements \
  --header 'Authorization: 7x3VoY53ubUX4zrwVZcE8QM1' \
  --form coupon_id=6 \
```

**Customer Submit Order**
----
Submitting an order means the order also being validated (product availability, coupon validity, etc.)
* **URL**

``POST`` ``/orders``
* **URL Params**
  **Required**

  ```address``` customer address, ```phone``` customer phone number

  Every user must have email address and name, so those field taken from the user profile.
* **HEADER**

```Authorization``` token of the user, to authenticate & authorize a customer account
* **Success Response**

  Code: 201 <br/>
```
{
    "id": 1,
    "total": "164.3",
    "status": "finalized",
    "placements": [
        {
            "id": 1,
            "product": {
                "id": 3,
                "name": "Intelligent Plastic Knife",
                "price": "89.65",
                "quantity": 68,
                "created_at": "2018-01-07T14:38:11.925Z",
                "updated_at": "2018-01-07T14:38:11.925Z"
            },
            "quantity": 2
        }
    ],
    "placement_coupon": {
        "id": 1,
        "coupon": {
            "id": 6,
            "code": "StellarDeal230266",
            "valid_start": "2018-01-03",
            "valid_end": "2018-01-09",
            "quantity": 89,
            "amount": "15.0",
            "amount_type": "nominal",
            "created_at": "2018-01-07T14:38:12.410Z",
            "updated_at": "2018-01-07T14:38:12.410Z"
        }
    }
}
```
* **Error Response**

  Code: 401 <br/>
```
{
    "errors": "Not authenticated"
}
```
```
{
    "errors": "Product Name, there is no sufficient amount of product, only 3 left"
}
```
* **Sample Call**

```
curl --request POST \
  --url 'https://murmuring-falls-22747.herokuapp.com/orders?address=%226602%20Jerel%20Fall,%20Morarport%22&phone=%22262.514.6961%22' \
  --header 'Authorization: 7x3VoY53ubUX4zrwVZcE8QM1' \
  --header 'Cache-Control: no-cache' \
```

**Customer Submit Payment Proof**
----
* **URL**

``POST`` ``/payments``
* **URL Params**
  **Required**

  ```order_id``` id of the order, ``proof`` the link to the payment proof
* **HEADER**

```Authorization``` token of the user, to authenticate & authorize a customer account
* **Success Response**

  Code: 201 <br/>
```
{
    "id": 1,
    "payment_method": "bank transfer",
    "proof": "\"https://cdn/18na82jao221fc53b4bc84d0swq98f73.jpg\"",
    "order_id": 1,
    "created_at": "2018-01-07T15:54:40.236Z",
    "updated_at": "2018-01-07T15:54:40.236Z"
}
```
* **Error Response**

  Code: 401 <br/>
```
{
    "errors": "Not authenticated"
}
```
* **Sample Call**

```
curl --request POST \
  --url https://murmuring-falls-22747.herokuapp.com/payments \
  --header 'Authorization: 7x3VoY53ubUX4zrwVZcE8QM1' \
  --header 'Cache-Control: no-cache' \
  --header 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  --form 'proof="https://cdn/18na82jao221fc53b4bc84d0swq98f73.jpg"' \
  --form order_id=1
```

**Admin View Detail of an Order**
----
* **URL**

``GET`` ``/orders``
* **URL Params**
  **Required**

  ```user_id``` id of the customer that the admin wants to check
* **HEADER**

```Authorization``` token of the user, to authenticate & authorize an Admin account
* **Success Response**

  Code: 200 <br/>
```
{
    "id": 1,
    "total": "164.3",
    "status": "finalized",
    "placements": [
        {
            "id": 1,
            "product": {
                "id": 3,
                "name": "Intelligent Plastic Knife",
                "price": "89.65",
                "quantity": 66,
                "created_at": "2018-01-07T14:38:11.925Z",
                "updated_at": "2018-01-07T14:38:11.925Z"
            },
            "quantity": 2
        }
    ],
    "placement_coupon": {
        "id": 1,
        "coupon": {
            "id": 6,
            "code": "StellarDeal230266",
            "valid_start": "2018-01-03",
            "valid_end": "2018-01-09",
            "quantity": 88,
            "amount": "15.0",
            "amount_type": "nominal",
            "created_at": "2018-01-07T14:38:12.410Z",
            "updated_at": "2018-01-07T14:38:12.410Z"
        }
    }
}
```
* **Error Response**

  Code: 404 <br/>

* **Sample Call**

```
curl --request GET \
  --url 'https://murmuring-falls-22747.herokuapp.com/orders?user_id=5' \
  --header 'Authorization: ZnwNnhTRTBfajY5oZBbsZD7B' \
  --header 'Cache-Control: no-cache'
```



**Admin Update Order Status**
----
After admin view order detail, admin can verify the validity of order data: customer name, phone, email, address, payment proof.
If it is valid, status set to "approved", if not "canceled".<br/>
After packaging, and the order is ready for shipment, the status can be updated to "readyforshipment". The order being shipped, status set as "shipped".

* **URL**

``GET`` ``/orders/:id``
* **URL Params**
  **Required**

  ```status``` the new order status
  the order id become part of the url, not params
* **HEADER**

```Authorization``` token of the user, to authenticate & authorize an Admin account
* **Success Response**

  Code: 200 <br/>
```
{
    "id": 1,
    "total": "164.3",
    "status": "approved",
    "placements": [
        {
            "id": 1,
            "product": {
                "id": 3,
                "name": "Intelligent Plastic Knife",
                "price": "89.65",
                "quantity": 66,
                "created_at": "2018-01-07T14:38:11.925Z",
                "updated_at": "2018-01-07T14:38:11.925Z"
            },
            "quantity": 2
        }
    ],
    "placement_coupon": {
        "id": 1,
        "coupon": {
            "id": 6,
            "code": "StellarDeal230266",
            "valid_start": "2018-01-03",
            "valid_end": "2018-01-09",
            "quantity": 88,
            "amount": "15.0",
            "amount_type": "nominal",
            "created_at": "2018-01-07T14:38:12.410Z",
            "updated_at": "2018-01-07T14:38:12.410Z"
        }
    }
}
```
* **Error Response**

  Code: 422 <br/>

* **Sample Call**

```
curl --request PUT \
  --url 'https://murmuring-falls-22747.herokuapp.com/orders/1?status=approved' \
  --header 'Authorization: ZnwNnhTRTBfajY5oZBbsZD7B'  
```


**Admin Add Shipping ID**
----

Admin add shipping ID to order by creating a shipment object
* **URL**

``POST`` ``/shipments``
* **URL Params**
  **Required**

  ```order_id``` id of the order
  ``status`` set status to "delivering" or "delivered"
* **HEADER**

```Authorization``` token of the user, to authenticate & authorize an Admin account
* **Success Response**

  Code: 201 <br/>
```
{
    "id": 1,
    "status": "delivering",
    "created_at": "2018-01-07T16:47:41.017Z",
    "updated_at": "2018-01-07T16:47:41.017Z",
    "order_id": 1
}
```
* **Error Response**

  Code: 422 <br/>

* **Sample Call**

```
curl --request POST \
  --url 'https://murmuring-falls-22747.herokuapp.com/shipments?order_id=1&status=delivering' \
  --header 'Authorization: ZnwNnhTRTBfajY5oZBbsZD7B'
```

**Customer Check Order**
----
Customer can check order by using GET orders that's been mentioned above

**Customer Check Shipment Status**
----
Customer can check whether the order has been delivered
* **URL**

``GET`` ``/shipments/:id``
* **URL Params**
  **Required**


* **HEADER**

```Authorization``` token of the user, to authenticate & authorize an Customer account
* **Success Response**

  Code: 200 <br/>
```
{
    "id": 1,
    "status": "delivering",
    "created_at": "2018-01-07T16:47:41.017Z",
    "updated_at": "2018-01-07T16:47:41.017Z",
    "order_id": 1
}
```
* **Error Response**

  Code: 404 <br/>

* **Sample Call**

```
curl --request GET \
  --url https://murmuring-falls-22747.herokuapp.com/shipments/1 \
  --header 'Authorization: 7x3VoY53ubUX4zrwVZcE8QM1'
```
