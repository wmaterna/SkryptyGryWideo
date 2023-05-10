import React, { useEffect } from 'react';
import { getCategories } from './data-access/getCategories';
import { getProducts } from './data-access/getProducts';

function App() {
  useEffect(() => {
    getCategories().then((res) => {
      console.log(res)
    })
    getProducts().then((res) => {
      console.log(res)
    })
  }, [])

  return (
    <div>
      Hello
    </div>
  );
}

export default App;
