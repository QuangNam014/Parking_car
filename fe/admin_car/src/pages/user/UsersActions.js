/* eslint-disable react-hooks/exhaustive-deps */
import { Check, Save } from '@mui/icons-material';
import { Box, CircularProgress, Fab } from '@mui/material';
import React from 'react';
import { useEffect } from 'react';
import { useState } from 'react';

import DeleteIcon from '@mui/icons-material/DeleteOutlined';

import Swal from 'sweetalert2';
import EditAdmin from './EditAdmin';
import EditNote from '@mui/icons-material/EditNote';
import PersonOffIcon from '@mui/icons-material/PersonOff';
import theme from '~/theme';

function UsersActions({ params, rowId, setRowId, colors, handleModal }) {
    const [loading, setLoading] = useState(false);
    const [success, setSuccess] = useState(false);

    const [isEditOpen, setIsEditOpen] = useState(false);

    useEffect(() => {
        console.log(isEditOpen);
    }, [isEditOpen]);

    const handleEdit = () => {
        setIsEditOpen(true);
        handleModal();
    };

    const isEditDisabled = params.row.role !== 'ADMIN';

    const handleSubmit = async () => {
        setLoading(true);

        console.log(params);
        setTimeout(async () => {
            // CALL api
            const result = true;
            if (result) {
                console.log('thanh cong: ', params.row);
                setSuccess(true);
                setRowId(null);
            }
            setLoading(false);
        }, 1500);
        handleModal();
    };

    const handleDelete = async () => {
        console.log(params.row);

        const result = true;
        if (result) {
            // call API
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!',
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire('Deleted!', 'Your file has been deleted.', 'success');
                }
            });
        }
    };

    useEffect(() => {
        if (rowId === params.id && success) setSuccess(false);
    }, [rowId]);
    return (
        <Box display="flex">
            {/* Edit */}
            <Box
                sx={{
                    m: 1,
                    position: 'relative',
                }}
            >
                {success ? (
                    <Fab
                        sx={{
                            width: 40,
                            height: 40,
                            color: colors.primary[500],
                            backgroundColor: colors.greenAccent[400],
                            '&:hover': { backgroundColor: colors.greenAccent[700] },
                        }}
                        disabled={params.id !== rowId || loading}
                    >
                        <Check />
                    </Fab>
                ) : (
                    <Fab
                        sx={{
                            width: 40,
                            height: 40,
                            backgroundColor: colors.blueAccent[400],
                            '&:hover': { backgroundColor: colors.blueAccent[700] },
                        }}
                        disabled={params.id !== rowId || loading}
                        onClick={handleSubmit}
                    >
                        <Save />
                    </Fab>
                )}
                {loading && (
                    <CircularProgress
                        size={52}
                        sx={{
                            color: colors.greenAccent[500],
                            position: 'absolute',
                            top: -6,
                            left: -6,
                            zIndex: 1,
                        }}
                    />
                )}
            </Box>

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
                        backgroundColor: '#FF4081', // Mã màu hồng (VD: Hex Color)
                        '&:hover': { backgroundColor: '#F50057' }, // Mã màu hồng khi di chuột qua
                    }}
                    // disabled={params.id !== rowId || loading}
                    onClick={handleEdit}
                >
                    <EditNote />
                </Fab>
            </Box>

            {/* Other actions... */}

            {/* Edit User Popup */}
            <EditAdmin
                open={isEditOpen}
                onClose={() => {
                    setIsEditOpen(false);
                    handleModal();
                }}
                userData={params.row}
            />

            {/* Disable */}

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
                        backgroundColor: '#FFD700', // Mã màu vàng (VD: Hex Color)
                        '&:hover': { backgroundColor: '#FFA500' }, // Mã màu vàng khi di chuột qua
                    }}
                    // disabled={params.id !== rowId || loading}
                    // onClick={handleEdit}
                >
                    <PersonOffIcon />
                </Fab>
            </Box>

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
                    disabled={params.id !== rowId || loading}
                    onClick={handleDelete}
                >
                    <DeleteIcon />
                </Fab>
            </Box>
        </Box>
    );
}

export default UsersActions;
