import { LOADING, SET_SEARCH, ADD_ITEM_CART, REMOVE_ITEM_CART, 
    PAY, SET_LOADING_ERROR, MODIFY_ITEM_CART, SET_CURRENT_PRODUCT, SET_SEARCH_TRIGGERED} from './actions';

const initialState = {
    isLoading:false,
    loadingError:false,
    cart:[],
    search:[],
    currentProduct:[],
    searchTriggered:false,
    path: "https://fake-json-server-19830208.herokuapp.com/"
}

export function reducer(state=initialState, action){
    switch(action.type){
        case LOADING:
            return Object.assign({},state,{isLoading:action.status});
        case SET_SEARCH:
            return Object.assign({},state,{search: action.search})
        case ADD_ITEM_CART:
            let newCart = state.cart;
            newCart.push(action.product);
            newCart[newCart.length-1].quantity = 1;
            return Object.assign({},state,{cart:newCart});
        case MODIFY_ITEM_CART:
            let cartToModify = state.cart;
            let productIndex
            cartToModify.forEach((item, index) => {
                if(item.id===action.id) productIndex = index
            })
            if(action.sumItem===true) 
                cartToModify[productIndex].quantity = cartToModify[productIndex].quantity + 1
            else if(action.sumItem===false && cartToModify[productIndex].quantity > 1)
                cartToModify[productIndex].quantity = cartToModify[productIndex].quantity - 1
            else cartToModify[productIndex].quantity = 1;
            return Object.assign({},state,{cart:cartToModify})
        case REMOVE_ITEM_CART:
            let cartToRemoveFrom = state.cart
            cartToRemoveFrom = cartToRemoveFrom.filter((product) =>{console.log(typeof product.id, typeof action.id); return product.id!==action.id});
            console.log(cartToRemoveFrom)
            return Object.assign({},state,{cart:cartToRemoveFrom});
        case SET_LOADING_ERROR:
            return Object.assign({},state,{loadingError: action.status});
        case SET_CURRENT_PRODUCT:
            return Object.assign({},state,{currentProduct:action.currentProduct});
        case SET_SEARCH_TRIGGERED:
            return Object.assign({}, state, {searchTriggered: true})
        case PAY:
            return Object.assign({},state,{user:{},cart:[]});
        default:
            return state;
    }
}