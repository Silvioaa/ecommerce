import './App.css';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Search from './pages/search';
import Product from './pages/product';
import Cart from './pages/cart';

function App(){
  return (
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Search/>}/>
          <Route path="/product/:id" element={<Product/>}/>
          <Route path="/cart" element={<Cart/>}/>
          <Route path="*" element={<Search/>}/>
        </Routes>
      </BrowserRouter>
  );
}

export default App;
