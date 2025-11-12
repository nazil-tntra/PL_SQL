DECLARE
    v_gross NUMBER;
    v_net NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- VALID EMPLOYEE TESTS ---');

    -- Calculate Gross Salary
    v_gross := payroll_pkg.calc_gross_salary(101);
    DBMS_OUTPUT.PUT_LINE('Gross Salary of Emp 101: ' || v_gross);

    -- Calculate Net Salary
    v_net := payroll_pkg.calc_net_salary(101);
    DBMS_OUTPUT.PUT_LINE('Net Salary of Emp 101: ' || v_net);

    -- Update Salary
    payroll_pkg.update_salary(102, 7500, 3500);
    DBMS_OUTPUT.PUT_LINE('Updated salary for Emp 102.');

    -- Log Manual Action
    payroll_pkg.log_salary_action(103, 'Manual Bonus Applied');
    DBMS_OUTPUT.PUT_LINE('Logged bonus action for Emp 103.');

    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('--- INVALID EMPLOYEE TEST ---');

     -- Passing the invalid Employee id (Triggers Exception)
    BEGIN
        v_net := payroll_pkg.calc_net_salary(999);
        DBMS_OUTPUT.PUT_LINE('Net Salary of Emp 999: ' || v_net);
    EXCEPTION
        WHEN payroll_pkg.e_emp_not_found THEN
            DBMS_OUTPUT.PUT_LINE('Error: Employee not found!');
    END;

END;
/