import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { makeSearch, setSearchTriggered } from '../redux/actions';
import { useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import Container from '../components/Container';
import { TailSpin } from  'react-loader-spinner'

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

    return(
        <>
            <Navbar/>
            <Container>
                <form className='search-form' onSubmit={handleSubmit}>
                    <input type="text" placeholder='Buscar producto'/>
                    <div className='search-buttons'>
                        <input className='button' type="submit" value="Buscar"/>
                        <button className='button' id="all" onClick={handleSubmit}>Ver todos</button>
                    </div>
                </form>
                {
                    (searchTriggered===true && isLoading===false) &&
                    <div className='search-results'>
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
                                    <div className='search-results-card' id={product.id} key={product.name}>
                                        <img src={product.image}/>
                                        <h1>{product.name}</h1>
                                        <p>$ {product.price}</p>
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
                    <div className='spinner'>
                        <TailSpin color="#da6a01" height="200" width="200"/>
                    </div>
                }
            </Container>
        </>
    );
}

export default Search