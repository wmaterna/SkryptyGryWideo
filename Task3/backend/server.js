import express from 'express';
var app = express();
import {
    Categories, Products
} from './data.js';



app.get('/categories', function (req, res) {
    res.send(Categories);
})

app.get('/products', function (req, res) {
    res.send(Products);
})

app.post('/categories', function (req, res) {
    var category = req.body.category;
    Categories.push({
        category: category,
    })
})

app.post('/products', function (req, res) {
    var productName = req.body.name;
    var productPrice = req.body.price;
    var productCategorie = Categories[req.body.category];
    var productImage = req.body.image;
    if (req.body.category in Categories) {
        const newProduct = {
            name: productName,
            price: productPrice,
            categorie: productCategorie,
            image: productImage
        }
        Products.push(newProduct)
        res.send(Products);
    } else {
        throw new Error('Provided product category does not exists')
    }

})


app.delete('/products', function (req, res) {
    var nameToDelete = req.body.name;
    const indexToDelete = undefined;
    Products.forEach((prod, index) => {
        if (prod.name === nameToDelete) {
            indexToDelete = index;
        }
    })
    if (indexToDelete) {
        Products.splice(indexToDelete, 1);
        res.send(Products);
    } else {
        throw new Error('There is no product with provided name')
    }
})



var server = app.listen(3001, function () {
    var host = server.address().address
    console.log("Listening on http://localhost:3001")
})