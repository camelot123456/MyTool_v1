# MyTool v1.0

Một ứng dụng đa màn hình được xây dựng với LVGL và Lua, cung cấp nhiều công cụ tiện ích trong một giao diện thống nhất.

## 🎯 Tính năng chính

### 📱 Giao diện đa màn hình
- **Màn hình chính (Root)**: Menu chính với các ứng dụng
- **Máy tính (Calculator)**: Máy tính cơ bản với các phép tính
- **Lịch (Calendar)**: Widget lịch hiển thị tháng hiện tại
- **Trò chơi (Games)**: Bộ sưu tập các trò chơi đơn giản
- **Cài đặt (Settings)**: Tùy chỉnh ứng dụng
- **Phát nhạc (Music)**: Giao diện phát nhạc với điều khiển

### 🎨 Thiết kế
- **Dark Mode**: Giao diện tối với màu chủ đạo #1a1a1a
- **Responsive**: Tự động điều chỉnh theo kích thước màn hình (212x520)
- **Modern UI**: Sử dụng font Montserrat và các icon emoji
- **Smooth Navigation**: Chuyển đổi mượt mà giữa các màn hình

## 🏗️ Cấu trúc dự án

```
MyTool_v1/
├── app/
│   └── lua/
│       ├── main.lua              # File chính quản lý navigation
│       ├── lvgl.lua              # Thư viện LVGL
│       └── screens/              # Thư mục chứa các màn hình
│           ├── root_screen.lua      # Màn hình chính
│           ├── calculator_screen.lua # Máy tính
│           ├── calendar_screen.lua   # Lịch
│           ├── games_screen.lua      # Trò chơi
│           ├── settings_screen.lua   # Cài đặt
│           └── music_screen.lua      # Phát nhạc
├── images/                       # Thư mục chứa hình ảnh
├── output/                       # Thư mục output
├── .vscode/                      # Cấu hình VS Code
├── MyTool_v1.fprj               # File project
└── README.md                    # File này
```

## 🚀 Cách sử dụng

### Yêu cầu hệ thống
- LVGL framework
- Lua runtime
- Màn hình với độ phân giải tối thiểu 212x520

### Khởi chạy ứng dụng
1. Đảm bảo LVGL đã được cài đặt và cấu hình
2. Chạy file `app/lua/main.lua`
3. Ứng dụng sẽ hiển thị màn hình chính với các tùy chọn

### Điều hướng
- **Từ màn hình chính**: Nhấn vào các nút ứng dụng để chuyển đến màn hình tương ứng
- **Từ các màn hình con**: Nhấn nút "← Back" để quay về màn hình chính
- **Navigation Manager**: Quản lý việc chuyển đổi giữa các màn hình một cách mượt mà

## 📱 Chi tiết các màn hình

### 🏠 Màn hình chính (Root Screen)
- **Tiêu đề**: "MyTool v1.0"
- **Các ứng dụng**:
  - 🧮 Calculator (Màu xanh dương)
  - 📅 Calendar (Màu đỏ)
  - 🎮 Games (Màu tím)
  - ⚙️ Settings (Màu cam)
  - 🎵 Music (Màu xanh lá)

### 🧮 Máy tính (Calculator)
- **Hiển thị**: Màn hình LCD với font lớn
- **Phím số**: 0-9, dấu thập phân
- **Phép tính**: +, -, *, /
- **Chức năng**: Clear (C), Equal (=)
- **Tính năng**: Tính toán real-time, xử lý lỗi

### 📅 Lịch (Calendar)
- **Widget lịch**: Hiển thị tháng hiện tại
- **Thông tin ngày**: Tên tháng và năm
- **Ngày hôm nay**: Hiển thị ngày hiện tại
- **Tương tác**: Có thể chọn ngày (tính năng mở rộng)

### 🎮 Trò chơi (Games)
- **🐍 Snake**: Trò chơi rắn săn mồi
- **⭕ Tic Tac Toe**: Cờ caro
- **🧠 Memory**: Trò chơi trí nhớ
- **🧩 Puzzle**: Trò chơi xếp hình
- **Trạng thái**: "Coming Soon" - đang phát triển

### ⚙️ Cài đặt (Settings)
- **Theme**: Light/Dark/Auto
- **Volume**: Điều chỉnh âm lượng
- **Brightness**: Điều chỉnh độ sáng
- **Language**: English/Vietnamese/Chinese
- **About**: Thông tin ứng dụng và phiên bản

### 🎵 Phát nhạc (Music)
- **Album Art**: Placeholder với icon nhạc
- **Thông tin bài hát**: Tên bài hát và nghệ sĩ
- **Thanh tiến trình**: Hiển thị thời gian phát
- **Điều khiển**: Play/Pause, Previous, Next
- **Tính năng bổ sung**: Volume, Shuffle, Repeat, Playlist

## 🛠️ Công nghệ sử dụng

### Framework
- **LVGL**: Light and Versatile Graphics Library
- **Lua**: Ngôn ngữ lập trình chính
- **Built-in Fonts**: Montserrat font family

### Kiến trúc
- **Modular Design**: Mỗi màn hình được tách riêng
- **Screen Manager**: Quản lý navigation tập trung
- **Event-driven**: Xử lý sự kiện click và tương tác
- **Global State**: Quản lý trạng thái ứng dụng

## 🎨 Thiết kế UI/UX

### Màu sắc
- **Background**: #1a1a1a (Dark gray)
- **Text**: #FFFFFF (White)
- **Secondary Text**: #888888 (Light gray)
- **Buttons**: Various colors for different apps

### Typography
- **Font Family**: Montserrat
- **Sizes**: 10px, 12px, 14px, 16px, 18px, 20px, 24px, 48px
- **Weights**: Normal, Bold (where applicable)

### Layout
- **Screen Size**: 212x520 pixels
- **Padding**: Consistent spacing
- **Border Radius**: Rounded corners for modern look
- **Alignment**: Centered and properly spaced elements

## 🔧 Phát triển

### Thêm màn hình mới
1. Tạo file mới trong thư mục `screens/`
2. Implement function `create_screen_name()`
3. Thêm case trong `ScreenManager.show_screen()`
4. Thêm nút trong root screen

### Cấu trúc file screen
```lua
local lvgl = require("lvgl")

local function create_screen_name()
  local screen = lvgl.Object()
  screen:set {
    w = 212,
    h = 520,
    bg_color = "#1a1a1a"
  }
  
  -- Header và Back button
  -- Content
  -- Event handlers
  
  return screen
end

return {
  create = create_screen_name
}
```

### Navigation
```lua
-- Chuyển đến màn hình khác
_G.ScreenManager.show_screen("screen_name")

-- Quay về màn hình chính
_G.ScreenManager.show_screen("root")
```

## 📝 Phiên bản

- **Version**: 1.0.0
- **Last Updated**: 2024
- **Author**: MyTool Development Team

## 🤝 Đóng góp

1. Fork dự án
2. Tạo branch mới (`git checkout -b feature/AmazingFeature`)
3. Commit thay đổi (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Mở Pull Request

## 📄 License

Dự án này được phát hành dưới MIT License.

## 📞 Liên hệ

- **Email**: support@mytool.com
- **Website**: https://mytool.com
- **GitHub**: https://github.com/mytool/mytool-v1

---

**MyTool v1.0** - Một ứng dụng đa màn hình hiện đại được xây dựng với LVGL và Lua.
