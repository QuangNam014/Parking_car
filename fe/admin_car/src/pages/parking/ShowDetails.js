// DetailsDialog.js
import React, { useEffect, useState } from 'react';
import { Box, Button, Dialog, DialogActions, DialogContent, DialogTitle, Typography } from '@mui/material';
import { updateStatus } from '~/utils';
import Swal from 'sweetalert2';

const DetailsDialog = ({ open, handleClose, details }) => {
    // chua xu ly khi approve vơi trang thai pending, nếu approve chuyển sang available.
    const [apiCallStatus, setApiCallStatus] = useState(null);

    // const handleApprove = async () => {
    //     try {
    //         if (details.status === 'PENDING') {
    //             const { id, status } = details;
    //             const updatedStatusDetails = { id, status: 'AVAILABLE' };
    //             const response = await updateStatus(updatedStatusDetails);

    //             if (response.status === 200) {
    //                 console.log('API call successfull!');
    //                 console.log('Server response:', response.data);
    //                 setApiCallStatus('success');
    //             } else {
    //                 console.error('API call failed with status: ', response);
    //                 setApiCallStatus('error');
    //             }
    //         }
    //     } catch (error) {
    //         console.log('Error approving: ', error);
    //         setApiCallStatus('error');
    //     }
    // };

    const handleApprove = async () => {
        try {
            if (details.status === 'PENDING') {
                const result = await Swal.fire({
                    title: 'Bạn có chắc chắn là những thông tin trên đã được kiểm duyệt kỹ càng?',
                    text: 'Bạn sẽ không thể quay lại điều này!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Confirm',
                    cancelButtonText: 'Cancel',
                    customClass: {
                        container: 'custom-swal-container',
                        popup: 'custom-swal-popup',
                        header: 'custom-swal-header',
                        title: 'custom-swal-title',
                        closeButton: 'custom-swal-closeButton',
                        icon: 'custom-swal-icon',
                        content: 'custom-swal-content',
                        input: 'custom-swal-input',
                        actions: 'custom-swal-actions',
                        confirmButton: 'custom-swal-confirmButton',
                        cancelButton: 'custom-swal-cancelButton',
                        footer: 'custom-swal-footer',
                    },
                }).then(async (result) => {
                    if (result.isConfirmed) {
                        const { id, status } = details;
                        const updatedStatusDetails = { id, status: 'AVAILABLE' };
                        const response = await updateStatus(updatedStatusDetails);

                        if (response.status === 200) {
                            console.log('API call successful!');
                            console.log('Server response:', response.data);
                            Swal.fire('Công việc của bạn đã hoàn tất.', 'Thành công');
                            setApiCallStatus('success');
                        } else {
                            console.error('API call failed with status: ', response);
                            setApiCallStatus('error');
                        }
                    } else {
                        handleClose();
                    }
                });
            }
        } catch (error) {
            console.log('Error approving: ', error);
            setApiCallStatus('error');
        }
    };

    useEffect(() => {
        if (apiCallStatus === 'success') {
            // Cập nhật thông tin mới (nếu cần)
            // setNewData(newData);

            // Buộc render lại component
            handleClose();
        }
    }, [apiCallStatus, handleClose]);

    return (
        <Dialog
            open={open}
            onClose={handleClose}
            fullWidth
            maxWidth="md"
            sx={{
                '& .MuiDialog-paper': {
                    borderRadius: '8px',
                },
            }}
        >
            <style>
                {`
        
        .custom-swal-container{
            z-index: 9999
        }
        `}
            </style>

            <DialogTitle style={{ textTransform: 'uppercase', textAlign: 'center' }}>Thông tin chi tiết</DialogTitle>
            <DialogContent>
                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>ID:</Typography>
                    <Typography>{details.id}</Typography>
                </Box>

                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>STREET:</Typography>
                    <Typography>{details.street}</Typography>
                </Box>
                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>WARD:</Typography>
                    <Typography>{details.ward}</Typography>
                </Box>
                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>DISTRICT:</Typography>
                    <Typography>{details.district}</Typography>
                </Box>
                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>CITY:</Typography>
                    <Typography>{details.city}</Typography>
                </Box>

                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>PRICE:</Typography>
                    <Typography>{details.price}</Typography>
                </Box>
                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>TOTAL SLOT:</Typography>
                    <Typography>{details.totalSlot}</Typography>
                </Box>
                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>STATUS:</Typography>
                    <Typography>{details.status}</Typography>
                </Box>
                <Box>
                    <Typography sx={{ fontWeight: 'bold', color: 'black' }}>IMAGE:</Typography>
                    <img
                        src={details.parkingImages}
                        alt="Parking Image"
                        style={{ maxWidth: '100%', maxHeight: '200px' }}
                    />
                </Box>
            </DialogContent>
            <DialogActions>
                <Button onClick={handleClose} color="secondary">
                    Cancel
                </Button>
                <Button onClick={handleApprove} color="primary">
                    Approve
                </Button>
            </DialogActions>
        </Dialog>
    );
};

export default DetailsDialog;
