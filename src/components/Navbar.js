import { NavLink } from "react-router-dom"

const Navbar = () => {

    return(
        <div className="navBar">
            <div>
                <NavLink to="/search">Búsqueda</NavLink>
                <NavLink to="/cart">Carrito</NavLink>
            </div>
        </div>
    );
}

export default Navbar;