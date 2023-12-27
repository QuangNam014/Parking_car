import React from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import Stack from '@mui/material/Stack';
import CardContent from '@mui/material/CardContent';
import GeoChart from '../charts/GeoChart';
import PieChart from '../charts/PieChart';
import { HBarChart } from '../charts/HBarChart';

export default function Analytics() {
    return (
        <div className="bgcolor">
            <Box height={40} />
            <Box sx={{ display: 'flex' }}>
                <Box component="main" sx={{ flexGrow: 1, p: 3 }}>
                    <Grid container spacing={2}>
                        <Grid item xs={5}>
                            <Stack direction="row" spacing={2}>
                                <Box sx={{ width: '50%', height: '100%' }}>
                                    <Card sx={{ height: 19 + 'vh' }} className="gradient">
                                        <CardContent>
                                            <Typography
                                                gutterBottom
                                                variant="p"
                                                component="div"
                                                sx={{ color: '#f0fcfc', padding: '7px 0px' }}
                                            >
                                                Visitors
                                            </Typography>
                                            <Typography
                                                gutterBottom
                                                variant="h5"
                                                component="div"
                                                sx={{ color: '#f0fcfc' }}
                                            >
                                                24,630
                                            </Typography>
                                            <Typography
                                                variant="body2"
                                                color="text.secondary"
                                                sx={{ color: 'ccd1d1 ' }}
                                            >
                                                Since last week
                                            </Typography>
                                        </CardContent>
                                    </Card>
                                    <Card sx={{ height: 19 + 'vh', marginTop: '16px' }} className="gradient">
                                        <CardContent>
                                            <Typography
                                                gutterBottom
                                                variant="p"
                                                component="div"
                                                sx={{ color: '#f0fcfc', padding: '7px 0px' }}
                                            >
                                                Visitors
                                            </Typography>
                                            <Typography
                                                gutterBottom
                                                variant="h5"
                                                component="div"
                                                sx={{ color: ' #f0fcfc' }}
                                            >
                                                24,630
                                            </Typography>
                                            <Typography
                                                variant="body2"
                                                color="text.secondary"
                                                sx={{ color: '#ccd1d1' }}
                                            >
                                                Since last week
                                            </Typography>
                                        </CardContent>
                                    </Card>
                                </Box>
                                <Box sx={{ width: '50%', height: '100%' }}>
                                    <Card sx={{ height: 19 + 'vh' }} className="gradientlight">
                                        <CardContent>
                                            <Typography
                                                gutterBottom
                                                variant="p"
                                                component="div"
                                                sx={{ color: '#f0fcfc', padding: '7px 0px' }}
                                            >
                                                Vistors
                                            </Typography>
                                            <Typography
                                                gutterBottom
                                                variant="h5"
                                                component="div"
                                                sx={{ color: ' #f0fcfc' }}
                                            >
                                                24,630
                                            </Typography>
                                            <Typography
                                                gutterBottom
                                                variant="body2"
                                                color="text.secondary"
                                                sx={{ color: '#ccd1d1' }}
                                            >
                                                Since last week
                                            </Typography>
                                        </CardContent>
                                    </Card>
                                    <Card sx={{ height: 19 + 'vh', marginTop: '16px' }} className="gradientlight">
                                        <CardContent>
                                            <Typography
                                                gutterBottom
                                                variant="p"
                                                component="div"
                                                sx={{ color: '#f0fcfc', padding: '7px 0px' }}
                                            >
                                                Vistors
                                            </Typography>
                                            <Typography
                                                gutterBottom
                                                variant="h5"
                                                component="div"
                                                sx={{ color: ' #f0fcfc' }}
                                            >
                                                24,630
                                            </Typography>
                                            <Typography
                                                gutterBottom
                                                variant="body2"
                                                color="text.secondary"
                                                sx={{ color: '#ccd1d1' }}
                                            >
                                                Since last week
                                            </Typography>
                                        </CardContent>
                                    </Card>
                                </Box>
                            </Stack>
                        </Grid>
                        <Grid item xs={7}>
                            <Card sx={{ height: '40vh' }}>
                                <CardContent>
                                    <HBarChart />
                                </CardContent>
                            </Card>
                        </Grid>
                    </Grid>
                    <Box height={16} />
                    <Grid container spacing={2}>
                        <Grid item xs={8}>
                            <Card sx={{ height: '40vh' }}>
                                <CardContent>
                                    <GeoChart />
                                </CardContent>
                            </Card>
                        </Grid>
                        <Grid item xs={4}>
                            <Card sx={{ height: '40vh' }}>
                                <CardContent>
                                    <PieChart />
                                </CardContent>
                            </Card>
                        </Grid>
                    </Grid>
                </Box>
            </Box>
        </div>
    );
}
