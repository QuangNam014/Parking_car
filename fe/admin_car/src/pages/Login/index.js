import { useFormik } from 'formik';
import * as Yup from 'yup';

import './login.css';
import imgPath from '~/pages/Login/image/index.js';
import { LoginModel } from '~/utils';
import React, { useEffect, useState } from 'react';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

import { Link, useNavigate } from 'react-router-dom';

function Login() {
    const [error, setError] = useState(false);
    const navigate = useNavigate();
    const isAuthenticate = localStorage.getItem('token') !== null;
    useEffect(() => {
        if (isAuthenticate) navigate('/dashboard', { replace: true });
    }, []);
    const formik = useFormik({
        initialValues: {
            email: '',
            password: '',
        },
        validationSchema: Yup.object({
            email: Yup.string()
                .required('Required')
                .matches(/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/, 'Please enter a valid email address'),
            password: Yup.string()
                .required('Required')
                .matches(
                    /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d][A-Za-z\d!@#$%^&*()_+]{7,19}$/,
                    'Password must be 7-19 characters and contain at least one letter, one number and a special character',
                ),
        }),
        onSubmit: async (values) => {
            try {
                const { email, password } = values;

                if (!email || !password) {
                    toast.error('Email/Password is required!');
                    return;
                }

                if (formik.errors.email || formik.errors.password) {
                    setError(true);
                    toast.error('Email or password is invalid!');
                    return;
                }
                setError(false);

                const result = await LoginModel(email, password);

                if (result.status === 200) {
                    console.log(result);
                    localStorage.setItem('token', result.data.token);
                    localStorage.setItem('inforUser', JSON.stringify(result.data.inforUser));
                    navigate(`/dashboard`);
                }
            } catch (error) {
                if (error.response.status === 401) {
                    toast.error('Email or password is invalid!');
                } else if (error.message === 'Network Error') {
                    toast.error('Network Error');
                } else {
                    const errorValid = error.response.data.message;
                    if (errorValid === 'Provider data is incorrect') {
                        toast.error('Network Error');
                    }
                }
            }
        },
    });

    return (
        <div className="sign-in" style={{ backgroundColor: '#6dabe4', height: '100vh' }}>
            <div>
                <ToastContainer
                    className="toaster-container"
                    position="top-right"
                    autoClose={500}
                    hideProgressBar={true}
                    newestOnTop={false}
                    rtl={false}
                    pauseOnFocusLoss
                    draggable
                    pauseOnHover
                />
            </div>
            <div className="signin-content">
                <div className="signin-image">
                    <figure>
                        <img src={imgPath} alt="sign up" />
                    </figure>
                    <Link to={'/forgotPassword'} className="signup-image-link">
                        Forgot password ?
                    </Link>
                </div>
                <div className="signin-form">
                    <h2 className="form-title">Sign up</h2>
                    <form className="loginForm" id="loginForm" onSubmit={formik.handleSubmit}>
                        <div className="form-group">
                            <label htmlFor="email">
                                <i className="zmdi zmdi-account material-icons-name"></i>
                            </label>
                            <input
                                value={formik.values.email}
                                onChange={formik.handleChange}
                                type="email"
                                name="email"
                                id="email"
                                placeholder="Your Email"
                                required
                                style={{
                                    border:
                                        formik.touched.email && formik.errors.email
                                            ? '1px solid red'
                                            : '1px solid black',
                                    color: formik.touched.email && formik.errors.email ? 'red' : 'black',
                                }}
                            />
                            {formik.touched.email && formik.errors.email && (
                                <p style={{ color: 'red' }}>{formik.errors.email}</p>
                            )}
                        </div>
                        <div className="form-group">
                            <label htmlFor="password">
                                <i className="zmdi zmdi-lock"></i>
                            </label>
                            <input
                                value={formik.values.password}
                                onChange={formik.handleChange}
                                type="password"
                                name="password"
                                id="password"
                                placeholder="Password"
                                required
                                style={{
                                    border:
                                        formik.touched.password && formik.errors.password
                                            ? '1px solid red'
                                            : '1px solid black',
                                    color: formik.touched.password && formik.errors.password ? 'red' : 'black',
                                }}
                            />
                            {formik.touched.password && formik.errors.password && (
                                <p style={{ color: 'red' }}>{formik.errors.password}</p>
                            )}
                        </div>

                        <div className="form-group form-button">
                            <button
                                style={{
                                    backgroundColor: '#4caf50',
                                    color: 'white',
                                    padding: '10px 15px',
                                    border: 'none',
                                    borderRadius: '4px',
                                    cursor: 'pointer',
                                }}
                                type="submit"
                            >
                                Login
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    );
}

export default Login;
