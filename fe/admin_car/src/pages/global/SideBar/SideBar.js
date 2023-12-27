import HomeOutlinedIcon from '@mui/icons-material/HomeOutlined';
import PeopleOutlinedIcon from '@mui/icons-material/PeopleOutlined';
import LocalParkingOutlinedIcon from '@mui/icons-material/LocalParkingOutlined';
import ContactsIcon from '@mui/icons-material/Contacts';
import LeaderboardIcon from '@mui/icons-material/Leaderboard';
import AppRegistrationIcon from '@mui/icons-material/AppRegistration';
import AccountBalanceIcon from '@mui/icons-material/AccountBalance';
import CurrencyExchangeIcon from '@mui/icons-material/CurrencyExchange';

import { useState } from 'react';
import { motion } from 'framer-motion';

import HeaderSideBar from './HeaderSideBar';
import ItemSideBar from './ItemSideBar';

import './SideBar.css';
import { LogoutOutlined } from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';

function SideBar(props) {
    const [open, setOpen] = useState(true);
    const [isActive, setIsActive] = useState('Dashboard');
    const navigate = useNavigate();
    const sideContainerVariants = {
        true: {
            width: '15rem',
        },
        false: {
            transition: {
                delay: 0.6,
            },
            marginLeft: '-8rem',
        },
    };

    const sidebarVariants = {
        true: {},
        false: {
            width: '3.3rem',
            transition: {
                delay: 0.4,
            },
            stiffness: 700,
            damping: 30,
        },
    };

    const subheadingVariants1 = {
        true: {
            opacity: 1,
        },
        false: {
            opacity: 0,
            display: 'none',
        },
    };

    const itemVariants1 = {
        true: {},
        false: {
            margin: '0 -10px',
        },
    };

    const checkActiveVariant1 = {
        true: {},
        false: {
            margin: '0 -10px',
            padding: '0 10px',
        },
    };
    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('inforUser');
        navigate('/');
    };

    return (
        <motion.div
            layout
            data-open={open}
            initial={`${open}`}
            animate={`${open}`}
            variants={sideContainerVariants}
            className="admin__sidebar--container"
        >
            <motion.div
                layout
                initial={`${open}`}
                animate={`${open}`}
                variants={sidebarVariants}
                className="admin__sidebar--container-content"
            >
                <HeaderSideBar open={open} setOpen={setOpen} />

                {/* item */}
                <div className="admin__sidebar--container-content-groups">
                    <div className="admin__sidebar--container-content-group">
                        <motion.h3
                            animate={{ opacity: open ? 1 : 0, height: open ? 'auto' : 0 }}
                            className="admin__sidebar--container-content-h3"
                        >
                            ANALYTIC
                        </motion.h3>

                        <ItemSideBar
                            icon={<HomeOutlinedIcon />}
                            title="Dashboard"
                            checkActive={isActive === 'Dashboard' ? 'sidebar-active' : ''}
                            to="/dashboard"
                            isActive={isActive}
                            setIsActive={setIsActive}
                        />

                        <ItemSideBar
                            icon={<PeopleOutlinedIcon />}
                            title="User"
                            checkActive={isActive === 'User' ? 'sidebar-active' : ''}
                            to="/user"
                            isActive={isActive}
                            setIsActive={setIsActive}
                        />
                        <ItemSideBar
                            icon={<ContactsIcon />}
                            title="Customer"
                            checkActive={isActive === 'Customer' ? 'sidebar-active' : ''}
                            to="/customer"
                            isActive={isActive}
                            setIsActive={setIsActive}
                        />
                        <ItemSideBar
                            icon={<LocalParkingOutlinedIcon />}
                            title="Parking"
                            checkActive={isActive === 'Parking' ? 'sidebar-active' : ''}
                            to="/parking"
                            isActive={isActive}
                            setIsActive={setIsActive}
                        />
                        {/* <ItemSideBar
                            icon={<AccountBalanceIcon />}
                            title="Accounting"
                            checkActive={isActive === 'Accounting' ? 'sidebar-active' : ''}
                            to="/accounting"
                            isActive={isActive}
                            setIsActive={setIsActive}
                        /> */}
                        <ItemSideBar
                            icon={<CurrencyExchangeIcon />}
                            title="Transaction"
                            checkActive={isActive === 'Transaction' ? 'sidebar-active' : ''}
                            to="/transaction"
                            isActive={isActive}
                            setIsActive={setIsActive}
                        />
                        <ItemSideBar
                            icon={<AppRegistrationIcon />}
                            title="Order"
                            checkActive={isActive === 'RegisteredParking' ? 'sidebar-active' : ''}
                            to="/registeredparking"
                            isActive={isActive}
                            setIsActive={setIsActive}
                        />
                        <ItemSideBar
                            icon={<LeaderboardIcon />}
                            title="Analytics"
                            checkActive={isActive === 'Analytics' ? 'sidebar-active' : ''}
                            to="/analytics"
                            isActive={isActive}
                            setIsActive={setIsActive}
                        />
                        {/* <ItemSideBar
                            icon={<LogoutOutlined />}
                            title="Log out"
                            onClick={handleLogout}
                            to={'/'}
                            isActive={isActive}
                            setIsActive={setIsActive}
                        /> */}
                        <div>
                            <div style={{ textDecoration: 'none', color: 'inherit' }}>
                                <motion.div>
                                    <motion.div
                                        whileHover={{
                                            backgroundColor: 'rgba(255, 255, 255, 0.3)',
                                            boxShadow: '0 8px 32px 0 rgba(31, 38, 135, 0.37)',
                                            backdropFilter: 'blur(5.5px)',
                                            WebkitBackdropFilter: 'blur(5.5px)',
                                            border: '1px solid rgba( 255, 255, 255, 0.18 )',
                                            cursor: 'pointer',
                                        }}
                                        transition={{
                                            type: 'none',
                                            duration: 0.1,
                                        }}
                                        variants={itemVariants1}
                                        className="admin__sidebar--container-content-item"
                                        onClick={handleLogout}
                                    >
                                        <motion.div className="admin__sidebar--container-content-item-icon">
                                            <LogoutOutlined />
                                        </motion.div>
                                        <motion.span
                                            variants={subheadingVariants1}
                                            className="admin__sidebar--container-content-item-span"
                                        >
                                            Log out
                                        </motion.span>
                                    </motion.div>
                                </motion.div>
                            </div>
                        </div>
                    </div>
                </div>
            </motion.div>
        </motion.div>
    );
}

export default SideBar;
