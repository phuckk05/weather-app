# Weather App

Ung dung thoi tiet Flutter hien thi thoi tiet hien tai, du bao nhieu ngay, va thong tin vi tri dua tren vi tri thiet bi. Du an su dung BLoC/Cubit de quan ly trang thai, va tach rieng lop dich vu goi API.

## Muc luc

- [Tong quan](#tong-quan)
- [Tinh nang chinh](#tinh-nang-chinh)
- [Cau truc thu muc](#cau-truc-thu-muc)
- [Co che hoat dong](#co-che-hoat-dong)
- [Yeu cau](#yeu-cau)
- [Cai dat](#cai-dat)
- [Chay ung dung](#chay-ung-dung)
- [Cau hinh API](#cau-hinh-api)
- [Kiem thu](#kiem-thu)
- [Build](#build)
- [Luu y](#luu-y)
- [Giay phep](#giay-phep)

## Tong quan

Du an nay la mot ung dung thoi tiet da nen tang (Android, iOS, Web, Desktop) duoc xay dung voi Flutter. Ung dung lay vi tri nguoi dung, goi API thoi tiet, chuyen doi du lieu va hien thi len giao dien.

## Tinh nang chinh

- Lay vi tri hien tai (GPS)
- Hien thi thoi tiet hien tai
- Du bao nhieu ngay (day forecast)
- Giao dien don gian, de mo rong
- Quan ly trang thai bang BLoC/Cubit

## Cau truc thu muc

Duoi day la cac thu muc chinh trong thu muc `lib/`:

- `main.dart`: diem vao ung dung
- `blocs/`: BLoC xu ly luong du lieu thoi tiet
- `cubits/`: Cubit quan ly giao dien (theme, v.v.)
- `constants/`: hang so, mau sac, theme, style
- `models/`: mo hinh du lieu (vi du: `weather.dart`)
- `screens/`: man hinh giao dien (vi du: `home_screen.dart`)
- `services/`: dich vu goi API va vi tri
- `widgets/`: thanh phan giao dien tai su dung

## Co che hoat dong

1. **Khoi dong**: `main.dart` khoi tao Flutter, chuan bi theme va route.
2. **Lay vi tri**: `services/location_service.dart` lay toan do tu thiet bi.
3. **Goi API**: `services/api_weather_service.dart` goi API thoi tiet.
4. **Xu ly trang thai**:
	- BLoC nhan su kien, goi service, map du lieu ve model.
	- Cubit dieu khien cac trang thai UI nhu theme.
5. **Hien thi**: `screens/home_screen.dart` nhan state va render giao dien.

## Yeu cau

- Flutter SDK (khuyen nghi phien ban moi nhat on dinh)
- Dart SDK (di kem Flutter)
- Android Studio hoac VS Code + Flutter/Dart plugin
- Thiet bi hoac gia lap de chay ung dung

## Cai dat

1. Clone repo:

```bash
git clone <repo_url>
```

2. Cai dat goi phu thuoc:

```bash
flutter pub get
```

## Chay ung dung

```bash
flutter run
```

Neu can chon thiet bi:

```bash
flutter devices
flutter run -d <device_id>
```

## Cau hinh API

Ung dung can khoa API thoi tiet. Quy trinh thuong gap:

1. Tao tai khoan tren nha cung cap API (vi du: OpenWeatherMap).
2. Lay API key.
3. Luu API key vao file cau hinh hoac bien moi truong.

> Luu y: Kiem tra file `services/api_weather_service.dart` de biet duong dan, tham so, va cach truyen API key cua du an.

## Kiem thu

```bash
flutter test
```

## Build

- Android:

```bash
flutter build apk
```

- iOS:

```bash
flutter build ios
```

- Web:

```bash
flutter build web
```

## Luu y

- Can cap quyen vi tri cho Android/iOS.
- Neu khong lay duoc vi tri, xem lai quyen va cai dat GPS.
- Du lieu thoi tiet co the bi gioi han theo han muc API.

## Giay phep

Du an hien chua cong bo giay phep. Neu can, hay them file LICENSE.

