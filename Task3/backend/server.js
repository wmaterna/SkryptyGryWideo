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

var server = app.listen(3001, function () {
    var host = server.address().address
    console.log("Listening on http://localhost:3001")
})