import React, { useEffect, useState } from 'react';
import { Autocomplete, TextField, Button, Box } from '@mui/material';

import { getListCustomerInfo, getListRegisteredParkingByCustomerId, searchCustomerByCCCD } from '~/utils';

const LiveSearch = ({ registeredParkings, onSelect }) => {
    // const [options, setOptions] = useState([]);
    // const [inputValue, setInputValue] = useState('');
    // const [error, setError] = useState(null);
    // const customerIdsSet = new Set();
    // const customerIds = registeredParkings
    //     .map((customer) => (customer.customerId ? customer.customerId.id : null))
    //     .filter((customerId) => {
    //         if (customerId !== null && !customerIdsSet.has(customerId)) {
    //             customerIdsSet.add(customerId);
    //             return true;
    //         }
    //         return false;
    //     });
    // console.log(customerIds);
    // const formattedCustomerIds = customerIds.map((customerId) => ({
    //     value: customerId,
    //     label: `CustomerID ${customerId}`,
    // }));
    // useEffect(() => {
    //     const fetchData = async () => {
    //         const apiCalls = customerIds.map(async (customerId) => {
    //             try {
    //                 const result = await getListRegisteredParkingByCustomerId(customerId);
    //                 console.log(result);
    //                 // Update the options or perform other actions based on the result
    //             } catch (error) {
    //                 console.error(`Error fetching data for customer ID ${customerId}:`, error);
    //                 // Handle errors here
    //                 if (error.message === 'Network Error') {
    //                     console.error('Network Error:', error);
    //                 }
    //             }
    //         });
    //         await Promise.all(apiCalls);
    //     };
    //     fetchData();
    //     setOptions(registeredParkings);
    // }, [registeredParkings, customerIds]);
    // const handleSearch = async () => {
    //     try {
    //         if (inputValue && inputValue !== '') {
    //             console.log(inputValue);
    //             const result = await searchCustomerByCCCD(inputValue);
    //             console.log('API is called successfully: ', result);
    //             onSelect(result);
    //             console.log('Selected value:', inputValue);
    //         } else if (!inputValue) {
    //             const result = await getListCustomerInfo();
    //             console.log('API is called successfully: ', result);
    //             onSelect(result.data);
    //             console.log('Selected value:', inputValue);
    //         } else {
    //             console.log('No value selected');
    //         }
    //     } catch (error) {
    //         setError('Error calling API. Please try again.');
    //         console.error('Error calling API:', error);
    //     }
    // };
    // return (
    //     <div style={{ display: 'flex' }}>
    //         <Box>
    //             <Autocomplete
    //                 options={formattedCustomerIds}
    //                 getOptionLabel={(option) => option.label}
    //                 onInputChange={(event, newInputValue) => {
    //                     setInputValue(newInputValue);
    //                 }}
    //                 clearOnBlur={false}
    //                 renderInput={(params) => <TextField {...params} label="Select Customer ID" variant="outlined" />}
    //                 style={{ marginBottom: 10 }}
    //                 sx={{
    //                     width: 300,
    //                     '& button.MuiButtonBase-root': {
    //                         visibility: 'visible',
    //                     },
    //                 }}
    //             />
    //             {error && <p style={{ color: 'red' }}>{error}</p>}
    //         </Box>
    //         <Box style={{ marginLeft: '20px', alignItem: 'center' }}>
    //             <Button
    //                 variant="contained"
    //                 color="primary"
    //                 onClick={handleSearch}
    //                 style={{
    //                     height: '82%',
    //                     width: '100px',
    //                     color: 'white',
    //                 }}
    //             >
    //                 Search
    //             </Button>
    //         </Box>
    //     </div>
    // );
};

export default LiveSearch;
