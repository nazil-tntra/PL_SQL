DECLARE

    -- 3) EXECUTE IMMEDIATE
   v_product_name VARCHAR2(50) := 'Mouse';
   v_price NUMBER := 600;
   v_sql VARCHAR2(200);

   
   -- 4) Dynamic Query Retrieval
    v_table_name VARCHAR2(50) := 'PRODUCTS';
    v_count NUMBER;
    v_sql2 VARCHAR2(200);

BEGIN

    -- 3) EXECUTE IMMEDIATE
    DBMS_OUTPUT.PUT_LINE('Demonstrating EXECUTE IMMEDIATE');
    v_sql := 'UPDATE PRODUCTS SET PRICE = :new_price WHERE PRODUCT_NAME = :p_name';

    EXECUTE IMMEDIATE v_sql
        USING v_price, v_product_name;
 
    DBMS_OUTPUT.PUT_LINE('Price updated for product : ' || v_product_name);




   -- 4) Dynamic Query Retrieval
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Demonstrating Dynamic Query Retrieval');
    v_sql2 := 'SELECT COUNT(*) FROM ' || v_table_name;


    EXECUTE IMMEDIATE v_sql2 
        INTO v_count;

    DBMS_OUTPUT.PUT_LINE('COUNT of ' || v_table_name ||  ' Table = ' || v_count);

END;
/


SELECT * FROM PRODUCTS;