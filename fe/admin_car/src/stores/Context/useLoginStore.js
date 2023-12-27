import { useContext } from 'react';

import { LoginContext } from './LoginProvider';

function useLoginStore(props) {
    const value = useContext(LoginContext);
    return { ...value };
}

export default useLoginStore;
