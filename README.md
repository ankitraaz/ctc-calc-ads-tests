# 💼 CTC Calculator App (with Ads & Export)  

An Android Flutter app that calculates **net salary** from **CTC (Cost to Company)**, showing detailed breakdowns of earnings, deductions, and employer contributions.

Includes:
- 📄 PDF & Excel export
- 💰 Google Ads integration
- 📊 Tax regime toggle
- 📩 Contact Us page

---

## 🔧 Project Purpose

This app is designed for job seekers, HR professionals, and salary analysts to:

- ✅ Enter a CTC amount (Monthly or Yearly)
- ✅ Get a detailed salary breakdown
- ✅ Understand tax/deductions clearly
- ✅ Export as **PDF** or **Excel**
- ✅ Monetize via **Google Mobile Ads**

---

## 🧱 Main Components

### 1. 💡 User Input UI
- `TextField`: Enter CTC value
- `ChoiceChip`: Toggle Monthly / Yearly
- `Calculate Button`: Triggers salary breakdown

### 2. 💰 CTC Calculation
Breakdown includes:
- **Earnings**: Basic, HRA, Allowances
- **Deductions**: PF, Taxes
- **Employer Contributions**: Gratuity, PF

✅ Logic handled via `CtcCalculator.calculate()` in `ctc_calculator.dart`

---

## 📤 Export Functionality

### a. PDF Export
- Uses `pdf` package
- Professional format with headers
- Saved to `Downloads` folder

### b. Excel Export
- Uses `excel` package
- Structured rows and columns
- Saved as `.xlsx` in Downloads

### ✅ Storage Permissions
- Managed via `permission_handler`  
- Prompted before download

---

## 💰 Google Ads Integration

- `Interstitial Ads` shown before PDF/Excel download
- Uses `google_mobile_ads` package
- Test Ad IDs used (update to real before production)

---

## 🧾 Tax Regime Page

Includes a separate **Tax Regime Page** showing:

- Tax slabs (Old vs New)
- Automatic switching logic (optional)
- Helps users understand **how tax affects net salary**

---

## 📬 Contact Us Page

Simple UI where users can:

- Submit feedback
- Ask for help
- View developer info

---

## 💬 Localization

- Uses `intl` package
- Proper Indian currency formatting  
  Example: ₹1,50,000

---

## 🛠 Packages Used

| Package              | Purpose                        |
|----------------------|--------------------------------|
| `pdf`               | Export PDF                     |
| `excel`             | Export Excel                   |
| `permission_handler`| Request storage permissions     |
| `google_mobile_ads` | Show interstitial ads          |
| `intl`              | ₹ currency formatting          |
| `path_provider`     | Locate Android `Downloads/` dir|

---

## 📱 Platform Support

- ✅ **Android** fully supported  
- ⚠️ **iOS** may need tweaks (especially file paths & permissions)
- ✅ Works offline (except for ads)

---

## ✅ Example Use Case

> A user enters ₹10,00,000 as yearly CTC → clicks "Calculate" → sees breakdown → taps "Download PDF" → ad is shown → PDF is saved to `Downloads`.


---

## 📸 Screenshots

![CTC Entry Screen](https://github.com/user-attachments/assets/4847a3ea-afec-4089-aaec-bcdcd6b83772)
![CTC Result Screen](https://github.com/user-attachments/assets/bee7a815-3021-4241-8188-ccc80d812ae0)
![Export Buttons](https://github.com/user-attachments/assets/2f96460e-578a-4186-b85b-64ebb467789d)

---

> Built with ❤️ by **Purple Merit Team**
