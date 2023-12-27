// ignore_for_file: prefer_interpolation_to_compose_strings

// String domain = 'http://192.168.88.101:8080/';
// String domain = 'http://172.16.2.229:8080/';
// String domain = 'http://192.168.1.48:8080/';
String domain = 'https://e964-115-78-10-13.ngrok-free.app/';

// -- auth
String loginAPI = domain + 'auth/login';
String registerAPI = domain + 'auth/register/user';
String sendTokenAPI = domain + 'auth/send-token';
String resetPassAPI = domain + 'auth/forget-password/change-password';

// -- profile
String profileUserAPI = domain + 'api/v1/user-infor-detail';
String profileEditInforAPI = domain + 'api/v1/edit/user';
String profileChangePassAPI = domain + 'api/v1/change-password';

// -- supplier
String supplierCreateDetailAPI = domain + 'api/v1/supplier/create-detail';
String supplierListProductAPI = domain + 'api/v1/supplier/get-all-detail';
String supplierStatusProductAPI = domain + 'api/v1/supplier/update-status';

String supplierListOrderFullStatusByIdAPI =
    domain + 'api/v1/supplier/get-all-order-from-detail';
String supplierListRentFullStatusByIdAPI =
    domain + 'api/v1/supplier/get-all-rent-from-detail';

String supplierUpdateImageProductAPI =
    domain + 'api/v1/supplier/update-detail-image';
String supplierUpdateInforProductAPI =
    domain + 'api/v1/supplier/update-detail-infor';

// -- customer
String customerCreateInforAPI =
    domain + 'api/v1/customer/customer-infor-create';
String getListParkingDetailAvailableAPI =
    domain + 'api/v1/customer/customer-list-parking-detail-available';
String updateCustomerInforDocAPI =
    domain + 'api/v1/customer/customer-update-infor-doc';

// -- order
String createOrderProductAPI =
    domain + 'api/v1/customer/create-order-register-park';
String getListOrderCustomerNotSuccessAPI =
    domain + 'api/v1/customer/get-list-order-park';
String customerUpdateStatusOrderAPI =
    domain + 'api/v1/customer/customer-update-status-order';

// -- rent
String getListRentCustomerNotCancelAPI = domain + 'api/v1/get-list-rent-park';
String supplierUpdateStatusRentAPI =
    domain + 'api/v1/supplier/update-status-rental';

String getCountDashboardAPI = domain + 'api/v1/supplier/get-count';
