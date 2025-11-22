# EasACC Task

## 📋 Installation

Before you begin, ensure you have the following installed:
- Flutter SDK (3.0 or higher recommended)
- Dart SDK
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd easacc_task
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Encryption Keys

The application uses encrypted storage for sensitive data. You need to generate encryption keys before running the app.

Run the following command to generate your encryption keys:

```bash
dart lib/core/helpers/encrypt_helper/crypto_generator.dart
```

This will output a unique encryption key and initialization vector (IV) that you'll need in the next step.

### 4. Configure Environment Variables

Create an `env.json` file in the root directory of the project with the following structure:

```json
{
  "ENCRYPT_KEY": "your_generated_key_here",
  "ENCRYPT_IV": "your_generated_iv_here"
}
```

Replace `your_generated_key_here` and `your_generated_iv_here` with the values generated in step 3.

> ⚠️ **Important**: Never commit the `env.json` file to version control. Add it to your `.gitignore` file.

### 5. Run the Application

#### Using Command Line

```bash
flutter run --dart-define-from-file=env.json
```

#### Using IDE

Add the following to your run configuration's **Additional run args**:

```
--dart-define-from-file=env.json
```

**VS Code**: Add to `.vscode/launch.json`:
```json
{
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define-from-file=env.json"
      ]
    }
  ]
}
```

**Android Studio/IntelliJ**: 
1. Go to Run → Edit Configurations
2. Add `--dart-define-from-file=env.json` to "Additional run args"

## 🔒 Security Notes

- The `env.json` file contains sensitive encryption keys and should never be shared or committed to version control
- Each environment (development, staging, production) should have its own set of encryption keys
- Store production keys securely using a secrets manager
- Regenerate keys if you suspect they have been compromised

## 🛠️ Troubleshooting

### Issue: "env.json not found"
**Solution**: Ensure you've created the `env.json` file in the project root directory and it contains valid JSON.

### Issue: "Invalid encryption key format"
**Solution**: Re-run the crypto generator script and ensure you're copying the complete key and IV values.

### Issue: App crashes on startup
**Solution**: Verify that the `--dart-define-from-file=env.json` argument is included in your run configuration.

### Issue: Flutter command not found
**Solution**: Make sure Flutter is properly installed and added to your system PATH.
