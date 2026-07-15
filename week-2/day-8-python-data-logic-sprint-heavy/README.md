# Day 8 - Python Data Logic Sprint Heavy Version

## Business Scenario

This project simulates a real-world business data analysis task for a technology and office equipment company in Kosovo. The raw order data contains inconsistencies and invalid records. The goal is to validate the data, normalize inconsistent values, calculate trusted business metrics, and generate business-ready reports using standard Python.

---

## How to Run

1. Open the project in Visual Studio Code.
2. Make sure Python is installed.
3. Open the terminal.
4. Navigate to the project folder.
5. Run:

```bash
python python_data_analysis.py
```

The script will validate the raw data, clean the records, calculate business metrics, display the results in the terminal, and generate all required output files automatically.

---

## Generated Output Files

- `validation_report.txt`
- `invalid_records.txt`
- `business_report.txt`

These files are created automatically inside the **output/** folder every time the script runs.

---

## Python Concepts Practiced

- Lists and dictionaries
- Functions
- Loops
- Conditional statements
- Data validation
- Data normalization
- Dictionary counting
- Revenue calculations
- Sorting
- File handling
- Business reporting
- Clean program structure using `main()`

---

## What Was Difficult

The most challenging part of this practice was designing the validation and normalization logic while keeping the original dataset unchanged. Another challenge was creating reusable functions that work dynamically for different fields instead of hardcoding values. Generating accurate business metrics and ensuring that only valid completed orders contributed to revenue required careful planning and testing.