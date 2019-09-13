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
    chart.id = product.id;

    price.innerText = "Price of " + product.name + " is about $"+ product.price;

    productDiv.append(price);
    productDiv.append(chart);

    return productDiv;
}

function plotChart(product) {
    Highcharts.chart(product.id, {
        chart: {
            type: 'spline',
            backgroundColor: '#000',
            color: '#fff'
        },
        title: {
            text: product.name,
            style: {
                color: "#fff"
            }
        },
        legend: {
            enabled: false
        },
        yAxis: {
            title: {
                text: "Volume"
            },
            allowDecimals: false
        },
        tooltip: {
            formatter: function () {
                return '$'+ this.x + ': ' + this.y + ' items';
            }
        },
        series: [{
            data: product.chart,
            lineWidth: 0.5,
            name: 'Price',
            color: '#FF0000',
            lineWidth: 1
        }]
    });
}

