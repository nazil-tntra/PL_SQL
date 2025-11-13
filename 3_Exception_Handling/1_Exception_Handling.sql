/* CREATE TABLE Books(
    book_id INT PRIMARY KEY, 
    book_name VARCHAR2(50), 
    available_qty NUMBER
); 


INSERT INTO Books VALUES (101, 'Database Management Systems', 3);
INSERT INTO Books VALUES (102, 'Operating System Concepts', 0);
INSERT INTO Books VALUES (103, 'Data Structures and Algorithms', 2);
INSERT INTO Books VALUES (104, 'Computer Networks', 5);
INSERT INTO Books VALUES (105, 'Introduction to Java Programming', 4);
INSERT INTO Books VALUES (106, 'Python for Data Science', 1);
INSERT INTO Books VALUES (107, 'Web Development with React', 6);
INSERT INTO Books VALUES (108, 'Node.js in Action', 2);
INSERT INTO Books VALUES (109, 'Software Engineering: A Practitioner’s Approach', 0);
INSERT INTO Books VALUES (110, 'Cloud Computing Fundamentals', 3);
INSERT INTO Books VALUES (111, 'Artificial Intelligence: Modern Approach', 2);
INSERT INTO Books VALUES (112, 'Machine Learning with Python', 4);
INSERT INTO Books VALUES (113, 'Cybersecurity Essentials', 1);
INSERT INTO Books VALUES (114, 'Computer Architecture and Organization', 5);
INSERT INTO Books VALUES (115, 'Introduction to SQL and PL/SQL', 7);

COMMIT;



CREATE OR REPLACE PROCEDURE issue_book(p_book_id IN NUMBER) 
IS
    v_book_name Books.BOOK_NAME%TYPE;
    v_available_qty Books.AVAILABLE_QTY%TYPE;
BEGIN

    SELECT BOOK_NAME, AVAILABLE_QTY
    INTO v_book_name, v_available_qty
    FROM BOOKS
    WHERE BOOK_ID = p_book_id;


    UPDATE BOOKS
    SET AVAILABLE_QTY = AVAILABLE_QTY - 1
    WHERE BOOK_ID = p_book_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(v_book_name || ' book issued successfully, Remaining Qty : ' || (v_available_qty - 1));

END;

*/





