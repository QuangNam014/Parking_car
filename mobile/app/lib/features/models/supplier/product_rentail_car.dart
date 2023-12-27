class ProductRentalCar {
  final String name;
  final String image;
  final String status;

  ProductRentalCar( {required this.name, required this.status, required this.image,} );
}


final List<ProductRentalCar> productRentalCarList = [
  ProductRentalCar(image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png", name: "128/37 bùi quang là phường 12 quận gò vấp, tphcm, vietnam", status: "RENTING"),
  ProductRentalCar(name: "Bãi 2 ", status: "RENTING", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 3 ", status: "RENTING", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 4 ", status: "FINISH", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 5 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 6 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 7 ", status: "CANCEL", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 8 ", status: "FINISH", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 9 ", status: "FINISH", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
];

final List<ProductRentalCar> productRentalCarListNotCancel = [
  ProductRentalCar(image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png", name: "128/37 bùi quang là phường 12 quận gò vấp, tphcm, vietnam", status: "RENTING"),
  ProductRentalCar(name: "Bãi 2 ", status: "RENTING", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 3 ", status: "RENTING", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 4 ", status: "FINISH", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 8 ", status: "FINISH", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
  ProductRentalCar(name: "Bãi 9 ", status: "FINISH", image: "https://res.cloudinary.com/dpnkkp6rl/image/upload/v1701369004/app-my-parking/uktcaykthke3xbiipyrk.png"),
];


