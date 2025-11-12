/* 
    CREATE TABLE Employees (
        emp_id INT PRIMARY KEY,
        emp_name VARCHAR2(50),
        basic_salary NUMBER,
        hra NUMBER,
        da NUMBER,
        deductions NUMBER
    );

    CREATE TABLE Payroll_Log (
        log_id INT PRIMARY KEY,
        emp_id INT,
        action VARCHAR2(50),
        log_date DATE,
        FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
    );


    INSERT INTO Employees VALUES (101, 'Aman Sharma',        42000,  8000,  7000,  2500);
    INSERT INTO Employees VALUES (102, 'Sneha Patel',        38000,  7500,  6200,  2200);
    INSERT INTO Employees VALUES (103, 'Ravi Kumar',         55000, 10000,  8500,  3000);
    INSERT INTO Employees VALUES (104, 'Priya Nair',         60000, 12000,  9500,  3500);
    INSERT INTO Employees VALUES (105, 'Arjun Singh',        47000,  9000,  7800,  2600);
    INSERT INTO Employees VALUES (106, 'Neha Verma',         51000, 10000,  8200,  2700);
    INSERT INTO Employees VALUES (107, 'Rahul Deshmukh',     36000,  7200,  6100,  2000);
    INSERT INTO Employees VALUES (108, 'Simran Kaur',        40000,  8500,  6800,  2100);
    INSERT INTO Employees VALUES (109, 'Mohit Gupta',        62000, 12000,  9700,  3800);
    INSERT INTO Employees VALUES (110, 'Anjali Mehta',       33000,  7000,  5900,  1800);
    INSERT INTO Employees VALUES (111, 'Karan Thakur',       57000, 11000,  8800,  3200);
    INSERT INTO Employees VALUES (112, 'Divya Reddy',        49000,  9400,  7700,  2500);
    INSERT INTO Employees VALUES (113, 'Farhan Ali',         45000,  8700,  7200,  2300);
    INSERT INTO Employees VALUES (114, 'Pooja Iyer',         52000, 10500,  8400,  2800);
    INSERT INTO Employees VALUES (115, 'Siddharth Jain',     58000, 11500,  9000,  3400);
    INSERT INTO Employees VALUES (116, 'Aisha Khan',         39500,  7900,  6400,  2100);
    INSERT INTO Employees VALUES (117, 'Rohit Malhotra',     61000, 12000,  9500,  3600);
    INSERT INTO Employees VALUES (118, 'Komal Joshi',        46500,  8800,  7500,  2500);
    INSERT INTO Employees VALUES (119, 'Nikhil Chawla',      37500,  7600,  6200,  2000);
    INSERT INTO Employees VALUES (120, 'Tanya Das',          43000,  8500,  6900,  2400);

 */


-- Package Specifications
CREATE OR REPLACE PACKAGE payroll_pkg AS

    company_bonus CONSTANT NUMBER := 500;

    FUNCTION calc_gross_salary(p_emp_id IN NUMBER) RETURN NUMBER;
    FUNCTION calc_net_salary(p_emp_id IN NUMBER) RETURN NUMBER;
    PROCEDURE update_salary(p_emp_id IN NUMBER, p_hra IN NUMBER, p_da IN NUMBER);
    PROCEDURE log_salary_action(p_emp_id IN NUMBER, p_action IN VARCHAR2);

    e_emp_not_found EXCEPTION;
    
END payroll_pkg;
/



-- Package Body
CREATE OR REPLACE PACKAGE BODY payroll_pkg AS

    -- calc_gross_salary - basic_salary + hra + da + company_bonus.
    FUNCTION calc_gross_salary(p_emp_id IN NUMBER) RETURN NUMBER
    IS
        v_basic Employees.BASIC_SALARY%TYPE;
        v_hra   Employees.HRA%TYPE;
        v_da    Employees.DA%TYPE;
        v_gross NUMBER;
    BEGIN
        SELECT basic_salary, hra, da
        INTO v_basic, v_hra, v_da
        FROM EMPLOYEES
        WHERE emp_id = p_emp_id;

        v_gross := v_basic + v_hra + v_da + company_bonus;

        RETURN v_gross;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE e_emp_not_found;
    END calc_gross_salary;


    -- calc_net_salary -  gross_salary – deductions.
    FUNCTION calc_net_salary(p_emp_id IN NUMBER) RETURN NUMBER 
    IS
        v_deductions Employees.DEDUCTIONS%TYPE;
        v_gross NUMBER;
        v_net NUMBER;
    BEGIN
        v_gross := calc_gross_salary(p_emp_id);

        SELECT deductions INTO v_deductions 
        FROM EMPLOYEES
        WHERE emp_id = p_emp_id;

        v_net := v_gross - v_deductions;
        RETURN v_net;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE e_emp_not_found;

    END calc_net_salary;


    -- update_salary - It updates hra and da
    PROCEDURE update_salary(p_emp_id IN NUMBER, p_hra IN NUMBER, p_da IN NUMBER)
    IS
        v_exists NUMBER;
    BEGIN

        SELECT COUNT(*) INTO v_exists 
        FROM EMPLOYEES
        WHERE emp_id = p_emp_id;

        IF v_exists = 0 THEN
            RAISE e_emp_not_found;
        END IF;

        UPDATE EMPLOYEES
        SET hra = p_hra,
            da = p_da
        WHERE emp_id = p_emp_id;

        COMMIT;
        log_salary_action(p_emp_id, 'Salary Updated');
    END update_salary;


    -- log_salary_action - It inserts the data into payroll_log
    PROCEDURE log_salary_action(p_emp_id IN NUMBER, p_action IN VARCHAR2)
    IS  
        v_log_id NUMBER;
    BEGIN
        SELECT NVL(MAX(log_id), 0) + 1 INTO v_log_id FROM PAYROLL_LOG;

        INSERT INTO PAYROLL_LOG (LOG_ID, EMP_ID, ACTION, LOG_DATE)
        VALUES(v_log_id, p_emp_id, p_action, SYSDATE);

        COMMIT;
    END log_salary_action;

END payroll_pkg;