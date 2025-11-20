DECLARE

    -- 1)
   TYPE t_products IS TABLE OF PRODUCTS%ROWTYPE;
   product_list t_products;

   -- 2)
   TYPE t_product_id IS TABLE OF PRODUCTS.PRODUCT_ID%TYPE;
   product_id_list t_product_id;

   CURSOR product_ids
    IS
        SELECT PRODUCT_ID
        FROM PRODUCTS;
        


BEGIN
 
    -- 1) BULK COLLECT
    SELECT * 
    BULK COLLECT INTO product_list
    FROM PRODUCTS
    WHERE QUANTITY < 20;

    FOR i IN 1..product_list.COUNT
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ID : ' || product_list(i).product_id ||
            ' | Name : ' || product_list(i).product_name || 
            ' | Quantity : ' || product_list(i).quantity);
    END LOOP;



    -- 2) FOR ALL
    OPEN product_ids;
        FETCH product_ids BULK COLLECT INTO product_id_list;
    CLOSE product_ids;


    FORALL i IN 1..product_id_list.COUNT
        UPDATE PRODUCTS
        SET QUANTITY = QUANTITY + 10
        WHERE PRODUCT_ID = product_id_list(i);


    DBMS_OUTPUT.PUT_LINE('Updated ' || SQL%ROWCOUNT  || ' rows.');


END;
/

SELECT * FROM PRODUCTS;