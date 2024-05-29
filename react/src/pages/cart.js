import { useDispatch, useSelector } from "react-redux";
import { useState, useEffect } from "react";
import { useNavigate } from "react-router";
import { addItemCart, modifyItemCart, removeItemCart, pay } from "../redux/actions";
import Navbar from "../components/Navbar";
import Container from "../components/Container";


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
        alert("The payment was made successfully. Thank you very much for your purchase.")
        navigate("/search");
    }

    useEffect(()=>{
        totalValue = 0;
        if(cart.length!==0){
            cart.forEach(product => totalValue = totalValue + product.productPrice*product.quantity);
        }
        setTotal(totalValue)
    })

    return(
        <>
            <Navbar/>
            <Container>
                <div className="cart-container">
                {
                    cart.length!==0 &&
                    cart.map(product =>{
                        return( 
                            <div className="cart-product" id={product.id} key={product.id}>
                                <h3>{product.productName}</h3>
                                <div className="cart-product-values">
                                    <div className="column1">
                                        <div>$ {product.productPrice} x unit</div>
                                        <div>x {product.quantity}</div>
                                    </div>
                                    <div className="column2">
                                        <div>$ {product.productPrice * product.quantity}</div>
                                    </div>
                                </div>
                                <button className="+" onClick={handleClick}>+</button>
                                <button className="-" onClick={handleClick}>-</button>
                                <button onClick={handleRemoveClick}>Remove Product</button>
                            </div>
                        )
                    })
                }
                {
                    cart.length!==0 &&
                    <div className="cart-total">
                        <div className="cart-total-sum">Total: ${total}</div>
                        <button onClick={handlePayClick}>Pay</button>
                    </div>
                }
                {
                    cart.length===0 &&
                    <div className="cart-noproducts">No product was selected.</div>
                }
                </div>
            </Container>
        </>
    );
}

export default Cart;