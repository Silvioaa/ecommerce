import React, { useEffect, useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { makeSearch, addItemCart, modifyItemCart } from '../redux/actions';

const Search = () => {
    const search = useSelector( state => state.search);
    const isLoading = useSelector( state => state.isLoading)
    const loadingError = useSelector( state => state.loadingError)
    const cart = useSelector( state => state.cart);
    const dispatch = useDispatch();
    const [searchTriggered, setSearchTriggered] = useState(false)
    const [___, setStateToForceReRender] = useState(false);

    function handleSubmit(e){
        e.preventDefault();
        searchTriggered === false && setSearchTriggered(true);
        if(e.target.id!=="all") dispatch(makeSearch(e.target[0].value))
        else dispatch(makeSearch(null))
    }

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

    return(
        <>
            <div>Buscar Producto</div>
            <form onSubmit={handleSubmit}>
                <input type="text"/>
                <input type="submit" value="Buscar"/>
                <button id="all" onClick={handleSubmit}>Ver todos</button>
            </form>
            {
                (searchTriggered===true && isLoading===false) &&
                <div>
                    {
                        search.length!==0 &&
                        search.map((product)=>{
                            let units;
                            cart.forEach((item) =>{ 
                                if(item.id===product.id){
                                    units = item.quantity
                                }
                            });
                            units = units===undefined?0:units;
                            return(
                                <div id={product.id} key={product.name}>
                                    <h1>{product.name}</h1>
                                    <p>$ {product.price}</p>
                                    <img style={{width: "30em"}} src={product.image}/>
                                    <button className='+' onClick={handleClick}>+</button>
                                    <button className='-' onClick={handleClick}>-</button>
                                    <div >{units} unidades en el carrito.</div>
                                </div>
                            )
                        })
                    }
                    {
                        (search.length===0 && loadingError===true) &&
                        <div>No se ha podido realizar la búsqueda. Ha habido un error.</div>
                    }
                    {    
                        (search.length===0 && loadingError===false) &&
                        <div>No se han encontrado resultados para la búsqueda.</div>
                    }
                </div>
            }
            {
                (searchTriggered===true && isLoading===true) &&
                <div>Spinner</div>
            }
        </>
    );
}

export default Search