$( document ).ready(function(){

  let warehouses;
  let orders;
  let productOrders;
  let orderTotal;
  let soldProd;
  let grossSales;
  let avgProdPer;
  let avgOrderVal;

  const setResponseVars = (response) => {
    warehouses = response.warehouses;
    orders = response.orders;
    productOrders = response.product_orders;
    orderTotal = response.order_total;
    soldProd = response.ttl_sold_prod;
    grossSales = response.gross_sales;
    avgProdPer = response.avg_prod_per;
    avgOrderVal = response.avg_order_val;
  };

  const renderOrder = (response) => {
    const order = response.order
    const products = response.products

    const orderContent = `<p><b>Order #${order.id} | value: $${order.total_value} | status: ${printStatus(order)}</b></p>`;
    $(`#warehouse-${order.warehouse_id}`).append(orderContent)

    products.forEach(function(product) {
      $(`#warehouse-${order.warehouse_id} p:last-child`).after(`${product.name} ... `)
    });
  };

  let printStatus = (order) => order.status === 0 ? "unfulfilled" : "fulfilled"

  $.get("api/report_data", function(response) {
    setResponseVars(response)

    $('#total-orders').append(`<h3>${orderTotal}</h3>`);
    $('#total-sold').append(`<h3>${soldProd}</h3>`);
    $('#gross-sales').append(`<h3>$${grossSales}</h3>`);
    $('#product-count-average').append(`<h3>${avgProdPer}</h3>`);
    $('#average-order-value').append(`<h3>$${avgOrderVal}</h3>`);

    // display existing orders
    orders.forEach(function(response) {
      renderOrder(response)
    });
  });

  // create random products, set appropriate warehouse, and create order
  $('#generate_order').click(function() {
    $.post("order_generate", function(response) {
      renderOrder(response)
      updatePage()
    });
  });

  const updatePage = function() {
    $.get("api/report_data", function(response) {
      setResponseVars(response)

      $('#total-orders h3')[0].innerText = orderTotal;
      $('#total-sold h3')[0].innerText = soldProd;
      $('#gross-sales h3')[0].innerText = `$${grossSales}`;
      $('#product-count-average h3')[0].innerText = avgProdPer;
      $('#average-order-value h3')[0].innerText = `$${avgOrderVal}`;
    });
  };

  $('#clear_all').click(function() {
    $.post("delete_all", function() {
      location.reload();
    });
  });
});
