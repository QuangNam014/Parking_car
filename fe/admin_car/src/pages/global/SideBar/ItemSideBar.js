import { Fragment } from 'react';
import { motion } from 'framer-motion';
import { Link } from 'react-router-dom';

function ItemSideBar({ icon, title, to, checkActive, setIsActive }) {
    const subheadingVariants = {
        true: {
            opacity: 1,
        },
        false: {
            opacity: 0,
            display: 'none',
        },
    };

    const itemVariants = {
        true: {},
        false: {
            margin: '0 -10px',
        },
    };

    const checkActiveVariant = {
        true: {},
        false: {
            margin: '0 -10px',
            padding: '0 10px',
        },
    };

    return (
        <Fragment>
            <Link to={to} style={{ textDecoration: 'none', color: 'inherit' }}>
                <motion.div className={`${checkActive}`} variants={checkActiveVariant}>
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
                        variants={itemVariants}
                        className="admin__sidebar--container-content-item"
                        onClick={() => setIsActive(title)}
                    >
                        <motion.div className="admin__sidebar--container-content-item-icon">{icon}</motion.div>
                        <motion.span
                            variants={subheadingVariants}
                            className="admin__sidebar--container-content-item-span"
                        >
                            {title}
                        </motion.span>
                    </motion.div>
                </motion.div>
            </Link>
        </Fragment>
    );
}

export default ItemSideBar;
