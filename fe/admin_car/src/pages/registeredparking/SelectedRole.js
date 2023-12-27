import { FormControl, InputLabel, MenuItem, Select } from '@mui/material';
import React from 'react';

function SelectedRole({ type, setType, UserType }) {
    return (
        <FormControl sx={{ mb: '15px', minWidth: 120 }} size="small">
            <InputLabel id="demo-select-small-label">Role</InputLabel>
            <Select
                labelId="demo-select-small-label"
                id="demo-select-small"
                value={type}
                label="type"
                onChange={(event) => setType(event.target.value)}
            >
                <MenuItem value={UserType.User}>User</MenuItem>
                <MenuItem value={UserType.Admin}>Admin</MenuItem>
                <MenuItem value={UserType.Manager}>Manager</MenuItem>
            </Select>
        </FormControl>
    );
}

export default SelectedRole;
