import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { makeSearch, setSearchTriggered } from '../redux/actions';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';

const Search = () => {
    const search = useSelector( state => state.search);
    const isLoading = useSelector( state => state.isLoading)
    const loadingError = useSelector( state => state.loadingError)
    const cart = useSelector( state => state.cart);
    const searchTriggered = useSelector( state => state.searchTriggered)
    const dispatch = useDispatch();
    const navigate = useNavigate();

    function handleSubmit(e){
        e.preventDefault();
        searchTriggered === false && dispatch(setSearchTriggered());
        if(e.target.id!=="all") dispatch(makeSearch(e.target[0].value))
        else dispatch(makeSearch(null))
    }

    function cleanSearch(e){
        e.preventDefault();
    }

    return(
        <>
            <Navbar/>
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
                                    <button onClick={() => navigate(`/product/${product.id}`)}>Ver Producto</button>
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