# Robot Framework Fails

## How to run the automated tests

First run the app:
```bash
npm run dev
```

```bash
robot --outputdir robot_reports/ tests/*.robot
```

`run_tests.sh` deletes all previous screenshots and geckodriver logs to keep the `robot_reports` directory clean.

1. Run all tests:
```bash
./run_tests.sh
```

2. Run specific test files:
```bash
./run_tests.sh tests/todo_tests.robot
```

3. Run tests with additional robot options
```bash
./run_tests.sh --variable BROWSER:firefox tests/todo_tests.robot
```

