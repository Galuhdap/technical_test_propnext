<div align="center">
  
    <div>
            <h3><b>Technical Test Porpnext</b></h3>
            <p><i>Just do it</i></p>
    </div>      
</div>

## Getting started

**Prerequisites :**

- Flutter SDK : 3.41.4
- IDE of your choice (e.g., VS Code, or Android Studio)

**Installation :**

1. Clone the repository

```bash
$ git clone https://github.com/Galuhdap/technical_test_propnext
```

2. Navigate to project directory

```bash
$ cd technical_test_propnext
```

3. Install Dependencies

```bash
$ flutter pub get
```

**Asset Generator :**

- add in dev_dependencies
  - build_runner
  - flutter_gen_runner

- when you add image static or icon just run
  - dart run build_runner build

**Launch Settings**

1.  **VS Code**

            {
                "version": "0.2.0",
                "configurations": [
                  {
                    "name": "Dev TTPN",
                    "type": "dart",
                    "request": "launch",
                    "program": "lib/main_dev.dart",
                    "args": ["--flavor", "dev"]
                  },
                  {
                      "name": "TTPN",
                      "type": "dart",
                      "request": "launch",
                      "program": "lib/main_prod.dart",
                      "args": ["--flavor", "prod"]
                  }
                ]
           }

2.  **Android Studio**

`--flavor prod --no-enable-impeller`
