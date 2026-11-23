<div dir="rtl">

# 🛒 Vodda — اپلیکیشن سمت مشتری

<p align="center">
  <img src="designs/logo.png" width="140" alt="Vodda" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3-02569B?logo=flutter" alt="Flutter 3" />
  <img src="https://img.shields.io/badge/Dart-3.7-0175C2?logo=dart" alt="Dart" />
  <img src="https://img.shields.io/badge/GetX-state%20management-8A2BE2" alt="GetX" />
  <img src="https://img.shields.io/badge/version-1.0.2-blue" alt="version" />
  <img src="https://img.shields.io/badge/RTL-%D9%81%D8%A7%D8%B1%D8%B3%DB%8C-green" alt="Persian RTL" />
</p>

اپلیکیشن مشتریان پلتفرم **Vodda** 🏠 — بازار آنلاین درخواست خدمات: جست‌وجوی خدمات‌دهنده، ثبت درخواست خدمت در چند مرحله، پیگیری سفارش‌ها و ارتباط لحظه‌ای با سرور.

> 📱 این ریپو **سمت مشتری** است؛ اپلیکیشن سمت خدمات‌دهنده در ریپوی [VoddaProviders](https://github.com/Mhabib70/VoddaProviders) نگهداری می‌شود.

## 🆕 آخرین به‌روزرسانی (اکتبر ۲۰۲۶)

- 📚 مستندسازی کامل پروژه جایگزین README پیش‌فرض Flutter شد
- 🐛 رفع باگ‌های گروه‌های رادیویی (نسخهٔ ۱.۰.۲)

---

## ✨ امکانات

- 🏠 **خانه و دسته‌بندی خدمات** — مرور دسته‌بندی‌ها، زیرسرویس‌ها و جست‌وجوی خدمات‌دهندگان
- 🧭 **ثبت درخواست خدمت (ویزارد چندمرحله‌ای)** — نوع خدمت ← شرح و بازبینی ← آدرس روی نقشه ← زمان‌بندی ← تایید نهایی
- 📦 **مدیریت سفارش‌ها** — لیست سفارش‌های من، جزئیات خدمات‌دهنده، رزومه و سوابق، اسناد سفارش و تصاویر
- 👤 **پروفایل کاربری** — ویرایش پروفایل، دفترچهٔ آدرس‌ها، انتخاب شهر، علاقه‌مندی‌ها
- 🔔 **اعلان‌ها** — اعلان‌های محلی و پس‌زمینه با `awesome_notifications` + سرویس پس‌زمینه
- ⚡ **ارتباط لحظه‌ای** — اتصال Socket.IO با پروتکل Laravel Echo برای به‌روزرسانی‌های زنده
- 🗺 **نقشه و موقعیت** — نمایش نقشه با `flutter_map`، موقعیت‌یابی `geolocator` و مسیریابی با `map_launcher`
- 🎬 **تجربهٔ کاربری** — اسلایدرهای معرفی، پخش ویدیو، حالت آفلاین با پیام خطای اتصال و طراحی ریسپانسیو

## 🏗 معماری

ساختار لایه‌ای بر پایهٔ **GetX** با جداسازی کامل UI، منطق و مدل‌ها:

```
lib/
├── UI/
│   ├── Views/          # صفحه‌ها: Main · Order · Question · User
│   └── Components/     # ویجت‌های مشترک
├── Logic/
│   ├── Controllers/    # کنترلرهای GetX (app · main · order · service · user · notification)
│   ├── Helpers/        # متدهای API و مدیریت توکن
│   └── Models/         # مدل‌های داده (سفارش · دسته‌بندی · شهر · آدرس و ...)
├── laravel_echo/       # کلاینت Laravel Echo روی Socket.IO
├── Public/             # منابع مشترک
└── main.dart
```

## 🛠 تکنولوژی‌ها

| لایه | ابزار |
| --- | --- |
| 📱 فریم‌ورک | Flutter 3 · Dart |
| 🧠 مدیریت حالت | GetX |
| 🌐 شبکه | dio · Laravel Echo · socket_io_client |
| 🗺 نقشه و مکان | flutter_map · geolocator · map_launcher |
| 🔔 پس‌زمینه و اعلان | flutter_background_service · awesome_notifications |
| 🖼 رسانه | video_player · image_picker · image_cropper · flutter_svg |
| 💾 ذخیره‌سازی | shared_preferences |

## 🚀 راه‌اندازی

```bash
git clone https://github.com/Mhabib70/VoddaOld.git
cd VoddaOld
flutter pub get
flutter run
```

</div>

---

<div dir="ltr">

## 🌍 English Summary

**Vodda (Customer App)** — the customer-side Flutter app of the **Vodda** services marketplace (Persian, RTL), currently at **v1.0.2**. The provider-side app lives in [VoddaProviders](https://github.com/Mhabib70/VoddaProviders).

- 🏠 Browse service categories/sub-services and search providers; 🧭 multi-step service request wizard (type → description → map address → scheduling → confirmation).
- 📦 Order management with provider details, resume/history, order documents and photos; 👤 profile, address book, city selection and favorites.
- 🔔 Local & background notifications (`awesome_notifications` + background service); ⚡ live updates over **Socket.IO with the Laravel Echo protocol**.
- 🗺 Maps & location via `flutter_map`, `geolocator` and `map_launcher`; 🎬 intro sliders, video playback, offline mode and responsive design.
- 🧱 **Stack:** Flutter 3 · Dart · GetX (layered UI / Logic / Models) · dio · Laravel Echo.

**Quick start:** `git clone` → `flutter pub get` → `flutter run`

</div>
