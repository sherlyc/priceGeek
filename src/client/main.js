fetch("products.json")
.then(function(response){
    return response.json();
})
.then(receiveProducts)

function receiveProducts(products) {
    var productsContainer = document.getElementById("products");
    products.forEach(function(product){
        productsContainer.append(getProductHtml(product));
    })
}

function getProductHtml(product) {
    var productDiv = document.createElement("div");
    var price = document.createElement("h1");
    var imageWrapper = document.createElement("div");
    var image = document.createElement("img");

    image.src = product.image;
    price.innerText = "Price of " + product.name + " is about $"+ product.price;

    imageWrapper.append(image);
    productDiv.append(price);
    productDiv.append(imageWrapper);

    return productDiv;
}