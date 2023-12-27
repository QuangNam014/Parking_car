import { Box, Button, Grid, Typography, useColorScheme } from '@mui/material';
import Header from '~/components/Header/Header';
import { DataGrid } from '@mui/x-data-grid';
import { tokens } from '~/theme';

import AdminPanelSettingsOutlinedIcon from '@mui/icons-material/AdminPanelSettingsOutlined';
import LockOpenOutlinedIcon from '@mui/icons-material/LockOpenOutlined';
import SecurityOutlinedIcon from '@mui/icons-material/SecurityOutlined';

import { mockDataUser } from '~/data/FakeData';
import { useEffect, useMemo, useState } from 'react';
import SelectedRole from './SelectedRole';

import { getListCustomerInfo } from '~/utils';
import CustomersActions from './CustomersActions';
import LiveSearch from './LiveSearch';

const UserType = {
    User: 'user',
    Admin: 'admin',
    Manager: 'manager',
};

function ManagerCustomer(props) {
    const { mode } = useColorScheme();
    const colors = tokens(mode);

    const [pageSize, setPageSize] = useState(11);
    const [rowId, setRowId] = useState(null);
    const [type, setType] = useState(UserType.User);
    const [customers, setCustomers] = useState([]);
    const [userDocuments, setUserDocuments] = useState([]);
    const [searchedUserDocument, setSearchedUserDocument] = useState(null);
    const [searchResults, setSearchResults] = useState([]);
    const [modal, setModal] = useState(false);

    const handleModal = () => {
        setModal((prevModal) => !prevModal);
        console.log('Modal Value:', modal);
    };
    useEffect(() => {
        // console.log('Modal Value efecct:', modal);
        // ... rest of the code
    }, [modal]);

    useEffect(() => {
        getListCustomerInfo().then(
            (result) => {
                console.log('API call successful:', result.data);
                const userDocs = result.data.map((customer) => customer.userDocument);
                setUserDocuments(userDocs);
                setCustomers(result.data);

                setSearchResults(result.data);
                // Do other processing with the data if needed
            },
            (error) => {
                console.error('Error fetching data:', error);
                // Handle errors here
                if (error.message === 'Network Error') {
                    console.error('Network Error:', error);
                    // toast.error('Failed to fetch data. Please try again later.');
                }
            },
        );
    }, [modal]);

    const handleSearchSelect = (result) => {
        // Xử lý dữ liệu trả về từ LiveSearch ở đây
        console.log('Selected value in ManagerCustomer:', result.data);
        setSearchedUserDocument(result.data);

        // Cập nhật trạng thái để kích hoạt re-render
    };

    useEffect(() => {
        // Xử lý logic sau khi re-render (nếu cần)
        console.log('ManagerCustomer re-rendered');

        // Đặt trạng thái về false để chuẩn bị cho lần tìm kiếm tiếp theo
    }, [searchResults]);

    console.log(searchedUserDocument);

    const columns = useMemo(
        () => [
            { field: 'id', headerName: 'ID' },
            {
                field: 'userDocument',
                headerName: 'CCCD',
                type: 'number',
                flex: 0.5,
                editable: true,
                cellClassName: 'name-column--cell',
                headerAlign: 'left',
                align: 'left',
            },
            {
                field: 'userLicense',
                headerName: 'User License',
                type: 'number',
                flex: 0.5,
                editable: true,
                headerAlign: 'left',
                align: 'left',
            },

            {
                field: 'access',
                headerName: 'Role',
                headerAlign: 'center',
                flex: 0.5,
                renderCell: ({ row: { access } }) => {
                    const defaultRole = UserType.User;
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
                                {access || defaultRole}
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
                renderCell: (params) => <CustomersActions {...{ params, rowId, setRowId, colors }} />,
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
                <Header title="Customer" subtitle="Managing to customer" />

                <Grid container spacing={2}>
                    {/* SelectedRole component */}
                    {/* <Grid item xs={1}>
                        <SelectedRole type={type} setType={setType} UserType={UserType} />
                    </Grid> */}

                    {/* SearchComponent component */}
                    <Grid item xs={2} style={{ marginBottom: '10px' }}>
                        <LiveSearch userDocuments={userDocuments} onSelect={handleSearchSelect} />
                    </Grid>
                </Grid>
                {searchedUserDocument ? (
                    <DataGrid
                        columns={columns}
                        rows={searchedUserDocument ? [searchedUserDocument] : []}
                        // ... các props khác
                    />
                ) : (
                    <DataGrid
                        columns={columns}
                        rows={customers.map((customer) => {
                            return {
                                id: customer.id,
                                userDocument: customer.userDocument,
                                userLicense: customer.userLicense,
                            };
                        })}
                        // ... các props khác
                    />
                )}
            </Box>
        </Box>
    );
}

export default ManagerCustomer;
