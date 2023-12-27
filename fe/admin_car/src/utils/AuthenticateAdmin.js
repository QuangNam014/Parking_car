const AuthenticateAdmin = {
    token: localStorage.getItem('token'),
    inforUser: JSON.parse(localStorage.getItem('inforUser')),
};

export default AuthenticateAdmin;
