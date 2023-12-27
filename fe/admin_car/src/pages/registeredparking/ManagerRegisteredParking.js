import { Box, Button, Grid, Typography, useColorScheme } from '@mui/material';
import Header from '~/components/Header/Header';
import { DataGrid } from '@mui/x-data-grid';
import { tokens } from '~/theme';

import { useMemo, useState, useEffect } from 'react';
import SelectedRole from './SelectedRole';

import { getAllParkingDetails, getListRegisteredParking } from '~/utils';
import { toast } from 'react-toastify';
import RegisteredParkingActions from './RegisteredParkingActions';
import LiveSearch from './LiveSearch';
import StatusChangeDialog from './StatusChangeDialog';

const UserType = {
    User: 'user',
    Admin: 'admin',
    Manager: 'manager',
};

function ManagerRegisteredParking(props) {
    const { mode } = useColorScheme();
    const colors = tokens(mode);

    const [pageSize, setPageSize] = useState(11);
    const [rowId, setRowId] = useState(null);
    const [type, setType] = useState(UserType.User);
    const [searchedCustomerId, setsearchedCustomerId] = useState(null);

    const [registeredParkings, setRegisteredParkings] = useState([]);
    const [selectedRegisteredParking, setSelectedRegisteredParking] = useState(null);
    const [statusDialogOpen, setStatusDialogOpen] = useState(false);

    const statusColors = {
        SUCCESS: 'green',
        CANCEL: 'gray',
        PENDING: 'orange',
    };
    useEffect(() => {
        const fetchData = async () => {
            try {
                const result = await getListRegisteredParking();

                console.log('API Response:', result);

                if (result.status === 200) {
                    setRegisteredParkings(result.data);
                }
            } catch (error) {
                if (error.message === 'Network Error') {
                    console.error('Error fetching data:', error);
                    toast.error('Failed to fetch data. Please try again later.');
                }
            }
        };

        fetchData();
    }, []);
    const handleSearchSelect = (result) => {
        // Xử lý dữ liệu trả về từ LiveSearch ở đây
        console.log('Selected value in Registered Parking:', result.data);
        setsearchedCustomerId(result.data);
    };

    // Hàm xử lý thay đổi trạng thái trong ManagerRegisteredParking
    const handleStatusChange = (registeredId, selectedStatus) => {
        console.log(`Dòng ${registeredId} - Trạng thái mới: ${selectedStatus}`);
    };

    console.log(registeredParkings);

    const handleStatusDialogOpen = (rowId) => {
        const selectedRegisteredParking = registeredParkings.find((parking) => parking.id === rowId);
        console.log(selectedRegisteredParking);

        setSelectedRegisteredParking(selectedRegisteredParking);
        setStatusDialogOpen(true);
    };

    console.log(selectedRegisteredParking);

    const handleStatusDialogClose = (selectedStatus) => {
        if (selectedStatus !== null) {
            handleStatusChange(rowId, selectedStatus);
        }
        setStatusDialogOpen(false);
    };

    const handleUpdateStatus = (registeredId, selectedStatus) => {
        const index = registeredParkings.findIndex((registeredParking) => registeredParking.id === registeredId);

        if (index !== -1) {
            const updatedRegisteredParkings = [...registeredParkings];
            updatedRegisteredParkings[index].status = selectedStatus;

            console.log('Updated Registered Parkings:', updatedRegisteredParkings);

            setRegisteredParkings(updatedRegisteredParkings);
        }
    };

    const columns = useMemo(
        () => [
            { field: 'id', headerName: 'ID' },
            {
                field: 'parkingTimeStart',
                headerName: 'Parking Time Start',
                flex: 1,
                type: 'number',
                editable: true,
                headerAlign: 'left',
                align: 'left',
                renderCell: (params) => {
                    const formatdate = new Intl.DateTimeFormat('en-Us', {
                        year: 'numeric',
                        month: 'short',
                        day: 'numeric',
                    }).format(new Date(params.value));
                    return formatdate;
                },
            },
            {
                field: 'parkingTimeEnd',
                headerName: 'Parking Time End',
                flex: 1,
                type: 'number',
                editable: true,
                headerAlign: 'left',
                align: 'left',
                renderCell: (params) => {
                    const formatdate = new Intl.DateTimeFormat('en-Us', {
                        year: 'numeric',
                        month: 'short',
                        day: 'numeric',
                    }).format(new Date(params.value));
                    return formatdate;
                },
            },
            {
                field: 'totalTime',
                headerName: 'Total Time',
                type: 'number',
                editable: true,
                headerAlign: 'left',
                align: 'left',
            },
            {
                field: 'totalPrice',
                headerName: 'Total Price',
                type: 'number',
                editable: true,
                headerAlign: 'left',
                align: 'left',
            },
            {
                field: 'status',
                headerName: 'Status',
                type: 'number',
                editable: true,
                headerAlign: 'left',
                align: 'left',
                renderCell: ({ row: { status } }) => (
                    <div
                        style={{
                            color: 'black',
                            backgroundColor: statusColors[status] || 'black',
                            padding: '5px 10px',
                            borderRadius: '4px',
                        }}
                    >
                        {status}
                    </div>
                ),
            },
            {
                field: 'chooseStatus',
                headerName: 'Choose Status',
                type: 'number',
                editable: true,
                headerAlign: 'left',
                align: 'left',
                flex: 0.5,
                renderCell: (params) => (
                    <Button variant="outlined" color="primary" onClick={() => handleStatusDialogOpen(params.id)}>
                        Change Status
                    </Button>
                ),
            },
            {
                field: 'customerV2Id',
                headerName: 'Customer ID',
                flex: 0.5,
                editable: true,
                cellClassName: 'name-column--cell',
            },
            {
                field: 'parkingDetailsId',
                headerName: 'Parking Details ID',
                flex: 0.5,
                editable: true,
                cellClassName: 'name-column--cell',
            },
            {
                field: 'actions',
                headerName: 'Actions',
                type: 'actions',
                flex: 1,
                renderCell: (params) => <RegisteredParkingActions {...{ params, rowId, setRowId, colors }} />,
            },
        ],
        [rowId, handleStatusChange],
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
                <Header title="Registered Parking" subtitle="Managing to registered parking" />

                <Grid container spacing={2}>
                    {/* SelectedRole component */}
                    {/* <Grid item xs={1}>
                        <SelectedRole type={type} setType={setType} UserType={UserType} />
                    </Grid> */}

                    {/* SearchComponent component */}
                    <Grid item xs={2} style={{ marginBottom: '10px' }}>
                        <LiveSearch registeredParkings={registeredParkings} onSelect={handleSearchSelect} />
                    </Grid>
                </Grid>
                {searchedCustomerId ? (
                    <DataGrid
                        columns={columns}
                        rows={searchedCustomerId ? [searchedCustomerId] : []}
                        // ... các props khác
                    />
                ) : (
                    <DataGrid
                        columns={columns}
                        rows={registeredParkings.map((registeredParking) => {
                            return {
                                id: registeredParking.id,
                                parkingTimeStart: registeredParking.parkingTimeStart,
                                parkingTimeEnd: registeredParking.parkingTimeEnd,
                                totalTime: registeredParking.totalTime,
                                totalPrice: registeredParking.totalPrice,
                                status: registeredParking.status,
                                customerV2Id: `${registeredParking.customerV2Id.id}`,
                                parkingDetailsId: `${registeredParking.parkingDetailsId.id}`,
                            };
                        })}
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
                )}
                <StatusChangeDialog
                    open={statusDialogOpen}
                    onClose={handleStatusDialogClose}
                    selectedRegisteredParking={selectedRegisteredParking}
                    onStatusChange={handleStatusChange}
                    onUpdateStatus={handleUpdateStatus}
                />
            </Box>
        </Box>
    );
}

export default ManagerRegisteredParking;
