import { Box, Typography, gridClasses, useColorScheme } from '@mui/material';
import { DataGrid } from '@mui/x-data-grid';
import React from 'react';
import { useMemo } from 'react';
import { mockDataUser } from '~/data/FakeData';
import theme, { tokens } from '~/theme';

import AdminPanelSettingsOutlinedIcon from '@mui/icons-material/AdminPanelSettingsOutlined';
import LockOpenOutlinedIcon from '@mui/icons-material/LockOpenOutlined';
import SecurityOutlinedIcon from '@mui/icons-material/SecurityOutlined';
import { useState } from 'react';
import UsersActions from './RegisteredParkingActions';

const UserType = {
    User: 'user',
    Admin: 'admin',
    Manager: 'manager',
};

function RegisteredParking(props) {
    const { mode } = useColorScheme();
    const colors = tokens(mode);

    const [pageSize, setPageSize] = useState(5);
    const [rowId, setRowId] = useState(null);

    const columns = useMemo(
        () => [
            { field: 'id', headerName: 'ID' },
            {
                field: 'name',
                headerName: 'Name',
                flex: 1,
                editable: true,
                cellClassName: 'name-column--cell',
            },
            {
                field: 'age',
                headerName: 'Age',
                type: 'number',
                editable: true,
                headerAlign: 'left',
                align: 'left',
            },
            {
                field: 'phone',
                headerName: 'Phone Number',
                flex: 1,
                editable: true,
            },
            {
                field: 'email',
                headerName: 'Email',
                flex: 1,
            },
            {
                field: 'password',
                headerName: 'Password',
                type: 'number',
                editable: true,
                headerAlign: 'left',
                align: 'left',
            },
            {
                field: 'access',
                headerName: 'Role',
                headerAlign: 'center',
                flex: 1,
                renderCell: ({ row: { access } }) => {
                    return (
                        <Box
                            width="60%"
                            m="0 auto"
                            p="5px"
                            display="flex"
                            justifyContent="center"
                            backgroundColor={
                                access === 'admin'
                                    ? colors.greenAccent[600]
                                    : access === 'manager'
                                    ? colors.greenAccent[700]
                                    : colors.greenAccent[800]
                            }
                            borderRadius="4px"
                        >
                            {access === UserType.Admin && <AdminPanelSettingsOutlinedIcon />}
                            {access === UserType.Manager && <SecurityOutlinedIcon />}
                            {access === UserType.User && <LockOpenOutlinedIcon />}
                            <Typography color={colors.grey[100]} sx={{ ml: '5px' }}>
                                {access}
                            </Typography>
                        </Box>
                    );
                },
            },
            {
                field: 'actions',
                headerName: 'Actions',
                type: 'actions',
                renderCell: (params) => <UsersActions {...{ params, rowId, setRowId, colors }} />,
            },
        ],
        [rowId],
    );

    return (
        <Box
            sx={{
                height: 800,
                width: '100%',
            }}
        >
            <Typography variant="h3" component="h3" sx={{ textAlign: 'center', mt: 3, mb: 3 }}>
                Manage Users
            </Typography>
            <DataGrid
                columns={columns}
                rows={mockDataUser}
                getRowId={(row) => row.id}
                rowsPerPageOptions={[5, 10, 20]}
                pageSize={pageSize}
                onPageSizeChange={(newPageSize) => setPageSize(newPageSize)}
                getRowSpacing={(params) => ({
                    top: params.isFirstVisible ? 0 : 5,
                    bottom: params.isLastVisible ? 0 : 5,
                })}
                onCellEditCommit={(params) => setRowId(params.id)}
            />
        </Box>
    );
}

export default RegisteredParking;
