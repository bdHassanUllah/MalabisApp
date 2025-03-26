class GQLQuries {
  static const String queryQL = """query{
  listProductsFilter(limit:100){
    total_count
    products{
      id
      price
      image
      discount{
        price  
      }
      discount_price
      description{
        name
        description
      }
    }
  }
}
""";

  static const String homeORderWithoutID = """query{
  listProductsFilter(limit:100){
    total_count
    products{
      id
      price
      image
      discount{
        price  
      }
      discount_price
      description{
        name
        description
      }
    }
  }
}
""";

  static const String bannerQuery = """query{
  listPromotions{
    promotions{
      promotion_image
    }
  }
}""";
  static const String categoryList = """query{
 listCategoriesFilter{
  categorys{
    id
    image
    description{
      name
    }
  }
 }
}""";

  static const String findByCategory =
      """query listProductsFilter(\$category_id:Int,\$customer_id:Int){
  listProductsFilter(paramsFilter: { category_id: \$category_id,customer_id:\$customer_id }, limit: 100) {
   total_count
    products{
      is_exisit_favourite
      id
      model
      price
      image
      discount{
        price  
      }
      discount_price
      description{
        name
        description
      }
    }
  }
}""";

  static const String findWithoutID =
  """query listProductsFilter(\$category_id:Int){
  listProductsFilter(paramsFilter: { category_id: \$category_id }, limit: 100) {
   total_count
    products{
      is_exisit_favourite
      id
      model
      price
      image
      discount{
        price  
      }
      discount_price
      description{
        name
        description
      }
    }
  }
}""";

  static const String searchQuery =
      """query listProductsFilter(\$search:String){
  listProductsFilter(search: \$search, limit: 100) {
   total_count
    products{
      id
      price
      image
      discount{
        price  
      }
      discount_price
      description{
        name
        description
      }
    }
  }
}""";

  static const String pendingOrdersQuery =
      """query listOrdersFilters(\$customer_id:Int){
  listOrdersFilters(paramsFilter: { customer_id: \$customer_id, order_status_id: 1 }) {
    orders {
      id
      order_status_id
      shipping_address_1
      delivery_date
      total
      order_status {
        id
        name
      }
      order_products{
         name
        product_id
        order_id
        price
        total
      }
    }
  }
}""";

  static const String deliveredOrderQuery =
      """query listOrdersFilters(\$customer_id:Int){
  listOrdersFilters(paramsFilter: { customer_id: \$customer_id, order_status_id: 5 }) {
    orders {
      id
      order_status_id
      shipping_address_1
      delivery_date
      total
      order_status {
        id
        name
      }
      order_products{
         name
        product_id
        order_id
        price
        total
      }
    }
  }
}""";
  static const String canceledOrdersQuery =
      """query listOrdersFilters(\$customer_id:Int){
  listOrdersFilters(paramsFilter: { customer_id: \$customer_id, order_status_id: 7 }) {
    orders {
      id
      order_status_id
      shipping_address_1
      delivery_date
      total
      order_status {
        id
        name
      }
      order_products{
         name
        product_id
        order_id
        price
        total
      }
    }
  }
}""";

  static const String trackOrderQuery = """query getOrder(\$id:Int!){
  getOrder(id:\$id)
  {
    order_status_id
    date_added
    date_added_format
    order_totals{
      text
      value
    }
    order_status
    {
      id
      name
    }
    id
    order_products{
      id
      name
      order_id
      price
      product{
        image
      }
      
    }
  }
}""";
  static const String fetchFavQuery =
      """query getFavouriteProductsByCustomer(\$customer_id: Int!){
  getFavouriteProductsByCustomer(customer_id: \$customer_id) {
   total_count
    products{
      id
      price
      image
      discount{
        price  
      }
      discount_price
      description{
        name
        description
      }
    }
  }
}""";

  static const availableDilveryDatesQuery = """query getAvailableDiliveryDate(\$deliveryDate:String){
  listDeliveryAvailableSlots(delivery_date: \$deliveryDate) {
    delivery_slots {
      id
      time_slot
      status
    }
    total_count
  }
}""";

  static const getDeliveryFee = """query
{
getSetting(key:"delivery_charges_value")
{
id
key
value
}
}""";

  static const String getFaq = """query
{
  listFaqs{
    id
    title
    description

  }
}""";
}
