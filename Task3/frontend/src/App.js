import React, { useEffect, useState } from 'react';
import { getCategories } from './data-access/getCategories';
import { getProducts } from './data-access/getProducts';
import Card from '@mui/material/Card';
import CardMedia from '@mui/material/CardMedia';
import Typography from '@mui/material/Typography';
import CardContent from '@mui/material/CardContent';
import { AppBar, Grid, Toolbar } from '@mui/material';
import { Box } from '@mui/system';

function App() {

  const [products, setProducts] = useState();
  const [categories, setCategories] = useState();

  useEffect(() => {
    getCategories().then((res) => {
      setCategories(res)
    })
    getProducts().then((res) => {
      setProducts(res)
    })
  }, [])

  return (
    <>
      <Box sx={{ flexGrow: 1 }}>
        <AppBar position="static">
          <Toolbar>
            <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
              Your Shop
            </Typography>
          </Toolbar>
        </AppBar>
      </Box>
      <Grid container spacing={8} style={{ margin: '50px' }}>
        {(products && categories)
          &&
          products[0].map((prod) => {
            return (
              <Card item xs={{ maxWidth: 350 }}>
                <CardMedia
                  component="img"
                  height="194"
                  image={prod.image}
                />
                <CardContent>
                  <Typography paragraph><b>Product name: </b>{prod.name}</Typography>
                  <Typography paragraph><b>Price: </b>{prod.price} $</Typography>
                  <Typography paragraph><b>Category: </b>{prod.categorie}</Typography>
                </CardContent>
              </Card>)
          })

        }
      </Grid>
    </>
  );
}

export default App;
