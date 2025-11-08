# 🖼 Cached Network Image Widget

The **Cached Network Image Widget** package provides a simple, customizable way to display **network images and SVGs** in your Flutter applications.  
It supports **image caching**, **blurhash placeholders**, **shimmer loading animations**, and **SVG color customization** — all with minimal setup.

## ✨ Features

- 🧠 **Smart Caching** – Automatically caches network images and SVGs  
- 🌈 **BlurHash Placeholders** – Show a blurred preview while loading  
- ⚡ **Shimmer Loading** – Smooth skeleton loading animation  
- 🎨 **SVG Support** – Load and color SVGs from URLs  
- 🧩 **Customizable Styles** – Supports radius, borders, and shapes  
- ❌ **Error Handling** – Gracefully handle missing or broken images  

---

## ⚙️ Installation

Add `cached_network_image_widget` to your `pubspec.yaml` file:

```yaml
dependencies:
  cached_network_image_widget: ^1.0.0

Then run:

```bash
flutter pub get
```

Import the package:

```dart
import 'package:cached_network_image_widget/cached_network_image_widget.dart';
```

## 🚀 Usage

1. Display a Cached Network Image

```dart
CachedNetworkImageWidget(
	'https://picsum.photos/400/300',
	height: 200,
	width: 300,
	borderRadius: BorderRadius.circular(12),
);
```

2. Display a Cached SVG Image

```dart
CachedNetworkSvgWidget(
	'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg',
	height: 100,
	width: 100,
	color: Colors.green,
);
```

3. With BlurHash and Error Handling

```dart
CachedNetworkImageWidget(
	'https://example.com/photo-BH_cE3gK-EVH_.jpg', // BlurHash in URL
	height: 250,
	width: double.infinity,
	shape: BoxShape.rectangle,
	border: Border.all(color: Colors.grey.shade300),
	errorBuilder: (context, url, error) => const Icon(Icons.broken_image),
);
```

## 🔧 Parameters

| Parameter     | Type                                              | Description                             |
|---------------|---------------------------------------------------|-----------------------------------------|
| imageUrl      | String                                            | Image URL to load                       |
| height        | double?                                           | Image height                            |
| width         | double?                                           | Image width                             |
| borderRadius  | BorderRadius?                                     | Rounded corners                         |
| border        | BoxBorder?                                        | Border style                            |
| fit           | BoxFit                                            | How the image fits (default: BoxFit.cover) |
| shape         | BoxShape                                          | Shape (rectangle or circle)             |
| color         | Color?                                            | Tint color (for SVGs)                   |
| errorBuilder  | Widget Function(BuildContext, String, Object)?    | Custom error widget                     |




## 📄 License
🧪 Example App

You can find a working demo inside the `example/` folder.  
Run it directly:

```bash
cd example
flutter run
```

🪪 License

This project is licensed under the MIT License.  
© 2025 Safeen Kurd

👤 Author

Safeen Kurd  
📧 safeenkurd96@gmail.com  
🌐 void.krd — safeenkurd.info
