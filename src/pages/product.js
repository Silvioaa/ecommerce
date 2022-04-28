import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router';
import { loadProduct, addItemCart, setIsProductInCart } from '../redux/actions';
import { useDispatch, useSelector } from 'react-redux';
import Navbar from '../components/Navbar';
import Container from '../components/Container';
import { TailSpin } from  'react-loader-spinner'

const Product = () => {
    const params = useParams();
    const navigate = useNavigate();
    const id = parseInt(params.id);
    const currentProduct = useSelector(state => state.currentProduct);
    const cart = useSelector(state => state.cart);
    const isProductInCart = useSelector(state => state.isProductInCart);
    const dispatch = useDispatch();
    if(currentProduct.length===0||currentProduct[0].id!==id) dispatch(loadProduct(id));

    async function handleClick(e){
        e.preventDefault();
        const addOrRemove = e.target.id
        if(addOrRemove==="add"){
            await dispatch(addItemCart(currentProduct[0]))
        }else{
            navigate("/cart");
        }
    }

useEffect(()=>{
    const productInCartCheck = cart.filter(product => product.id === id).length!==0;
    if(productInCartCheck && isProductInCart===false){
        dispatch(setIsProductInCart(true));
    }else if(!productInCartCheck && isProductInCart===true){
        dispatch(setIsProductInCart(false));
    }
},[cart])
    
    return(
        <>
            <Navbar/>
            <Container>
            {
                (currentProduct.length!==0 && currentProduct[0].id===id) ?
                currentProduct.map((product) => 
                    <div className='product-card' key={product.id}>
                        <h1>{product.name}</h1>
                        <img src={product.image}/>
                        <div className='product-card-description'>{product.description}</div>
                        { isProductInCart ?
                            <button id="goToCart" onClick={handleClick}>Ir al Carrito</button>
                            :
                            <button id="add" onClick={handleClick}>Agregar al Carrito</button>
                        }
                    </div>
                )
                :
                <div className='spinner'>
                        <TailSpin color="#da6a01" height="200" width="200"/>
                </div>
            }
            </Container>
        </>
    )
}

export default Product;