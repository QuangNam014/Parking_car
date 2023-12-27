import { Box, Button, Typography, useColorScheme } from '@mui/material';
import Header from '~/components/Header/Header';
import { DataGrid } from '@mui/x-data-grid';
import { tokens } from '~/theme';

import { useMemo, useState, useEffect } from 'react';
import SelectedRole from './SelectedRole';

import AddIcon from '@mui/icons-material/Add';

import { createParkingDetails, getAllParkingDetails } from '~/utils';
import { toast } from 'react-toastify';

import 'react-toastify/dist/ReactToastify.css';
import CreateParkingForm from './CreateParkingForm';
import SuppliersActions from './SuppliersActions';
import StatusChangeDialog from './StatusChangeDialog';

const UserType = {
    User: 'user',
    Admin: 'admin',
    Manager: 'manager',
};

function ManagerParking(props) {
    const { mode } = useColorScheme();
    const colors = tokens(mode);

    const [pageSize, setPageSize] = useState(11);
    const [rowId, setRowId] = useState(null);
    const [type, setType] = useState(UserType.User);
    const [parkings, setParkings] = useState([]);

    const [isCreateFormOpen, setCreateFormOpen] = useState(false);

    const [selectedParking, setSelectedParking] = useState(null);
    const [oldUpdateValue, setOldUpdateValue] = useState([]);

    const statusColors = {
        AVAILABLE: 'green',
        CANCEL: 'gray',
        RENTING: 'orange',
        DISABLE: 'red',
        PENDING: 'brown',
    };

    const [modal, setModal] = useState(false);

    const handleModal = () => {
        setModal((prevModal) => !prevModal);
        console.log('Modal Value:', modal);
    };
    useEffect(() => {
        // console.log('Modal Value efecct:', modal);
        // ... rest of the code
    }, [modal]);

    // Hàm xử lý thay đổi trạng thái trong ManagerParking
    const handleStatusChange = (parkingId, selectedStatus) => {
        console.log(`Dòng ${parkingId} - Trạng thái mới: ${selectedStatus}`);
    };

    const [statusDialogOpen, setStatusDialogOpen] = useState(false);

    const handleStatusDialogOpen = (rowId) => {
        const selectedParking = parkings.find((parking) => parking.id === rowId);
        setSelectedParking(selectedParking);
        setStatusDialogOpen(true);
    };

    const handleStatusDialogClose = (selectedStatus) => {
        if (selectedStatus !== null) {
            handleStatusChange(rowId, selectedStatus);
        }
        setStatusDialogOpen(false);
    };

    const handleUpdateStatus = (parkingId, selectedStatus, apiResult) => {
        const index = parkings.findIndex((parking) => parking.id === parkingId);

        if (index !== -1) {
            const updatedParkings = [...parkings];
            updatedParkings[index].status = selectedStatus;

            console.log('Updated Parkings:', updatedParkings);

            setParkings(updatedParkings);
        }
    };

    useEffect(() => {
        // console.log('Component re-rendered with updated parkings:', parkings);
    }, [parkings]);

    useEffect(() => {
        try {
            getAllParkingDetails()
                .then((result) => {
                    // console.log(result.data);
                    if (result.status === 200) {
                        localStorage.setItem('parkingList', JSON.stringify(result.data));
                        setParkings(result.data);
                        setOldUpdateValue(result.data.data);
                    } else if (result.status === 400) {
                        setParkings([]);
                    }
                })
                .catch((error) => {
                    console.log(error);
                });
        } catch (error) {
            if (error.message === 'Network Error') {
                console.error('Error fetching data:', error);
                toast.error('Failed to fetch data. Please try again later.');
            }
        }
    }, [modal]);

    const handleCreateFormSuccess = () => {
        setModal((prevModal) => !prevModal);
        setCreateFormOpen(true);
        console.log('Create form success in parent component');
    };

    const columns = useMemo(
        () => [
            { field: 'id', headerName: 'ID' },
            {
                field: 'addressId',
                headerName: 'Parking Address',
                flex: 2,
                editable: true,
                cellClassName: 'name-column--cell',
            },
            {
                field: 'parkingImages',
                headerName: 'Image',
                flex: 1,
                renderCell: ({ row: { parkingImages } }) => (
                    <img
                        src={parkingImages}
                        alt="Hình ảnh bãi đỗ xe"
                        style={{ width: '50px', height: '50px', objectFit: 'cover' }}
                    />
                ),
            },

            {
                field: 'price',
                headerName: 'Price',
                flex: 0.5,
            },
            {
                field: 'totalSlot',
                headerName: 'Total Slot',
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
                            color: 'white',
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
                field: 'actions',
                headerName: 'Actions',
                type: 'actions',
                flex: 1,
                renderCell: (params) => {
                    // console.log('data: ', params.row);
                    var data = params.row;
                    return (
                        <SuppliersActions
                            {...{
                                params,
                                rowId,
                                setRowId,
                                colors,
                                updateParkings: setParkings,
                                handleModal: handleModal,
                                data,
                            }}
                        />
                    );
                },
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
                <Header title="Parking" subtitle="Managing to parking" />
                {/**
                <Box display="flex" justifyContent="space-between" alignItems="center" marginBottom="16px">
                    {/* <SelectedRole type={type} setType={setType} UserType={UserType} /> 
                    <Button
                        variant="contained"
                        color="secondary"
                        startIcon={<AddIcon />}
                        onClick={() => setCreateFormOpen(true)}
                    >
                        Create New Parking
                    </Button>
                    
                    <CreateParkingForm
                        isOpen={isCreateFormOpen}
                        handleClose={() => setCreateFormOpen(false)}
                        onCreateSuccess={handleCreateFormSuccess}
                    />
                </Box>
                 
                 */}
                

                {parkings.length > 0 ? (
                    <>
                        <DataGrid
                            columns={columns}
                            // rows={parkings}
                            rows={parkings.map((parking) => {
                                const selectedImageUrl =
                                    parking.parkingImages.length > 0 ? parking?.parkingImages[0]?.imageUrl : '';

                                return {
                                    id: parking.id,
                                    addressId: `ĐƯỜNG: ${parking.parkingAddress.street}\nPHƯỜNG: ${parking.parkingAddress.ward}\nQUẬN: ${parking.parkingAddress.district}\nTHÀNH PHỐ: ${parking.parkingAddress.city}\nKINH ĐỘ: ${parking.parkingAddress.longitude}\nVĨ ĐỘ: ${parking.parkingAddress.latitude}`,
                                    parkingImages: selectedImageUrl,
                                    price: parking.price,
                                    totalSlot: parking.totalSlot,
                                    status: parking.status,
                                    access: parking.access,
                                    latitude: parking.parkingAddress.latitude,
                                    district: parking.parkingAddress.district,
                                    longitude: parking.parkingAddress.longitude,
                                    city: parking.parkingAddress.city,
                                    ward: parking.parkingAddress.ward,
                                    street: parking.parkingAddress.street,
                                };
                            })}
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
                        {selectedParking && (
                            <StatusChangeDialog
                                open={statusDialogOpen}
                                onClose={handleStatusDialogClose}
                                selectedParking={selectedParking}
                                onStatusChange={handleStatusChange}
                                onUpdateStatus={handleUpdateStatus}
                            />
                        )}
                    </>
                ) : (
                    <h1>Data is not available.</h1>
                )}
            </Box>
        </Box>
    );
}

export default ManagerParking;
