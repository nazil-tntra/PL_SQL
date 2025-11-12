BEGIN
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('   STUDENT PERFORMANCE REPORT');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');

    FOR r IN (SELECT * FROM Students ORDER BY student_id) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Student ID: ' || r.student_id ||
            ', Name: ' || r.student_name ||
            ', Course: ' || r.course ||
            ', Total: ' || get_student_total(r.student_id) ||
            ', Average: ' || get_student_average(r.student_id) ||
            ', Grade: ' || get_grade(r.student_id)
        );
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Topper in CS Course: ' || course_topper('CS'));
    DBMS_OUTPUT.PUT_LINE('Topper in IT Course: ' || course_topper('IT'));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------');
END;
/


SELECT 
    student_id,
    student_name,
    course,
    get_student_total(student_id) AS total_marks,
    get_student_average(student_id) AS avg_marks,
    get_grade(student_id) AS grade
FROM Students 
ORDER BY student_id;
/
