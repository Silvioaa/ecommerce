import axios from "axios";

export const LOADING = "LOADING";
export const SET_SEARCH = "SET_SEARCH";
export const ADD_ITEM_CART = "ADD_ITEM_CART";
export const REMOVE_ITEM_CART = "REMOVE_ITEM_CART";
export const SET_LOADING_ERROR = "SET_LOADING_ERROR";
export const MODIFY_ITEM_CART = "MODIFY_ITEM_CART";
export const SET_CURRENT_PRODUCT = "SET_CURRENT_PRODUCT";
export const SET_SEARCH_TRIGGERED = "SET_SEARCH_TRIGGERED";
export const SET_IS_PRODUCT_IN_CART = "SET_IS_PRODUCT_IN_CART";
export const PAY = "PAY";

export const loading = (status) => {
    return {
        type: LOADING,
        status
    }
}

export const setSearch = (search) => {
    return {
        type: SET_SEARCH,
        search
    }
}

export const addItemCart = (product) => {
    return {
        type: ADD_ITEM_CART,
        product
    }
}

export const modifyItemCart = (id, sumItem) => {
    return {
        type: MODIFY_ITEM_CART,
        id,
        sumItem

    }
}

export const removeItemCart = (id) => {
    return {
        type: REMOVE_ITEM_CART,
        id
    }
}

export const setLoadingError = (status) => {
    return {
        type: SET_LOADING_ERROR,
        status
    }
}

export const setCurrentProduct = (currentProduct) => {
    return {
        type: SET_CURRENT_PRODUCT,
        currentProduct
    }
}

export const setSearchTriggered = () => {
    return {
        type: SET_SEARCH_TRIGGERED
    }
}

export const setIsProductInCart = (isProductInCart) => {
    return {
        type: SET_IS_PRODUCT_IN_CART,
        isProductInCart
    }
}

export const pay = () => {
    return {
        type: PAY
    }
}

export const makeSearch = params => async (dispatch, getState) => {
    dispatch(loading(true));
    dispatch(setLoadingError(false));

    const first = params===null ? null : params.charAt(0).toUpperCase();
    const rest = params===null ? null : params.toLowerCase().slice(1);
    const firstCapital = params===null ? null : first + rest;
    try{
        const response = params===null ?
            await axios.get(`${getState().path}products`):
            await axios.get(`${getState().path}products?name=${params}&name=${firstCapital}`)
        if(response.statusText==="OK"){
            dispatch(setSearch(response.data));
        }else{
            dispatch(setSearch([]))
            dispatch(setLoadingError(true))
        }
        dispatch(loading(false));
    }catch(error){
        dispatch(setLoadingError(true))
        dispatch(setSearch([]));
        dispatch(loading(false));
        alert(error);
    }
}

export const loadProduct = id => async (dispatch, getState) => {
    dispatch(loading(true));
    if(id===undefined){
        setCurrentProduct([]);
        dispatch(loading(false));
        return
    }
    try{
        const response = await axios.get(`${getState().path}products?id=${id}`);
        if(response.statusText==="OK"){
            dispatch(setCurrentProduct(response.data));
        }else{
            dispatch(setCurrentProduct([]))
            dispatch(setLoadingError(true))
        }
        dispatch(loading(false));
    }catch(error){
        dispatch(setLoadingError(true))
        dispatch(setCurrentProduct([]));
        dispatch(loading(false));
        alert(error);
    }

} 




