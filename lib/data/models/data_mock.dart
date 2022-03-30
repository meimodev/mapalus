class DataMock {
  static var products = [
    {
      "id": 123,
      "name": "Rica rica merah",
      "description": "This is the rica description",
      "imageUrl": "image_url_here",
      "price": 3000,
      "unit": "Kilogram",
      "weight": '1000',
      "status": 'available',
      "isCustomPrice": true,
    },
    {
      "id": 144,
      "name": "Tomat Tomat Biru",
      "description": "Blue comes from the smurfs that plant this tomatoes",
      "imageUrl": "image_url_here",
      "price": 18500,
      "unit": "Kilogram",
      "weight": '1000',
      "status": 'available',
      "isCustomPrice": true,
    },
    {
      "id": 99,
      "name": "Batang Bawang",
      "description": "",
      "imageUrl": "image_url_here",
      "price": 2000,
      "unit": "Kilogram",
      "weight": '1000',
      "status": 'available',
      "isCustomPrice": false,
    },
    {
      "id": 99,
      "name": "Batang Emas",
      "description":
          "This product is not eligible to digest, so, adult precaution is required",
      "imageUrl": "image_url_here",
      "price": 20000,
      "unit": "gram",
      "weight": '1',
      "status": 'available',
      "isCustomPrice": false,
    },
  ];

  static List<Map<String, dynamic>> deliveries = [
    {
      "id": "NOW",
      "start": "07:00 13/05/2022",
      "end": "20:00 13/05/2022",
      "available": true,
      "discount": '1',
    },
    {
      "id": "MORNING_1",
      "start": "07:00 13/05/2022",
      "end": "08:00 13/05/2022",
      "available": true,
      "discount": '0.5',
    },
    {
      "id": "NOON_1",
      "start": "10:00 13/05/2022",
      "end": "11:00 13/05/2022",
      "available": true,
      "discount": '0.5',
    },
    {
      "id": "AFTERNOON_1",
      "start": "14:00 13/05/2022",
      "end": "15:00 13/05/2022",
      "available": true,
      "discount": '0.5',
    },
  ];
}