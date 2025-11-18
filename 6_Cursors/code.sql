/* 
CREATE TABLE Product_Suppliers(
    product_id INT not null, 
    supplier_id INT not null,


    CONSTRAINT fk_ps_product 
        FOREIGN KEY (product_id)
        REFERENCES products (product_id)
        ON DELETE CASCADE,


    CONSTRAINT fk_ps_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers (supplier_id)
        ON DELETE CASCADE
    
)



-- Product 1 supplied by Supplier 1 and 2
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (1, 1);
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (1, 2);

-- Product 2 supplied by Supplier 2 and 3
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (2, 2);
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (2, 3);

-- Product 3 supplied by Supplier 1 and 4
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (3, 1);
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (3, 4);

-- Product 4 supplied by Supplier 5
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (4, 5);

-- Product 5 supplied by Supplier 3 and 6
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (5, 3);
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (5, 6);

-- Product 6 supplied by Supplier 7
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (6, 7);

-- Product 7 supplied by Supplier 4 and 8
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (7, 4);
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (7, 8);

-- Product 8 supplied by Supplier 9
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (8, 9);

-- Product 9 supplied by Supplier 10
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (9, 10);

-- Product 10 supplied by Supplier 1 and 7
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (10, 1);
INSERT INTO Product_Suppliers (product_id, supplier_id) VALUES (10, 7);

 */


 DECLARE
   
   CURSOR low_stock_cur 
   IS
    SELECT product_id, product_name, price, quantity 
    FROM PRODUCTS
    WHERE QUANTITY < 20;

    v_id PRODUCTS.PRODUCT_ID%TYPE;
    v_name PRODUCTS.PRODUCT_NAME%TYPE;
    v_price PRODUCTS.PRICE%TYPE;
    v_quantity PRODUCTS.QUANTITY%TYPE;


    CURSOR supplier_product_cur (p_supplier_id NUMBER)
    IS
        SELECT P.PRODUCT_NAME,
                P.QUANTITY,
                S.supplier_name
            
            FROM PRODUCTS P
            JOIN PRODUCT_SUPPLIERS PS ON P.PRODUCT_ID = PS.PRODUCT_ID
            JOIN SUPPLIERS S ON S.SUPPLIER_ID = PS.SUPPLIER_ID

            WHERE PS.SUPPLIER_ID = p_supplier_id;


BEGIN

    /* 1) */
    OPEN low_stock_cur;
    DBMS_OUTPUT.PUT_LINE('--- LOW STOCK PRODUCTS (QTY < 20) ---');

    LOOP
        FETCH low_stock_cur 
        INTO v_id, v_name, v_price, v_quantity;

        EXIT WHEN low_stock_cur%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Product ' || v_name || ' is low in stock with ' || v_quantity ||' units.');
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total low-stock records processed: ' || low_stock_cur%ROWCOUNT);

    IF low_stock_cur%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is still open, closing now...');
        CLOSE low_stock_cur;
    END IF;



    /* 2) */
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- PRODUCTS FROM SUPPLIER (SUPPLIER ID = 1) ---');

    FOR rec in supplier_product_cur(1)
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Supplier: '   || rec.supplier_name ||
            ' | Product: ' || rec.product_name  ||
            ' | Qty: '     || rec.quantity
        );
    END LOOP;
 
END;
/


SELECT * FROM PRODUCTS;
SELECT * FROM SUPPLIERS;
SELECT * FROM Product_Suppliers;