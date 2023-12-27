import React, { useEffect, useState } from 'react';
import { Autocomplete, TextField, Button, Box } from '@mui/material';

import { getListCustomerInfo, searchCustomerByCCCD } from '~/utils';

const LiveSearch = ({ userDocuments, onSelect }) => {
    const [options, setOptions] = useState([]);
    const [inputValue, setInputValue] = useState('');
    const [error, setError] = useState(null);

    useEffect(() => {
        setOptions(userDocuments);
    }, [userDocuments]);

    const handleSearch = async () => {
        try {
            if (inputValue && inputValue !== '') {
                const result = await searchCustomerByCCCD(inputValue);
                console.log('API is called successfully: ', result);
                onSelect(result);
                console.log('Selected value:', inputValue);
            } else if (!inputValue) {
                const result = await getListCustomerInfo();
                console.log('API is called successfully: ', result);
                onSelect(result.data);
                console.log('Selected value:', inputValue);
            } else {
                console.log('No value selected');
            }
        } catch (error) {
            setError('Error calling API. Please try again.');
            console.error('Error calling API:', error);
        }
    };
    // console.log(' change x' + inputValue);
    return (
        <div style={{ display: 'flex' }}>
            <Box>
                <Autocomplete
                    options={options}
                    getOptionLabel={(option) => option}
                    onInputChange={(event, newInputValue) => {
                        setInputValue(newInputValue);
                    }}
                    clearOnBlur={false}
                    renderInput={(params) => <TextField {...params} label="Search by CCCD" variant="outlined" />}
                    style={{ marginBottom: 10 }}
                    sx={{
                        width: 300,
                        '& button.MuiButtonBase-root': {
                            visibility: 'visible',
                        },
                    }}
                />
                {error && <p style={{ color: 'red' }}>{error}</p>}
            </Box>
            <Box style={{ marginLeft: '20px', alignItem: 'center' }}>
                <Button
                    variant="contained"
                    color="primary"
                    onClick={handleSearch}
                    style={{
                        height: '82%',
                        width: '100px',
                    }}
                >
                    Search
                </Button>
            </Box>
        </div>
    );
};

export default LiveSearch;
