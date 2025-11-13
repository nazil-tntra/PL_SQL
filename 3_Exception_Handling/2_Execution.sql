DECLARE
   
   p_book_id Books.BOOK_ID%TYPE := 104;

   v_available_qty Books.AVAILABLE_QTY%TYPE;

   e_out_of_stock EXCEPTION;

BEGIN

    -- Getting the current of qty of book
    SELECT available_qty 
    INTO v_available_qty
    FROM BOOKS
    WHERE BOOK_ID = p_book_id;

    -- DBMS_OUTPUT.PUT_LINE('Available Qty := ' || v_available_qty);

    -- Raising the usr defined exception when out_of_stock
    IF v_available_qty = 0 THEN
        RAISE e_out_of_stock;
    END IF;


    -- Calling the issue book Procedure to issue a book
    issue_book(p_book_id);

    DECLARE
       v_total_fine NUMBER := 100;
       v_days_late NUMBER := 0;
       v_dummy_fine NUMBER;
    BEGIN   
        v_dummy_fine := v_total_fine / v_days_late;
        DBMS_OUTPUT.PUT_LINE('Fine is : ' || v_dummy_fine);
    END;
    

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: Book_Id ' || p_book_id || ' does not exist!');

        WHEN ZERO_DIVIDE THEN
            DBMS_OUTPUT.PUT_LINE('Warning: Divisio by Zero occurred!');

        WHEN e_out_of_stock THEN
            RAISE_APPLICATION_ERROR(-20001, 'Error: Book is out of stock. Can''t issue.');

        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('UnExpected Error: ' || SQLERRM);
 
END;
/

SELECT * FROM BOOKS;