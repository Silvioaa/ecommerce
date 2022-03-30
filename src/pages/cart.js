import { useDispatch, useSelector } from "react-redux";
import { useState, useEffect } from "react";
import { useNavigate } from "react-router";
import { addItemCart, modifyItemCart, removeItemCart, pay } from "../redux/actions";
import Navbar from "../components/Navbar";


const Cart = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();
    const cart = useSelector(state => state.cart);
    const search = useSelector(state => state.search);
    let totalValue = 0;
    const [total, setTotal] = useState(0);
    const [__, setStateToForceReRender] = useState(false);

    function handleClick(e){
        const add = e.target.className;
        const productId = parseInt(e.target.parentElement.id)
        let productInCart = cart.filter(item => item.id===productId)
        if(productInCart.length!==0){
           productInCart = productInCart[0];
           if(add==="+") dispatch(modifyItemCart(productId,true));
           else dispatch(modifyItemCart(productId,false))
        }else{
            let productInSearch = search.filter(item => item.id===productId);
            productInSearch = productInSearch[0];
            dispatch(addItemCart(productInSearch))
        }
        setStateToForceReRender(prevState => !prevState)
    }
    
    function handleRemoveClick(e){
        e.preventDefault();
        dispatch(removeItemCart(parseInt(e.target.parentElement.id)));
        setStateToForceReRender(prevState => !prevState);
    }
    function handlePayClick(e){
        e.preventDefault();
        dispatch(pay());
        alert("El pago ha sido efectuado, muchas gracias por su compra.")
        navigate("/search");
    }

    useEffect(()=>{
        totalValue = 0;
        if(cart.length!==0){
            cart.forEach(product => totalValue = totalValue + product.price*product.quantity);
        }
        setTotal(totalValue)
    })

    return(
        <>
            <Navbar/>
            <h1>Carrito</h1>
            {
                cart.length!==0 &&
                cart.map(product =>{
                    return( 
                        <div id={product.id} key={product.id}>
                            <h2>{product.name}</h2>
                            <h3>$ {product.price} por unidad.</h3>
                            <h3>{product.quantity} {product.quantity===1?"unidad":"unidades"}</h3>
                            <h3>$ {product.price * product.quantity}</h3>
                            <button className="+" onClick={handleClick}>+</button>
                            <button className="-" onClick={handleClick}>-</button>
                            <button onClick={handleRemoveClick}>Quitar Producto</button>
                        </div>
                    )
                })
            }
            {
                cart.length!==0 &&
                <>
                    <div>Total: ${total}</div>
                    <button onClick={handlePayClick}>Pagar</button>
                </>
            }
            {
                cart.length===0 &&
                <div>No hay productos seleccionados para comprar.</div>
            }
        </>
    );
}

export default Cart;