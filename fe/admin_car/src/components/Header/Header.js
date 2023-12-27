import React from 'react';
import { Box, Typography, useColorScheme } from '@mui/material';
import { tokens } from '~/theme';

function Header({ title, subtitle }) {
    const { mode } = useColorScheme();
    const colors = tokens(mode);
    return (
        <Box mb="20px">
            <Typography variant="h2" color={colors.grey[100]} fontWeight="bold" sx={{ mb: '5px' }}>
                {title}
            </Typography>
            <Typography variant="h5" color={colors.greenAccent[400]}>
                {subtitle}
            </Typography>
        </Box>
    );
}

export default Header;
