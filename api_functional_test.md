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
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**

**Admin View Detail of an Order**
----
* **URL**
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**

**Admin Update Order Status**
----
* **URL**
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**

**Admin Add Shipping ID**
----
* **URL**
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**

**Customer Check Order**
----
* **URL**
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**

**Customer Check Shipment Status**
----
* **URL**
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**
