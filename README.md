## Goals achieved

* 3.0: endpoints for categories and products
* 3.5: models created with `lapis.db.model`
* 4.0: all done using MoonScript

## Docker

### Docker image
Based on [openresty/openresty](https://hub.docker.com/r/openresty/openresty).
My image has:
* Lua 5.4 with Lapis and Moonscript
* PostgreSQL

Please build with following command:
`docker build -t my-lua .`

### Start docker container

Please run following command:
`docker run -dti -v "$(pwd)/source-code:/var/source-code" -p 8080:8080 my-lua`

The app will be avaiable on the 8080 port.

## Functionality

### Get all products

`curl -s -X GET -H "Content-Type: application/json" http://localhost:8080/products | jq`

```
[
  [
    {
      "id": 1,
      "price": 55,
      "name": "ksiazka historyczna",
      "categoryname": "ksiazki"
    },
    {
      "id": 2,
      "price": 2137,
      "name": "playstation 4",
      "categoryname": "elektronika"
    },
    {
      "id": 3,
      "price": 5555,
      "name": "karta graficzna",
      "categoryname": "elektronika"
    },
    {
      "id": 4,
      "price": 25,
      "name": "kubek",
      "categoryname": "kuchnia"
    }
  ]
]
```

### Get specific product

`curl -s -X GET -H "Content-Type: application/json" http://localhost:8080/products/3 | jq`

```
[
  {
    "price": 5555,
    "categoryname": "elektronika",
    "id": 3,
    "name": "karta graficzna"
  }
]
```

### Add new product

`curl -s -X POST -H "Content-Type: application/json" -d '{"name":"Telewizor","price":4500, "categoryname": "elektronika"}' http://localhost:8080/products | jq`

```
{
  "success": true
}
```

### Update a product

`curl -s -X PUT -H "Content-Type: application/json" -d '{"price":2500}' http://localhost:8080/products/2 | jq`

```
{
  "success": true
}
```

### Delete a product

`curl -s -X DELETE -H "Content-Type: application/json" http://localhost:8080/products/2 | jq`

```
{
  "success": true
}
```

### Get all products from specific category

`curl -s -X GET -H "Content-Type: application/json" http://localhost:8080/categories/elektronika | jq`
```
[
  [
    {
      "price": 5555,
      "name": "karta graficzna",
      "categoryname": "elektronika",
      "id": 3
    },
    {
      "price": 4500,
      "name": "Telewizor",
      "categoryname": "elektronika",
      "id": 34
    },
    {
      "price": 2500,
      "name": "playstation 4",
      "categoryname": "elektronika",
      "id": 2
    }
  ]
]
```

### Other commands that can be used for categories managment
```
curl -X DELETE -H "Content-Type: application/json" http://localhost:8080/categories/mebele
curl -X POST -H "Content-Type: application/json" -d '{"name":"meble"}' http://localhost:8080/categories
curl -X PUT -H "Content-Type: application/json" -d '{"name":"mebelki"}' http://localhost:8080/categories/meble
```
