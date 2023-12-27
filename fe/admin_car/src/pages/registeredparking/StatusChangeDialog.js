import { useState } from 'react';
import Swal from 'sweetalert2';
import { customerUpdateStatusOrder, updateStatus } from '~/utils';

const { Dialog, DialogTitle, List, ListItem, ListItemText, DialogActions, Button } = require('@mui/material');

// StatusChangeDialog component for selecting status
function StatusChangeDialog(props) {
    const { open, onClose, selectedRegisteredParking, onStatusChange, onUpdateStatus } = props;

    const statusOptions = ['SUCCESS', 'CANCEL', 'PENDING'];

    const [selectedStatusIndex, setSelectedStatusIndex] = useState(null);
    const [apiError, setApiError] = useState(null);
    const [apiLoading, setApiLoading] = useState(false);

    const handleStatusChange = (index) => {
        setSelectedStatusIndex(index);
    };

    const handleUpdateStatus = async () => {
        const selectedStatus = statusOptions[selectedStatusIndex]; // co value

        const registeredParking = selectedRegisteredParking.id; // lay ra id cua object
        console.log(registeredParking);

        const statusObj = {
            id: registeredParking,
            status: selectedStatus,
        };

        try {
            // Gọi API với tham số id và status
            const apiResult = await customerUpdateStatusOrder(statusObj);
            console.log(apiResult);
            // Gọi hàm xử lý cập nhật trạng thái và truyền kết quả từ API
            onUpdateStatus(registeredParking, selectedStatus, apiResult);
            Swal.fire({
                icon: 'success',
                title: 'Cập Nhật Trạng Thái Thành Công',
                text: 'Trạng thái đã được cập nhật thành công!',
            });

            // Đóng dialog
            onClose(selectedStatus);
        } catch (error) {
            // Xử lý lỗi nếu có
            setApiError(error.message || 'An error occurred');
        } finally {
            // Kết thúc loading API
            setApiLoading(false);
        }

        // Gọi hàm xử lý trạng thái từ ManagerParking
        onStatusChange(registeredParking, selectedStatus);

        // Đóng dialog
        onClose(selectedStatus);
    };

    const handleClose = () => {
        onClose(null);
    };

    return (
        <Dialog onClose={handleClose} open={open}>
            <DialogTitle
                sx={{
                    textAlign: 'center',
                    textTransform: 'uppercase',
                }}
            >
                CHOOSE STATUS
            </DialogTitle>
            <List>
                {statusOptions.map((status, index) => (
                    <ListItem
                        key={status}
                        button
                        selected={index === selectedStatusIndex}
                        onClick={() => handleStatusChange(index)}
                    >
                        <ListItemText primary={status} />
                    </ListItem>
                ))}
            </List>
            <DialogActions>
                <Button variant="contained" onClick={handleClose} color="secondary" sx={{ backgroundColor: 'pink' }}>
                    CANCEL
                </Button>
                <Button
                    variant="contained"
                    onClick={handleUpdateStatus}
                    color="primary"
                    sx={{ backgroundColor: 'blue', color: 'white' }}
                >
                    ACCEPT
                </Button>
            </DialogActions>
        </Dialog>
    );
}

export default StatusChangeDialog;
