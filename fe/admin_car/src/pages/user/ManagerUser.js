import { Box, Typography, useColorScheme } from '@mui/material';
import Header from '~/components/Header/Header';
import { DataGrid } from '@mui/x-data-grid';
import { tokens } from '~/theme';

import AdminPanelSettingsOutlinedIcon from '@mui/icons-material/AdminPanelSettingsOutlined';
import LockOpenOutlinedIcon from '@mui/icons-material/LockOpenOutlined';
import SecurityOutlinedIcon from '@mui/icons-material/SecurityOutlined';

import { useMemo, useState } from 'react';
import SelectedRole from './SelectedRole';

import UsersActions from './UsersActions';
import { getListAdmin } from '~/utils';
import { useEffect } from 'react';
import { toast } from 'react-toastify';

import EditAdmin from './EditAdmin';

const UserType = {
    User: 'USER',
    Admin: 'ADMIN',
};

function ManagerUser(props) {
    const { mode } = useColorScheme();
    const colors = tokens(mode);

    const [pageSize, setPageSize] = useState(11);
    const [rowId, setRowId] = useState(null);
    const [type, setType] = useState(UserType.User);
    const [usersData, setUsersData] = useState([]);
    const [apiSuccess, setApiSuccess] = useState(false);
    const [modal, setModal] = useState(false);

    const handleModal = () => {
        setModal((prevModal) => !prevModal);
        console.log('Modal Value:', modal);
    };

    useEffect(() => {
        try {
            getListAdmin().then((result) => {
                if (result.status === 200) {
                    setUsersData(result.data);
                    setApiSuccess(false);
                    console.log('Updated user data:', usersData);
                }
            });
        } catch (error) {
            if (error.message === 'Network Error') {
                console.error('Error fetching data:', error);
                toast.error('Failed to fetch data. Please try again later.');
            }
        }
    }, [apiSuccess, modal]);

    const getAllUsers = usersData.filter((user) => user.role === type);

    const columns = useMemo(
        () => [
            { field: 'id', headerName: 'ID' },
            {
                field: 'fullname',
                headerName: 'Full name',
                flex: 1,
                editable: true,
                cellClassName: 'name-column--cell',
            },
            {
                field: 'email',
                headerName: 'Email',
                flex: 2,
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
                field: 'role',
                headerName: 'Role',
                headerAlign: 'center',
                flex: 1,
                renderCell: ({ row: { role } }) => {
                    return (
                        <Box
                            width="60%"
                            m="0 auto"
                            p="5px"
                            display="flex"
                            justifyContent="center"
                            backgroundColor={
                                role === 'ADMIN'
                                    ? colors.greenAccent[600]
                                    : // : role === 'MANAGER'
                                      // ? colors.greenAccent[700]
                                      colors.greenAccent[800]
                            }
                            borderRadius="4px"
                        >
                            {role === UserType.Admin && <AdminPanelSettingsOutlinedIcon />}
                            {/* {role === UserType.Manager && <SecurityOutlinedIcon />} */}
                            {role === UserType.User && <LockOpenOutlinedIcon />}
                            <Typography color={colors.grey[100]} sx={{ ml: '5px' }}>
                                {role}
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
                renderCell: (params) => (
                    <UsersActions {...{ params, rowId, setRowId, colors, handleModal: handleModal }} />
                ),
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
                <Header title="User" subtitle="Managing to user" />
                <SelectedRole type={type} setType={setType} UserType={UserType} />

                <DataGrid
                    columns={columns}
                    rows={getAllUsers}
                    checkboxSelection
                    // get id
                    getRowId={(row) => row.id}
                    // pagination

                    rowsPerPageOptions={[10, 20]}
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

export default ManagerUser;
