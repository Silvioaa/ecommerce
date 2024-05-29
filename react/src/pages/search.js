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
    const path = useSelector( state => state.path);
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
                    <input type="text" placeholder='Search product'/>
                    <div className='search-buttons'>
                        <input className='button' type="submit" value="Search"/>
                        <button className='button' id="all" onClick={handleSubmit}>See All</button>
                    </div>
                </form>
                {
                    (searchTriggered===true && isLoading===false) &&
                    <div className='search-results'>
                        {
                            search.length!==0 &&
                            search.map((product)=>{
                                return(
                                    <div className='search-results-card' id={product.id} key={product.productName}>
                                        <img src={`${path}images/${product.productImage}`} alt={product.productName}/>
                                        <h1>{product.productName}</h1>
                                        <p>$ {product.productPrice}</p>
                                        <button onClick={() => navigate(`/product/${product.id}`)}>See Product</button>
                                    </div>
                                )
                            })
                        }
                        {
                            (search.length===0 && loadingError===true) &&
                            <div>The search could not be performed. An error occurred.</div>
                        }
                        {    
                            (search.length===0 && loadingError===false) &&
                            <div>No results found for this search.</div>
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