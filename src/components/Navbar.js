import { NavLink } from "react-router-dom"

const Navbar = () => {

    function navStyle({ isActive}){
        return {
            marginRight: "2em",
            color: isActive ? "blue" : "black"
        }
    }

    return(
        <div>
            <NavLink style={navStyle} to="/search">Búsqueda</NavLink>
            <NavLink style={navStyle} to="/cart">Carrito</NavLink>
        </div>
    );
}

export default Navbar;