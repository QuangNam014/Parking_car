import React, { useState } from 'react';
import {
    Dialog,
    DialogTitle,
    DialogContent,
    TextField,
    Button,
    Box,
    Select,
    MenuItem,
    InputLabel,
    FormControl,
    Input,
    Typography,
    IconButton,
    FormGroup,
} from '@mui/material';

import AddIcon from '@mui/icons-material/AddAPhoto';
import { createParkingDetails, uploadFile } from '~/utils';
import { toast } from 'react-toastify';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import Swal from 'sweetalert2';
import * as Yup from 'yup';
import { Form, Formik, useFormik } from 'formik';
import { FormCheck } from 'react-bootstrap';

const CreateParkingForm = ({ isOpen, handleClose, onCreateSuccess }) => {
    const schema = Yup.object().shape({
        price: Yup.number()
            .required('Price is required')
            .min(1, 'Price must be at least 1')
            .max(500, 'Price must not exceed 500'),
        totalSlot: Yup.number()
            .required('Total Slot is required')
            .min(1, 'Total Slot must be at least 1')
            .max(30, 'Total Slot must not exceed 30'),
        parkingAddress: Yup.string().required('Parking Address is required'),
        city: Yup.string().required('City is required').max(150, 'City must not exceed 150 characters'),
        longitude: Yup.number().required('Longitude is required'),
        latitude: Yup.number().required('Latitude is required'),
        ward: Yup.string().required('Ward is required').max(150, 'Ward must not exceed 150 characters'),
        district: Yup.string().required('District is required').max(150, 'District must not exceed 150 characters'),
        street: Yup.string().required('Street is required').max(150, 'Street must not exceed 150 characters'),
        listImage: Yup.array().min(1, 'Please upload at least one image'),
    });

    const formik = useFormik({
        initialValues: {
            price: '',
            totalSlot: '',
            parkingAddress: '',
            city: '',
            longitude: '',
            latitude: '',
            ward: '',
            district: '',
            street: '',
            listImage: [],
        },

        onSubmit: async (values) => {
            // Handle form submission
            try {
                const file = values.listImage[0];

                const getDataFile = await uploadFile(file);
                console.log(getDataFile);

                if (getDataFile.status === 200) {
                    const updatedFormData = {
                        ...values,
                        listImage: [
                            {
                                ...getDataFile.data,
                            },
                        ],
                    };

                    const response = await createParkingDetails(updatedFormData);

                    if (response.status === 201) {
                        // Bãi đỗ xe đã được tạo thành công
                        Swal.fire({
                            position: 'top-end',
                            icon: 'success',
                            title: 'Hoàn tất',
                            text: 'Công việc của bạn đã được lưu lại thành công.',
                            showConfirmButton: false,
                            timer: 1500,
                        });

                        onCreateSuccess();
                        handleClose();
                    } else {
                        // Xử lý trường hợp lỗi khi gọi API
                        Swal.fire({
                            icon: 'error',
                            title: 'Rất tiếc...',
                            text: 'Có lỗi xảy ra!',
                            footer: '<a href="#">Tại sao tôi lại gặp vấn đề này?</a>',
                        });
                        console.error('Failed to create parking:', response);
                        toast.error('Failed to create parking. Please try again.');
                    }
                }
            } catch (error) {
                console.error('Error creating parking:', error);
                toast.error('An error occurred. Please try again later.');
            }
        },
    });

    const handleSubmit = async (values, { setSubmitting }) => {
        try {
            const file = formData.listImage[0];
            const getDataFile = await uploadFile(file);
            console.log(getDataFile);
            if (getDataFile.status === 200) {
                const updatedFormData = {
                    ...formData,
                    listImage: [
                        {
                            ...getDataFile.data,
                        },
                    ],
                    price: values.price,
                    totalSlot: values.totalSlot,
                    parkingAddress: values.parkingAddress,
                    city: values.city,
                    longitude: values.longitude,
                    latitude: values.latitude,
                    ward: values.ward,
                    district: values.district,
                    street: values.street,
                };
                console.log(updatedFormData);
                const response = await createParkingDetails(updatedFormData);

                if (response.status === 201) {
                    console.log(response);
                    // Bãi đỗ xe đã được tạo thành công
                    Swal.fire({
                        position: 'top-end',
                        icon: 'success',
                        title: 'Hoàn tất',
                        text: 'Công việc của bạn đã được lưu lại thành công.',
                        showConfirmButton: false,
                        timer: 1500,
                    });

                    onCreateSuccess();
                    handleClose();
                } else {
                    // Xử lý trường hợp lỗi khi gọi API
                    Swal.fire({
                        icon: 'error',
                        title: 'Rất tiếc...',
                        text: 'Có lỗi xảy ra!',
                        footer: '<a href="#">Tại sao tôi lại gặp vấn đề này?</a>',
                    });
                    console.error('Failed to create parking:', response);
                    toast.error('Failed to create parking. Please try again.');
                }
            }
        } catch (error) {
            console.error('Error creating parking:', error);
            toast.error('An error occurred. Please try again later.');
        } finally {
            console.log('finally');
        }
    };

    const [formData, setFormData] = useState({
        price: '',
        totalSlot: '',
        parkingAddress: '',
        city: '',
        longitude: '',
        latitude: '',
        ward: '',
        district: '',
        street: '',
        listImage: [],
    });

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData((prevData) => ({
            ...prevData,
            [name]: value,
        }));
    };

    const handleTotalSlotChange = (e) => {
        setFormData((prevData) => ({
            ...prevData,
            totalSlot: e.target.value,
        }));
    };

    const handleListImageChange = async (e, setFieldValue) => {
        const fileList = e.target.files;
        const images = Array.from(fileList).map((file) => ({
            name: file.name,
            file: file,
            url: URL.createObjectURL(file),
        }));

        setFormData((prevData) => ({
            ...prevData,
            listImage: images,
        }));
        await setFieldValue('listImage', images);
    };

    // const handleSubmit = async () => {
    //     try {
    //         const file = formData.listImage[0];

    //         const getDataFile = await uploadFile(file);
    //         console.log(getDataFile);
    //         if (getDataFile.status === 200) {
    //             const updatedFormData = {
    //                 ...formData,
    //                 listImage: [
    //                     {
    //                         ...getDataFile.data,
    //                     },
    //                 ],
    //             };

    //             const response = await createParkingDetails(updatedFormData);

    //             if (response.status === 201) {
    //                 // Bãi đỗ xe đã được tạo thành công
    //                 Swal.fire({
    //                     position: 'top-end',
    //                     icon: 'success',
    //                     title: 'Hoàn tất',
    //                     text: 'Công việc của bạn đã được lưu lại thành công.',
    //                     showConfirmButton: false,
    //                     timer: 1500,
    //                 });

    //                 onCreateSuccess();
    //                 handleClose();
    //             } else {
    //                 // Xử lý trường hợp lỗi khi gọi API
    //                 Swal.fire({
    //                     icon: 'error',
    //                     title: 'Rất tiếc...',
    //                     text: 'Có lỗi xảy ra!',
    //                     footer: '<a href="#">Tại sao tôi lại gặp vấn đề này?</a>',
    //                 });
    //                 console.error('Failed to create parking:', response);
    //                 toast.error('Failed to create parking. Please try again.');
    //             }
    //         }
    //     } catch (error) {
    //         console.error('Error creating parking:', error);
    //         toast.error('An error occurred. Please try again later.');
    //     }
    // };

    return (
        <Dialog open={isOpen} onClose={handleClose}>
            <DialogTitle
                sx={{
                    textAlign: 'center',
                    textTransform: 'uppercase',
                    fontSize: '2rem',
                    color: 'green',
                }}
            >
                CREATE NEW PARKING
            </DialogTitle>
            <DialogContent>
                <Formik
                    validationSchema={schema}
                    onSubmit={handleSubmit}
                    initialValues={{
                        price: '',
                        totalSlot: '',
                        parkingAddress: '',
                        city: '',
                        longitude: '',
                        latitude: '',
                        ward: '',
                        district: '',
                        street: '',
                        listImage: [],
                    }}
                >
                    {({ handleSubmit, handleChange, values, touched, errors, setFieldValue }) => (
                        <Form>
                            <TextField
                                label="Price"
                                name="price"
                                value={values.price}
                                onChange={handleChange}
                                error={touched.price && Boolean(errors.price)}
                                helperText={errors.price}
                                fullWidth
                                margin="normal"
                            />

                            <TextField
                                label="TotalSlot"
                                name="totalSlot"
                                value={values.totalSlot}
                                onChange={handleChange}
                                error={touched.totalSlot && Boolean(errors.totalSlot)}
                                helperText={errors.totalSlot}
                                fullWidth
                                margin="normal"
                            ></TextField>
                            <TextField
                                label="ParkingAddress"
                                name="parkingAddress"
                                value={values.parkingAddress}
                                onChange={handleChange}
                                error={touched.parkingAddress && Boolean(errors.parkingAddress)}
                                helperText={errors.parkingAddress}
                                fullWidth
                                margin="normal"
                            ></TextField>
                            <TextField
                                label="City"
                                name="city"
                                value={values.city}
                                onChange={handleChange}
                                error={touched.city && Boolean(errors.city)}
                                helperText={errors.city}
                                fullWidth
                                margin="normal"
                            ></TextField>

                            <TextField
                                label="Longitude"
                                name="longitude"
                                value={values.longitude}
                                onChange={handleChange}
                                error={touched.longitude && Boolean(errors.longitude)}
                                helperText={errors.longitude}
                                fullWidth
                                margin="normal"
                            ></TextField>
                            <TextField
                                label="Latitude"
                                name="latitude"
                                value={values.latitude}
                                onChange={handleChange}
                                error={touched.latitude && Boolean(errors.latitude)}
                                helperText={errors.latitude}
                                fullWidth
                                margin="normal"
                            ></TextField>

                            <TextField
                                label="Ward"
                                name="ward"
                                value={values.ward}
                                onChange={handleChange}
                                error={touched.ward && Boolean(errors.ward)}
                                helperText={errors.ward}
                                fullWidth
                                margin="normal"
                            ></TextField>
                            <TextField
                                label="District"
                                name="district"
                                value={values.district}
                                onChange={handleChange}
                                error={touched.district && Boolean(errors.district)}
                                helperText={errors.district}
                                fullWidth
                                margin="normal"
                            ></TextField>
                            <TextField
                                label="Street"
                                name="street"
                                value={values.street}
                                onChange={handleChange}
                                error={touched.street && Boolean(errors.street)}
                                helperText={errors.street}
                                fullWidth
                                margin="normal"
                            ></TextField>

                            <FormControl fullWidth margin="normal">
                                <Typography variant="subtitle1" gutterBottom></Typography>
                                <Input
                                    type="file"
                                    name="listImage"
                                    multiple
                                    accept="image/*"
                                    onChange={(e) => handleListImageChange(e, setFieldValue)}
                                    style={{ display: 'none' }}
                                    id="upload-input"
                                />
                                <br />
                                <br />
                                <span style={{ color: 'red' }} fullWidth margin="normal">
                                    {errors.listImage}
                                </span>
                                <label htmlFor="upload-input">
                                    <Button variant="outlined" component="span" startIcon={<AddIcon />}>
                                        Choose Images
                                    </Button>
                                </label>
                                {formData.listImage.map((image, index) => (
                                    <div key={index}>
                                        <Typography>{image.name}</Typography>
                                        <img
                                            src={image.url}
                                            alt={image.name}
                                            style={{ maxWidth: '100%', maxHeight: '100px', margin: '10px 0' }}
                                        />
                                    </div>
                                ))}
                            </FormControl>

                            <Box marginTop={2}>
                                <Button
                                    variant="contained"
                                    type="submit"
                                    color="primary"
                                    // onClick={formik.handleSubmit}
                                    sx={{
                                        color: 'white', // Màu chữ
                                        backgroundColor: 'green', // Màu nền
                                        '&:hover': {
                                            backgroundColor: 'darkgreen', // Màu nền khi hover
                                        },
                                    }}
                                >
                                    Create Parking
                                </Button>
                            </Box>
                        </Form>
                    )}
                </Formik>
            </DialogContent>
        </Dialog>
    );
};

export default CreateParkingForm;
