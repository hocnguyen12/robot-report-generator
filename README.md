# Robot Framework Fails

## Run the automated tests

First run the app:
```bash
npm run dev
```

```bash
robot --outputdir robot_reports/ tests/*.robot
```

Created a script that deletes all previous screenshots and geckodriver logs :

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

