import { NavLink } from "react-router-dom"

const Navbar = () => {

    return(
        <div className="navBar">
            <div>
                <NavLink to="/search">Search</NavLink>
                <NavLink to="/cart">Cart</NavLink>
            </div>
        </div>
    );
}

export default Navbar;