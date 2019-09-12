fetch("products.json")
.then(function(response){
    return response.json();
})
.then(receiveProducts)

function receiveProducts(products) {
    var productsContainer = document.getElementById("products");
    products.forEach(function(product){
        productsContainer.append(getProductHtml(product));
        plotChart(product);
    })
}

function getProductHtml(product) {
    var productDiv = document.createElement("div");
    var price = document.createElement("h1");
    var chart = document.createElement("div");
    chart.id = product.name;

    price.innerText = "Price of " + product.name + " is about $"+ product.price;

    productDiv.append(price);
    productDiv.append(chart);

    return productDiv;
}

function plotChart(product) {
    Highcharts.chart(product.name, {
        title: {
            text: 'Price of '+ product.name
        },

        tooltip: {
            valueDecimals: 2
        },
        series: [{
            data: product.chart,
            lineWidth: 0.5,
            name: 'Price'
        }]
    });
}
