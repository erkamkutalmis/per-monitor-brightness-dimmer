# Per-Monitor Brightness + Reduce White Point (Windhawk Mod)

A [Windhawk](https://windhawk.net/) mod for Windows 11 Quick Settings that adds per-display brightness, contrast, volume, input, and power controls — extended with Apple-style **Reduce White Point** software dimming and **time-based scheduling**.

Based on [bardelyne/per-monitor-brightness](https://github.com/bardelyne/per-monitor-brightness).

### What's New
- **Reduce White Point toggle:** Left-click any display's brightness icon in Quick Settings to dim below hardware limits (`10–99%`, default `70%`). Works in both SDR and HDR (`Auto`, `DDC/CI RGB gain`, `GPU gamma ramp`, or `DWM color matrix`).
- **Time-based schedule:** Automatically turn Reduce White Point on and off at scheduled local times (e.g. `20:00` – `05:00`). Manual toggles inside the window are preserved until the next transition.
- **State persistence:** Keeps your dimmed state across Windows `ShellHost.exe` restarts.
- **Contrast icon fix:** Fixed the oversized contrast slider icon in Quick Settings.

> **Note:** On backlit LCD panels (IPS/VA), software dimming lowers pixel values but cannot reduce the physical LED backlight below its hardware minimum. OLED panels dim cleanly to true black.

### Installation
1. Install [Windhawk](https://windhawk.net/).
2. Create a new mod in Windhawk and paste the contents of `per-monitor-brightness.wh.cpp`, **or** download `local@per-monitor-brightness.dll` and `install_to_windhawk.ps1` from [Releases](../../releases) (place the DLL in a `build/` folder next to the script) and run `install_to_windhawk.ps1`.

---

## Türkçe Açıklama

Windows 11 Hızlı Ayarlar paneline ekran bazlı parlaklık, kontrast, ses, giriş ve güç kontrolleri ekleyen [Windhawk](https://windhawk.net/) modunun; Apple tarzı **Beyaz Noktayı Azalt (Reduce White Point)** ve **saate göre otomatik zamanlama** eklenmiş sürümüdür.

Temel proje: [bardelyne/per-monitor-brightness](https://github.com/bardelyne/per-monitor-brightness).

### Yenilikler
- **Beyaz Noktayı Azalt:** Hızlı Ayarlar'da herhangi bir ekranın parlaklık ikonuna sol tıklayarak donanım parlaklığının üzerine yazılımsal karartma uygular (`%10–%99`, varsayılan `%70`). SDR ve HDR ekranlarla uyumludur (`Auto`, `DDC/CI RGB gain`, `GPU gamma ramp`, `DWM color matrix`).
- **Saate Göre Zamanlama:** Belirlenen yerel saatlerde (ör. `20:00` – `05:00`) tüm ekranlarda otomatik açılıp kapanır. Aralık içindeyken simgeye tıklayıp yaptığın manuel seçim bir sonraki geçişe kadar korunur.
- **Durum Kalıcılığı:** Windows `ShellHost.exe` yeniden başladığında karartma durumunu korur.
- **Kontrast İkonu Düzeltmesi:** Hızlı Ayarlar'daki büyük kontrast ikonu boyutu düzeltildi.

> **Not:** IPS/VA gibi arkadan aydınlatmalı LCD ekranlarda yazılımsal karartma yalnızca piksel değerlerini düşürür, fiziksel LED arka aydınlatmayı donanım sınırının altına indiremez. OLED ekranlarda tam siyaha kadar temiz şekilde kararır.

### Kurulum
1. [Windhawk](https://windhawk.net/) kurulu olmalıdır.
2. Windhawk'ta yeni bir mod oluşturup `per-monitor-brightness.wh.cpp` dosyasını yapıştırabilir **veya** [Releases](../../releases) sayfasından `local@per-monitor-brightness.dll` (betiğin yanındaki `build/` klasörüne koyarak) ve `install_to_windhawk.ps1` dosyalarını indirip `install_to_windhawk.ps1` betiğini çalıştırabilirsin.
