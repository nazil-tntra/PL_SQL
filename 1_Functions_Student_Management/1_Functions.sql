-- get_student_total
CREATE OR REPLACE FUNCTION get_student_total (p_student_id IN number) 
RETURN NUMBER
IS
    v_total_marks NUMBER := 0;
BEGIN
    SELECT NVL(SUM(score),0)
    INTO v_total_marks
    FROM MARKS
    WHERE STUDENT_ID = p_student_id;

    return v_total_marks;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return 0;
END;
/


-- get_student_average
CREATE OR REPLACE FUNCTION get_student_average(p_student_id IN NUMBER) 
RETURN NUMBER
IS
    v_avg NUMBER := 0;
BEGIN
    SELECT NVL(AVG(SCORE),0)
    INTO v_avg 
    FROM MARKS
    WHERE STUDENT_ID = p_student_id;

    return v_avg;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/


-- get_grade
CREATE OR REPLACE FUNCTION get_grade(p_student_id IN NUMBER) 
RETURN VARCHAR2
IS 
    v_avg NUMBER := 0;
    v_grade VARCHAR2(2);
BEGIN

    v_avg := GET_STUDENT_AVERAGE(p_student_id);

    CASE 
        when v_avg >=90 THEN v_grade := 'A+';
        when v_avg >= 80 THEN v_grade := 'A';
        when v_avg >= 70 THEN v_grade := 'B';
        when v_avg >= 60 THEN v_grade := 'C';
        ELSE v_grade := 'F';
    END CASE;

    return v_grade;
END;
/


-- course_topper
CREATE OR REPLACE FUNCTION course_topper(p_course IN VARCHAR2)
RETURN VARCHAR2
IS
    v_topper_name Students.student_name%TYPE;
BEGIN
    SELECT s.student_name
    INTO v_topper_name
    FROM Students s
    JOIN (
        SELECT m.student_id, SUM(m.score) AS total
        FROM Marks m
        GROUP BY m.student_id
    ) t ON s.student_id = t.student_id
    WHERE s.course = p_course
    AND t.total = (
        SELECT MAX(SUM(score))
        FROM Marks m
        JOIN Students s2 ON s2.student_id = m.student_id
        WHERE s2.course = p_course
        GROUP BY m.student_id
    );

    RETURN v_topper_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'N/A';
END;
/