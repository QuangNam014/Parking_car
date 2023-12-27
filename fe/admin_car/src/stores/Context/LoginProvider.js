import { createContext, useState } from 'react';

export const LoginContext = createContext();

function LoginProvider({ children }) {
    const [checkLoginToken, setCheckLoginToken] = useState(null);
    const [checkRole, setCheckRole] = useState(null);
    const [checkInfoUser, setCheckInfoUser] = useState(null);

    const valueProvider = {
        checkLoginToken,
        checkRole,
        checkInfoUser,
        setCheckLoginToken,
        setCheckRole,
        setCheckInfoUser,
    };

    return <LoginContext.Provider value={valueProvider}>{children}</LoginContext.Provider>;
}

export default LoginProvider;
