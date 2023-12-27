import { Box, Button, Typography, useColorScheme } from '@mui/material';
import Header from '~/components/Header/Header';
import { DataGrid } from '@mui/x-data-grid';
import { tokens } from '~/theme';

import AdminPanelSettingsOutlinedIcon from '@mui/icons-material/AdminPanelSettingsOutlined';
import LockOpenOutlinedIcon from '@mui/icons-material/LockOpenOutlined';
import SecurityOutlinedIcon from '@mui/icons-material/SecurityOutlined';

import { mockDataUser } from '~/data/FakeData';
import { useMemo, useState } from 'react';
import SelectedRole from './SelectedRole';

import AddIcon from '@mui/icons-material/Add';
import EditIcon from '@mui/icons-material/Edit';

import SaveIcon from '@mui/icons-material/Save';
import CancelIcon from '@mui/icons-material/Close';

import UsersActions from './AccountingActions';

const UserType = {
    User: 'user',
    Admin: 'admin',
    Manager: 'manager',
};

function ManagerAccounting(props) {
    const { mode } = useColorScheme();
    const colors = tokens(mode);

    const [pageSize, setPageSize] = useState(5);
    const [rowId, setRowId] = useState(null);
    const [type, setType] = useState(UserType.User);

    const filteredUsers = mockDataUser.filter((user) => user.access === type);

    const columns = useMemo(
        () => [
            { field: 'id', headerName: 'ID' },
            {
                field: 'parking_address_id',
                headerName: 'Parking Address ID',
                flex: 1,
                editable: true,
                cellClassName: 'name-column--cell',
            },
            {
                field: 'parking_image_id',
                headerName: 'Supplier ID',
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
                type: 'password',
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
                flex: 1,
                renderCell: (params) => <UsersActions {...{ params, rowId, setRowId, colors }} />,
            },
        ],
        [rowId],
    );

    return (
        <Box m="20px">
            <Box
                m="40px 0 0 0"
                height="100vh"
                sx={{
                    '& .MuiDataGrid-root': {
                        border: 'none',
                    },
                    '& .MuiDataGrid-cell': {
                        borderBottom: 'none',
                    },
                    '& .name-column--cell': {
                        color: colors.greenAccent[300],
                    },
                    '& .MuiDataGrid-columnHeaders': {
                        backgroundColor: colors.blueAccent[700],
                        borderBottom: 'none',
                    },
                    '& .MuiDataGrid-virtualScroller': {
                        backgroundColor: colors.primary[400],
                    },
                    '& .MuiDataGrid-footerContainer': {
                        borderTop: 'none',
                        backgroundColor: colors.blueAccent[700],
                    },
                    '& .MuiCheckbox-root': {
                        color: `${colors.greenAccent[200]} !important`,
                    },
                }}
            >
                <Header title="Accounting" subtitle="Managing to accounting" />
                <SelectedRole type={type} setType={setType} UserType={UserType} />

                <DataGrid
                    columns={columns}
                    rows={filteredUsers}
                    checkboxSelection
                    // get id
                    getRowId={(row) => row.id}
                    // pagination

                    rowsPerPageOptions={[5, 10, 20]}
                    pageSize={pageSize}
                    onPageSizeChange={(newPageSize) => setPageSize(newPageSize)}
                    // khoang cach giua cac hang
                    getRowSpacing={(params) => ({
                        top: params.isFirstVisible ? 0 : 5,
                        bottom: params.isLastVisible ? 0 : 5,
                    })}
                    // kêt thúc chỉnh sửa và xác nhận thay đổi
                    onCellEditCommit={(params) => setRowId(params.id)}
                    onSelect
                />
            </Box>
        </Box>
    );
}

export default ManagerAccounting;
