import { useState } from 'react';
import Swal from 'sweetalert2';
import { updateStatus } from '~/utils';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import Typography from '@mui/material/Typography';

const { Dialog, DialogTitle, List, ListItem, ListItemText, DialogActions, Button } = require('@mui/material');

// StatusChangeDialog component for selecting status
function StatusChangeDialog(props) {
    const { open, onClose, selectedParking, onStatusChange, onUpdateStatus } = props;

    const statusOptions = ['AVAILABLE', 'CANCEL', 'RENTING', 'DISABLE'];

    const [selectedStatusIndex, setSelectedStatusIndex] = useState(null);
    const [apiError, setApiError] = useState(null);
    const [apiLoading, setApiLoading] = useState(false);

    const handleStatusChange = (index) => {
        setSelectedStatusIndex(index);
    };

    const handleUpdateStatus = async () => {
        const selectedStatus = statusOptions[selectedStatusIndex]; // trường status
        const parkingId = selectedParking.id; // lay ra id cua object
        console.log(parkingId);

        const statusObj = {
            id: parkingId,
            status: selectedStatus,
        };

        try {
            // Gọi API với tham số id và status
            const apiResult = await updateStatus(statusObj);
            console.log(apiResult);
            // Gọi hàm xử lý cập nhật trạng thái và truyền kết quả từ API
            onUpdateStatus(parkingId, selectedStatus, apiResult);
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
        onStatusChange(parkingId, selectedStatus);

        // Đóng dialog
        onClose(selectedStatus);
    };

    console.log(selectedParking); // du lieu truong dc chon {}

    const handleClose = () => {
        onClose(null);
    };
    console.log(selectedParking);
    if (selectedParking.status === 'RENTING') {
        return (
            <Dialog onClose={handleClose} open={open}>
                <Card sx={{ maxWidth: 345 }}>
                    <CardMedia
                        sx={{ height: 140 }}
                        image={selectedParking.parkingImages[0].imageUrl}
                        title="green iguana"
                    />
                    <CardContent>
                        <Typography gutterBottom variant="h5" component="div">
                            Price: {selectedParking.price}
                        </Typography>
                        <Typography variant="body2" color="text.secondary">
                            Address: {selectedParking.parkingAddress.street}, F.{selectedParking.parkingAddress.ward},
                            D.{selectedParking.parkingAddress.district}, {selectedParking.parkingAddress.city} City
                        </Typography>
                    </CardContent>
                    <DialogActions>
                        <Button
                            variant="contained"
                            onClick={handleClose}
                            color="secondary"
                            sx={{ backgroundColor: 'pink' }}
                        >
                            CANCEL
                        </Button>
                    </DialogActions>
                </Card>
            </Dialog>
        );
    } else {
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
                    <Button
                        variant="contained"
                        onClick={handleClose}
                        color="secondary"
                        sx={{ backgroundColor: 'pink' }}
                    >
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
}

export default StatusChangeDialog;
