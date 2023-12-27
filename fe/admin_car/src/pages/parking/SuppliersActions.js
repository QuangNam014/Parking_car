/* eslint-disable react-hooks/exhaustive-deps */
import { Check, Save } from '@mui/icons-material';
import { Box, CircularProgress, Fab } from '@mui/material';
import React from 'react';
import { useEffect } from 'react';
import { useState } from 'react';

import DeleteIcon from '@mui/icons-material/DeleteOutlined';
import Swal from 'sweetalert2';
import { deleteParkingDetails } from '~/utils';
import UpdateParkingDialog from './UpdateParkingDialog';
import LiveHelpIcon from '@mui/icons-material/LiveHelp';

import EditIcon from '@mui/icons-material/Edit';
import ShowDetails from './ShowDetails';

function SuppliersActions({ params, rowId, setRowId, colors, updateParkings, handleModal, data }) {
    const [loading, setLoading] = useState(false);
    const [success, setSuccess] = useState(false);
    const [openUpdateDialog, setOpenUpdateDialog] = useState(false);
    const [dataUpdate, setDataUpdate] = useState({});
    const [showDetailsOpen, setShowDetailsOpen] = useState(false);

    // details
    const handleShowDetails = () => {
        setShowDetailsOpen(true);
    };

    const handleCloseDetails = () => {
        setShowDetailsOpen(false);
    };

    const handleSubmit = async () => {
        setLoading(true);

        // console.log(params);
        setTimeout(async () => {
            // CALL api
            const result = true;
            console.log(result);
            if (result) {
                // console.log('thanh cong: ', params.row);
                setSuccess(true);
                setRowId(null);
            }
            setLoading(false);
        }, 1500);
    };

    const handleUpdate = () => {
        console.log(data);
        // Mở Popup Dialog khi nhấn vào nút Update
        setOpenUpdateDialog(true);
        handleModal();
        setDataUpdate(data);
    };

    const handleUpdateConfirm = () => {
        // console.log('updatedDetails');
        setOpenUpdateDialog(false);
        handleModal();
    };

    // delete
    const handleDelete = async () => {
        if (params.row.status !== 'RENTING') {
            try {
                const result = true;

                if (result) {
                    Swal.fire({
                        title: 'Bạn có chắc chắn?',
                        text: 'Bạn sẽ không thể hoàn nguyên điều này!',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Có, xóa nó!',
                        cancelButtonText: 'Hủy bỏ',
                    }).then(async (result) => {
                        if (result.isConfirmed) {
                            // Gọi API xóa ngay sau khi xác nhận xóa
                            try {
                                await deleteParkingDetails(params.row.id);
                                Swal.fire('Đã xóa!', 'Tệp của bạn đã bị xóa.', 'success');
                                if (updateParkings) {
                                    updateParkings((prevParkings) =>
                                        prevParkings.filter((parking) => parking.id !== params.row.id),
                                    );
                                }
                            } catch (error) {
                                console.error('Lỗi khi xóa chi tiết bãi đỗ xe:', error);
                                // Xử lý lỗi nếu cần (ví dụ: hiển thị thông báo lỗi cho người dùng)
                            }
                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            Swal.fire('Đã hủy bỏ', 'Hành động xóa đã bị hủy bỏ.', 'info');
                        }
                    });
                }
            } catch (error) {
                console.error('Lỗi khi xóa chi tiết bãi đỗ xe:', error);
                // Xử lý lỗi nếu cần (ví dụ: hiển thị thông báo lỗi cho người dùng)
            }
        } else {
            console.log('Không thể xóa khi trạng thái không phải là PENDING');
        }
    };

    useEffect(() => {
        if (rowId === params.id && success) setSuccess(false);
    }, [rowId]);

    return (
        <Box display="flex">
            {/* Show details */}

            <Box
                sx={{
                    m: 1,
                    position: 'relative',
                }}
            >
                <Fab
                    sx={{
                        width: 40,
                        height: 40,
                        marginRight: '3px',
                        color: colors.primary[500],
                        backgroundColor: colors.blueAccent[300],
                        '&:hover': { backgroundColor: colors.blueAccent[700] },
                    }}
                    // disable={params.row.status !== 'PENDING'}
                    onClick={() => {
                        if (params.row.status === 'PENDING') {
                            setShowDetailsOpen(true);
                        }
                    }}
                    disabled={params.row.status !== 'PENDING'}
                >
                    <LiveHelpIcon />
                </Fab>

                <ShowDetails
                    open={showDetailsOpen}
                    handleClose={() => {
                        setShowDetailsOpen(false);
                        handleModal();
                    }}
                    details={params.row}
                />
            </Box>

            {/*Update */}
            <Box
                sx={{
                    m: 1,
                    position: 'relative',
                }}
            >
                <Fab
                    sx={{
                        width: 40,
                        height: 40,
                        marginRight: '3px',
                        color: colors.primary[500],
                        backgroundColor: colors.blueAccent[300],
                        '&:hover': { backgroundColor: colors.blueAccent[700] },
                    }}
                    onClick={handleUpdate}
                >
                    <EditIcon />
                </Fab>
            </Box>
            <UpdateParkingDialog
                open={openUpdateDialog}
                onClose={() => {
                    setOpenUpdateDialog(false);
                    handleModal();
                }}
                onConfirm={handleUpdateConfirm}
                dataUpdate={dataUpdate}
            />

            {/* Delete */}
            <Box
                sx={{
                    m: 1,
                    position: 'relative',
                }}
            >
                <Fab
                    sx={{
                        width: 40,
                        height: 40,
                        marginRight: '3px',
                        color: colors.primary[500],
                        backgroundColor: colors.redAccent[300],
                        '&:hover': { backgroundColor: colors.redAccent[700] },
                    }}
                    onClick={handleDelete}
                    disabled={params.row.status === 'RENTING'}
                >
                    <DeleteIcon />
                </Fab>
            </Box>
        </Box>
    );
}

export default SuppliersActions;
