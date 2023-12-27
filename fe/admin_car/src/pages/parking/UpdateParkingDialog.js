// UpdateParkingDialog.jsx
import React, { useEffect, useState } from 'react';
import { Dialog, DialogTitle, DialogContent, DialogActions, Button, TextField } from '@mui/material';
import { updateParkingDetails } from '~/utils';
import Swal from 'sweetalert2';
import { useFormik } from 'formik';
import * as Yup from 'yup';

function UpdateParkingDialog({ open, onClose, onConfirm, dataUpdate }) {
    // const [parkingDetails, setParkingDetails] = useState({});
    const [parkingDetails, setParkingDetails] = useState({});
    const [parkingList, setParkingList] = useState([]);

    const initialValues = {
        id: '',
        price: '',
        totalSlot: '',
        street: '',
        ward: '',
        district: '',
        city: '',
        latitude: '',
        longitude: '',
    };

    const validationSchema = Yup.object().shape({
        price: Yup.number()
            .required('Price is required')
            .min(1, 'Price must be at least 1')
            .max(500, 'Price must not exceed 500'),
        totalSlot: Yup.number()
            .required('Total Slot is required')
            .min(1, 'Total Slot must be at least 1')
            .max(30, 'Total Slot must not exceed 30'),
        street: Yup.string().required('Street is required').max(150, 'Street must not exceed 150 characters'),
        ward: Yup.string().required('Ward is required').max(150, 'Ward must not exceed 150 characters'),
        district: Yup.string().required('District is required').max(150, 'District must not exceed 150 characters'),
        city: Yup.string().required('City is required').max(150, 'City must not exceed 150 characters'),
        latitude: Yup.number().required('Latitude is required'),
        longitude: Yup.number().required('Longitude is required'),
    });

    useEffect(() => {
        setParkingDetails(dataUpdate);
        fetch();
    }, [dataUpdate]);

    // Hàm xử lý khi thay đổi giá trị của trường thông tin

    const handleChange = (e) => {
        const { name, value } = e.target;
        setParkingDetails((prevDetails) => ({
            ...prevDetails,
            [name]: value,
        }));
    };

    var fetch = () => {
        formik.setFieldValue('id', dataUpdate.id);
        formik.setFieldValue('price', dataUpdate.price);
        formik.setFieldValue('totalSlot', dataUpdate.totalSlot);
        formik.setFieldValue('street', dataUpdate.street);
        formik.setFieldValue('ward', dataUpdate.ward);
        formik.setFieldValue('district', dataUpdate.district);
        formik.setFieldValue('city', dataUpdate.city);
        formik.setFieldValue('latitude', dataUpdate.latitude);
        formik.setFieldValue('longitude', dataUpdate.longitude);
    };

    const formik = useFormik({
        initialValues: initialValues,
        validationSchema: validationSchema,
        onSubmit: async (values) => {
            const updatedValues = { ...values, id: parkingDetails.id };

            console.log(updatedValues);
            try {
                // Gọi API để cập nhật thông tin
                const result = await updateParkingDetails(updatedValues);

                console.log(result);

                if (result) {
                    if (JSON.stringify(result) !== JSON.stringify(parkingList)) {
                        // Rest of your success logic
                        Swal.fire({
                            icon: 'success',
                            title: 'Thành công!',
                            text: 'Hành động của bạn đã được thực hiện thành công.',
                            showConfirmButton: false,
                            timer: 2000,
                        });

                        setTimeout(() => {
                            window.location.reload();
                        }, 1000);
                    }
                }

                onConfirm();
            } catch (error) {
                // Xử lý lỗi nếu có
                console.error('Error updating parking details:', error);
                console.log(error);
            }
        },
    });

    return (
        <Dialog open={open} onClose={onClose}>
            <DialogTitle sx={{ textTransform: 'uppercase', textAlign: 'center' }}>Update Parking Details</DialogTitle>
            <DialogContent>
                <form onSubmit={formik.handleSubmit}>
                    <TextField
                        label="ID"
                        name="id"
                        value={formik.values.id || ''}
                        fullWidth
                        margin="normal"
                        InputProps={{
                            readOnly: true,
                        }}
                    />

                    <TextField
                        label="Price"
                        name="price"
                        type="number"
                        value={formik.values.price || ''}
                        onChange={formik.handleChange}
                        onBlur={formik.handleBlur}
                        error={formik.touched.price && Boolean(formik.errors.price)}
                        helperText={formik.touched.price && formik.errors.price}
                        fullWidth
                        margin="normal"
                    />
                    <TextField
                        label="Total Slot"
                        name="totalSlot"
                        type="number"
                        value={formik.values.totalSlot || ''}
                        onChange={formik.handleChange}
                        onBlur={formik.handleBlur}
                        error={formik.touched.totalSlot && Boolean(formik.errors.totalSlot)}
                        helperText={formik.touched.totalSlot && formik.errors.totalSlot}
                        fullWidth
                        margin="normal"
                    />

                    <TextField
                        label="Street"
                        name="street"
                        type="text"
                        value={formik.values.street || ''}
                        onChange={formik.handleChange}
                        onBlur={formik.handleBlur}
                        error={formik.touched.street && Boolean(formik.errors.street)}
                        helperText={formik.touched.street && formik.errors.street}
                        fullWidth
                        margin="normal"
                    />

                    <TextField
                        label="Ward"
                        name="ward"
                        value={formik.values.ward || ''}
                        onChange={formik.handleChange}
                        onBlur={formik.handleBlur}
                        error={formik.touched.ward && Boolean(formik.errors.ward)}
                        helperText={formik.touched.ward && formik.errors.ward}
                        fullWidth
                        margin="normal"
                    />

                    <TextField
                        label="District"
                        name="district"
                        value={formik.values.district || ''}
                        onChange={formik.handleChange}
                        onBlur={formik.handleBlur}
                        error={formik.touched.district && Boolean(formik.errors.district)}
                        helperText={formik.touched.district && formik.errors.district}
                        fullWidth
                        margin="normal"
                    />

                    <TextField
                        label="City"
                        name="city"
                        value={formik.values.city || ''}
                        onChange={formik.handleChange}
                        onBlur={formik.handleBlur}
                        error={formik.touched.city && Boolean(formik.errors.city)}
                        helperText={formik.touched.city && formik.errors.city}
                        fullWidth
                        margin="normal"
                    />

                    <TextField
                        label="Latitude"
                        name="latitude"
                        type="number"
                        value={formik.values.latitude || ''}
                        onChange={formik.handleChange}
                        onBlur={formik.handleBlur}
                        error={formik.touched.latitude && Boolean(formik.errors.latitude)}
                        helperText={formik.touched.latitude && formik.errors.latitude}
                        fullWidth
                        margin="normal"
                    />

                    <TextField
                        label="Longitude"
                        name="longitude"
                        type="number"
                        value={formik.values.longitude || ''}
                        onChange={formik.handleChange}
                        onBlur={formik.handleBlur}
                        error={formik.touched.longitude && Boolean(formik.errors.longitude)}
                        helperText={formik.touched.longitude && formik.errors.longitude}
                        fullWidth
                        margin="normal"
                    />
                </form>
            </DialogContent>
            <DialogActions>
                <Button onClick={onClose}>Cancel</Button>
                <Button onClick={formik.handleSubmit}>Update</Button>
            </DialogActions>
        </Dialog>
    );
}

export default UpdateParkingDialog;
