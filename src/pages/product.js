import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router';
import { loadProduct, addItemCart, removeItemCart } from '../redux/actions';
import { useDispatch, useSelector } from 'react-redux';
import Navbar from '../components/Navbar';



const Product = () => {
    const params = useParams();
    const navigate = useNavigate();
    const id = parseInt(params.id);
    const [___, setStateToForceReRender ] = useState(false);
    const currentProduct = useSelector(state => state.currentProduct);
    const cart = useSelector(state => state.cart);
    const dispatch = useDispatch();
    if(currentProduct.length===0||currentProduct[0].id!==id) dispatch(loadProduct(id));
    const isProductInCart = cart.filter(product => product.id === id).length===0;

    async function handleClick(e){
        e.preventDefault();
        const addOrRemove = e.target.id
        if(addOrRemove==="add"){
            await dispatch(addItemCart(currentProduct[0]))
            setStateToForceReRender(prevState => !prevState)
        }else{
            navigate("/cart");
        }
    }

useEffect(()=>{
    return () => {
        dispatch(loadProduct());
    }
})
    
    return(
        <>
            <Navbar/>
            {
                (currentProduct.length!==0 && currentProduct[0].id===id) &&
                currentProduct.map((product) => 
                    <div key={product.id}>
                        <h1>{product.name}</h1>
                        <img style={{width:"40em"}} src={product.image}/>
                        <div>{product.description}</div>
                        { isProductInCart ?
                            <button id="add" onClick={handleClick}>Agregar al Carrito</button>
                            :
                            <button id="goToCart" onClick={handleClick}>Ir al Carrito</button>
                        }
                    </div>
                )
            }
        </>
    )
}

export default Product;