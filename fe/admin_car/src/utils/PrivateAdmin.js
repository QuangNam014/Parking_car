// import { Navigate } from 'react-router-dom';

// import { PathAdmin } from '~/routers/PathAdmin';
// import { useLoginStore } from '../stores';

// function PrivateAdmin({ children }) {
//     const { checkLoginToken } = useLoginStore();
//     const tokenLocal = localStorage.getItem('token');
//     const isLogginAdmin = checkLoginToken === null && tokenLocal === null;

//     if (isLogginAdmin) {
//         return <Navigate to={PathAdmin.adminLogin} replace />;
//     }
//     return children;
// }

// export default PrivateAdmin;
