import axios from 'axios';
import { getToken } from '~/configs/axiosToken';

// const domain = 'http://localhost:8080/';
const domain = 'https://e9a8-14-241-234-154.ngrok-free.app/';

// user details
export const getUserDetails = async () => {
    const data = await axios.get(`${domain}api/v1/user-infor-detail`, getToken());
    return data.data;
};

//login
export const LoginModel = async (email, password) => {
    const data = await axios.post(`${domain}auth/login`, { email, password });
    return data.data;
};

// forgot password

export const checkEmailExistence = async (email) => {
    const data = await axios.get(`${domain}auth/check-email/${email}`);
    // console.log(data);
    return data.data;
};

export const sendEmailToken = async (email) => {
    const data = await axios.post(`${domain}auth/send-token`, email);
    // console.log(data);
    return data.data;
};

export const verifiedToken = async (email, otp) => {
    const data = await axios.get(`${domain}auth/send/verified-token/${email}&${otp}`);
    // console.log(data);
    return data.data;
};

export const changePassword = async (email, password, confirmPassword) => {
    const data = await axios.post(`${domain}auth/forget-password/change-password`, {
        email,
        password,
        confirmPassword,
    });
    // console.log(data);
    return data.data;
};

// user
export const getListAdmin = async () => {
    const data = await axios.get(`${domain}api/v1/user/list`, getToken());
    return data.data;
};

export const editByAdmin = async (data1) => {
    const data = await axios.post(`${domain}api/v1/edit/admin`, data1, getToken());
    return data.data;
};

// parking
export const getAllParkingDetails = async () => {
    const data = await axios.get(`${domain}api/v1/supplier/get-all`, getToken());
    return data.data;
};

export const uploadFile = async (file) => {
    let data2 = new FormData();
    data2.append('file', file.file); // Use the file object

    const token = localStorage.getItem('token');

    const data = await axios.post(`${domain}api/v1/upload/file`, data2, {
        headers: {
            Authorization: `Bearer ${token}`,
            'Content-Type': 'multipart/form-data',
        },
    });
    return data.data;
};

export const createParkingDetails = async (newParkingData) => {
    const data = await axios.post(`${domain}api/v1/supplier/create-detail`, newParkingData, getToken());
    return data.data;
};

export const deleteParkingDetails = async (id) => {
    const data = await axios.delete(`${domain}api/v1/supplier/delete-detail/${id}`, getToken());
    return data.data;
};

export const updateParkingDetails = async (parkingDetails) => {
    const parkingList = JSON.parse(localStorage.getItem('parkingList'));
    const foundParking = parkingList.find((parking) => parking.id === Number(parkingDetails.id));

    const data = await axios.put(
        `${domain}api/v1/supplier/update-detail`,
        {
            id: parkingDetails.id + '',
            price: parkingDetails.price + '',
            totalSlot: parkingDetails.totalSlot + '',
            city: parkingDetails.city,
            district: parkingDetails.district,
            ward: parkingDetails.ward,
            street: parkingDetails.street,
            longitude: parkingDetails.longitude,
            latitude: parkingDetails.latitude,
        },
        getToken(),
    );
    console.log(data);
    return data.data;
};

export const updateStatus = async (statusObj) => {
    const data = await axios.post(`${domain}api/v1/supplier/update-status`, statusObj, getToken());
    console.log(data);
    return data.data;
};

// customer
export const getListCustomerInfo = async () => {
    const data = await axios.get(`${domain}api/v1/customer/list`, getToken());
    console.log(data);
    return data.data;
};

export const searchCustomerByCCCD = async (userDocument) => {
    const data = await axios.get(`${domain}api/v1/customer/admin/${userDocument}`, getToken());
    console.log(data);
    return data.data;
};

// registered parking
export const getListRegisteredParking = async () => {
    const data = await axios.get(`${domain}api/v1/customer/get-list-registered-parking`, getToken());
    return data.data;
};

export const customerUpdateStatusOrder = async (statusObj) => {
    const data = await axios.post(`${domain}api/v1/customer/customer-update-status-order`, statusObj, getToken());
    console.log(data);
    return data.data;
};

export const getListRegisteredParkingByCustomerId = async (id) => {
    const data = await axios.get(`${domain}api/v1/customer/get-list-registered-parking/${id}`, getToken());
    return data.data;
};

// transaction
export const getListTransaction = async () => {
    const data = await axios.get(`${domain}api/v1/transaction/list`, getToken());
    return data.data;
};
