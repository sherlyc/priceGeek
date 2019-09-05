fetch("products.json")
.then(function(response){
    return response.json();
})
.then(receiveProducts)

function receiveProducts(products) {
    console.log(products)
}