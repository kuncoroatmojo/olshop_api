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
Return available users
* **URL**

`GET` , `POST` ```/users```

`GET` ```/users/:id```
* **Success Response**

  Code: 200 <br/>
```
{
        "id": 74,
        "email": "alicia@hyatt.com",
        "name": "Toy Lueilwitz",
        "phone": null,
        "address": null,
        "created_at": "2018-01-07T13:46:16.506Z",
        "updated_at": "2018-01-07T13:46:16.506Z",
        "token": "i7ENgH2L95b24pkxARhUhvTD"
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
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**

**Customer Appling a Coupon**
----
* **URL**
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**

**Customer Submit Order**
----
* **URL**
* **URL Params**
  **Required**
* **Success Response**
* **Error Response**
* **Sample Call**

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
