import { Dialog, DialogTitle, DialogContent, DialogActions, Button, TextField } from '@mui/material';
import { useEffect, useState } from 'react';
import Swal from 'sweetalert2';
import { editByAdmin } from '~/utils';

function EditAdmin({ open, onClose, userData }) {
    const [editedUserData, setEditedUserData] = useState(userData);

    //test
    const [validationErrors, setValidationErrors] = useState({
        email: '', // Trạng thái lưu thông tin lỗi của trường email
        // Các trường khác nếu cần
    });

    const handleInputChange = (field, value) => {
        if (field === 'phone') {
            // Kiểm tra nếu giá trị không phải là số thì không thay đổi giá trị
            if (!/^\d*$/.test(value)) {
                return;
            }
        }

        setEditedUserData((prevData) => ({
            ...prevData,
            [field]: value,
        }));

        // Thực hiện validate ngay khi người dùng nhập
        validateField(field, value);
    };

    const validateField = (field, value) => {
        let error = '';

        switch (field) {
            case 'fullname':
                // Kiểm tra trường Full Name
                if (value.length > 25) {
                    error = 'Tên không được dài quá 25 ký tự.';
                }
                break;
            case 'email':
                // Kiểm tra trường Email
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(value)) {
                    error = 'Định dạng email không hợp lệ.';
                }
                break;
            case 'phone':
                // Kiểm tra trường Phone
                if (isNaN(value) || value.length !== 10) {
                    error = 'Số điện thoại phải là số và có độ dài là 10.';
                }
                break;
            // Các trường khác nếu cần
            default:
                break;
        }

        // Cập nhật trạng thái lỗi của trường
        setValidationErrors((prevErrors) => ({
            ...prevErrors,
            [field]: error,
        }));
    };

    // end test

    const handleSave = async () => {
        // Kiểm tra dữ liệu trước khi lưu
        if (!validateData(editedUserData)) {
            Swal.close();
            return;
        }

        const data = {
            id: editedUserData.id,
            fullname: editedUserData.fullname,
            email: editedUserData.email,
            phone: editedUserData.phone,
        };
        try {
            // Gọi API để cập nhật thông tin
            const result = await editByAdmin(data);
            console.log(result);

            if (result) {
                if (result.status === 200) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công!',
                        text: 'Hành động của bạn đã được thực hiện thành công.',
                        showConfirmButton: false,
                        timer: 2000,
                    });
                }
            }
            onClose();
        } catch (error) {
            // Xử lý lỗi nếu có
            console.error('Error updating parking details:', error);
            console.log(error);
        }
    };

    const validateData = (data) => {
        // Kiểm tra tất cả các trường và hiển thị cảnh báo nếu có lỗi
        for (const field in data) {
            validateField(field, data[field]);
        }

        // Kiểm tra xem có lỗi nào không
        for (const field in validationErrors) {
            if (validationErrors[field] !== '') {
                // Hiển thị cảnh báo lỗi tại đây nếu cần
                return false;
            }
        }

        // Nếu không có lỗi nào được phát hiện
        return true;
    };

    useEffect(() => {
        // Cập nhật giá trị của userData khi có sự thay đổi
        setEditedUserData(userData);
    }, [userData]);

    return (
        <Dialog open={open} onClose={onClose} maxWidth="xs" fullWidth>
            <DialogTitle sx={{ textAlign: 'center', textTransform: 'uppercase' }}>Edit User</DialogTitle>
            <DialogContent>
                <TextField
                    label="ID"
                    value={editedUserData.id}
                    fullWidth
                    margin="normal"
                    InputProps={{ readOnly: true }}
                    onChange={(e) => handleInputChange('id', e.target.value)}
                />
                <TextField
                    label="Full Name"
                    value={editedUserData.fullname}
                    fullWidth
                    margin="normal"
                    onChange={(e) => handleInputChange('fullname', e.target.value)}
                />
                <TextField
                    label="Email"
                    value={editedUserData.email}
                    fullWidth
                    margin="normal"
                    onChange={(e) => handleInputChange('email', e.target.value)}
                    error={validationErrors.email !== ''}
                    helperText={validationErrors.email}
                />
                <TextField
                    label="Phone"
                    value={editedUserData.phone}
                    fullWidth
                    margin="normal"
                    onChange={(e) => handleInputChange('phone', e.target.value)}
                />
            </DialogContent>
            <DialogActions>
                <Button onClick={onClose} sx={{ color: 'red', borderColor: 'red' }}>
                    Cancel
                </Button>
                <Button
                    onClick={handleSave}
                    sx={{ backgroundColor: 'green', color: 'white', '&:hover': { backgroundColor: 'darkgreen' } }}
                >
                    Save
                </Button>
            </DialogActions>
        </Dialog>
    );
}

export default EditAdmin;
