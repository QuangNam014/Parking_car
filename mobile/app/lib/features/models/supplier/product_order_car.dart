class ProductOrderParking {
  final String name;
  final String image;
  final String status;

  ProductOrderParking( {required this.name, required this.status, required this.image,} );
}


final List<ProductOrderParking> productOrderParkingList = [
  ProductOrderParking(image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png", name: "128/37 bùi quang là phường 12 quận gò vấp, tphcm, vietnam", status: "PENDING"),
  ProductOrderParking(name: "Bãi 2 ", status: "PENDING", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 3 ", status: "PENDING", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 4 ", status: "SUCCESS", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 5 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 6 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 7 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 8 ", status: "SUCCESS", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 9 ", status: "SUCCESS", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
];

final List<ProductOrderParking> productOrderParkingListNotSuccess = [
  ProductOrderParking(image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png", name: "128/37 bùi quang là phường 12 quận gò vấp, tphcm, vietnam", status: "PENDING"),
  ProductOrderParking(name: "Bãi 2 ", status: "PENDING", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 3 ", status: "PENDING", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 5 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 6 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductOrderParking(name: "Bãi 7 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
];


