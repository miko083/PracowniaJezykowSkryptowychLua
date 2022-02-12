import Model from require "lapis.db.model"
import respond_to from require "lapis.application"
import json_params from require "lapis.application"

lapis = require "lapis"
class Products extends Model

class extends lapis.Application
  [index: "/products"]: respond_to {

    GET: =>
      result = Products\select ""
      {
        json: {
          result
        }
      }

    POST: json_params =>
      product = Products\create {
        name: @params.name
        price: @params.price
      }
      {
        json: {
          success: true
        }
      }

  }

  [product: "/products/:id"]: respond_to {    

    GET: =>
      result = Products\select "where id = ?",@params.id
      {
          json: {
            result
          }
      }

    PUT: json_params =>
      product = Products\find @params.id
      product\update {
        name: @params.name
        price: @params.price
      }
      {
        json: {
          success: true
        }
      }

    DELETE: =>
      product = Products\find @params.id
      product\delete!
      {
        json: {
          success: true
        }
      }

  }