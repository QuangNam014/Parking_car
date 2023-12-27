import { Route, Routes } from 'react-router-dom';

import Dashboard from './pages/dashboard/Dashboard';
import ManagerUser from './pages/user/ManagerUser';
import ManagerParking from './pages/parking/ManagerParking';
import axios from 'axios';
import './App.css';
import Layout from './layout/Layout';
import Login from './pages/Login';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import ManagerCustomer from './pages/customer/ManagerCustomer';

import Analytics from './pages/analytics/Analytics';
import ManagerRegisteredParking from './pages/registeredparking/ManagerRegisteredParking';
import ManagerTransaction from './pages/transaction/ManagerTransaction';
import ManagerAccounting from './pages/accounting/ManagerAccounting';
import ForgotPassword from './pages/ForgotPassword';
import EnterNewPassword from './pages/ForgotPassword/EnterNewPassword';

function App() {
    // axios.interceptors.request.use(
    //     (config) => {
    //         const token = localStorage.getItem('token');

    //         if (token) {
    //             config.headers['Authorization'] = `Bearer ${token}`;
    //         }

    //         return config;
    //     },
    //     (error) => {
    //         return Promise.reject(error);
    //     },
    // );
    return (
        <div className="app">
            <main className="content">
                <Routes>
                    <Route path="/" element={<Login />} />
                    <Route path="/forgotPassword" element={<ForgotPassword />} />
                    <Route path="/newPassword" element={<EnterNewPassword />} />

                    <Route
                        path="/dashboard"
                        element={
                            <Layout>
                                <Dashboard />
                            </Layout>
                        }
                    />
                    <Route
                        path="/user"
                        element={
                            <Layout>
                                <ManagerUser />
                            </Layout>
                        }
                    />
                    <Route
                        path="/customer"
                        element={
                            <Layout>
                                <ManagerCustomer />
                            </Layout>
                        }
                    />
                    <Route
                        path="/parking"
                        element={
                            <Layout>
                                <ManagerParking />
                            </Layout>
                        }
                    />
                    {/* <Route
                        path="/accounting"
                        element={
                            <Layout>
                                <ManagerAccounting />
                            </Layout>
                        }
                    /> */}
                    <Route
                        path="/transaction"
                        element={
                            <Layout>
                                <ManagerTransaction />
                            </Layout>
                        }
                    />
                    <Route
                        path="/registeredparking"
                        element={
                            <Layout>
                                <ManagerRegisteredParking />
                            </Layout>
                        }
                    />
                    <Route
                        path="/analytics"
                        element={
                            <Layout>
                                <Analytics />
                            </Layout>
                        }
                    />
                </Routes>
            </main>
        </div>
    );
}

export default App;
