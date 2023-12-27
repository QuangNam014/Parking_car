import { Box, Button, Card, CardContent, Stack, Typography } from '@mui/material';
import Header from '~/components/Header/Header';
import React, { useState, useEffect } from 'react';
import Grid from '@mui/material/Grid';
import StorefrontIcon from '@mui/icons-material/Storefront';
import CreditCardIcon from '@mui/icons-material/CreditCard';
import ShoppingBagIcon from '@mui/icons-material/ShoppingBag';
import AccordionDash from './AccordionDash';
import '../dashboard/Dashboard.css';
import BarChart from '../charts/BarChart';

function Dashboard(props) {
    return (
        <Box m="20px" display="flex" flexDirection="column">
            <Header title="DASHBOARD" subtitle="Welcome to dashboard" />
            <div className="bgcolor">
                <Box component="main" sx={{ flexGrow: 1, p: 3 }}>
                    <Grid container spacing={2}>
                        <Grid item xs={8}>
                            <Stack spacing={2} direction={'row'}>
                                <Card sx={{ minWidth: 49 + '%', height: 150 }} className="gradient">
                                    <CardContent>
                                        <div className="iconstyle">
                                            <CreditCardIcon />
                                        </div>
                                        <Typography gutterBottom variant="h5" component="div" sx={{ color: '#ffffff' }}>
                                            $500.00
                                        </Typography>
                                        <Typography
                                            gutterBottom
                                            variant="body2"
                                            component="div"
                                            sx={{ color: '#ccd1d1' }}
                                        >
                                            Total Earnings
                                        </Typography>
                                    </CardContent>
                                </Card>

                                <Card sx={{ minWidth: 49 + '%', height: 150 }} className="gradientlight">
                                    <CardContent>
                                        <div className="iconstyle">
                                            <ShoppingBagIcon />
                                        </div>
                                        <Typography gutterBottom variant="h5" component="div" sx={{ color: '#ffffff' }}>
                                            $900.00
                                        </Typography>
                                        <Typography
                                            gutterBottom
                                            variant="body2"
                                            component="div"
                                            sx={{ color: '#ccd1d1' }}
                                        >
                                            Total Orders
                                        </Typography>
                                    </CardContent>
                                </Card>
                            </Stack>
                        </Grid>
                        <Grid item xs={4}>
                            <Stack spacing={2}>
                                <Card className="gradientlight">
                                    <Stack spacing={2} direction="row">
                                        <div className="iconstyle" style={{ marginLeft: '10px' }}>
                                            <StorefrontIcon />
                                        </div>
                                        <div className="paddingall">
                                            <span className="pricetitle">$203k</span>
                                            <br />
                                            <span className="pricesubtitle">Total Income</span>
                                        </div>
                                    </Stack>
                                </Card>
                                <Card>
                                    <Stack spacing={2} direction="row">
                                        <div className="iconstyleblack" style={{ marginLeft: '10px' }}>
                                            <StorefrontIcon />
                                        </div>
                                        <div className="paddingall">
                                            <span className="pricetitle">$203k</span>
                                            <br />
                                            <span className="pricesubtitle">Total Income</span>
                                        </div>
                                    </Stack>
                                </Card>
                            </Stack>
                        </Grid>
                    </Grid>
                    <Box height={20} />
                    <Grid container spacing={2}>
                        <Grid item xs={8}>
                            <Card sx={{ height: 60 + 'vh' }}>
                                <CardContent>
                                    <BarChart />
                                </CardContent>
                            </Card>
                        </Grid>
                        <Grid item xs={4}>
                            <Card sx={{ height: 60 + 'vh' }}>
                                <CardContent>
                                    <div className="paddingall">
                                        <span className="pricetitle">Popular Products</span>
                                    </div>
                                    <AccordionDash />
                                </CardContent>
                            </Card>
                        </Grid>
                    </Grid>
                </Box>
            </div>
        </Box>
    );
}

export default Dashboard;
