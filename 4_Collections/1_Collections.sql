/* 

CREATE TABLE Products (
    product_id    INT PRIMARY KEY,
    product_name  VARCHAR2(50),
    quantity      NUMBER,
    price         NUMBER
);

INSERT INTO Products VALUES (1, 'Laptop', 15, 55000);
INSERT INTO Products VALUES (2, 'Mobile Phone', 25, 22000);
INSERT INTO Products VALUES (3, 'Keyboard', 8, 1200);
INSERT INTO Products VALUES (4, 'Mouse', 5, 600);
INSERT INTO Products VALUES (5, 'Headphones', 12, 1500);
INSERT INTO Products VALUES (6, 'Smart Watch', 4, 3000);
INSERT INTO Products VALUES (7, 'Gaming Console', 7, 35000);
INSERT INTO Products VALUES (8, 'Monitor', 18, 8000);
INSERT INTO Products VALUES (9, 'USB Cable', 50, 150);
INSERT INTO Products VALUES (10, 'Power Bank', 9, 1000);

COMMIT;
 */


DECLARE

    --  ASSOCIATIVE ARRAY 
   TYPE product_name_aat IS TABLE OF VARCHAR2(50)
        INDEX BY PLS_INTEGER;

    l_product_names product_name_aat;


    -- Nested Array
    TYPE quantity_nt IS TABLE OF NUMBER;
    l_quantities quantity_nt := quantity_nt();
    
    v_total_quantity NUMBER := 0;


    -- VARRAY
    TYPE product_varray IS VARRAY(5) OF VARCHAR2(50);
    l_varray product_varray;

BEGIN
    
    -- Storing data from table to Collections
    FOR record IN (SELECT product_id, product_name, quantity FROM PRODUCTS)
    LOOP

        l_product_names(record.product_id) := record.product_name;
        l_quantities.EXTEND;
        l_quantities(l_quantities.COUNT) := record.quantity;
    END LOOP;



    -- Displaying the content of Associative Array
    DBMS_OUTPUT.PUT_LINE('--- Associative Array Output ---');

    FOR i IN 1..l_product_names.COUNT
    LOOP
        IF l_product_names.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE('Product ID:' || i || ' | Product Name:'|| l_product_names(i));
        END IF;
    END LOOP;


    -- Counting the total Quantity
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Nested Table Quantities ---');
    FOR i IN 1..l_quantities.COUNT LOOP
        v_total_quantity := v_total_quantity + l_quantities(i);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total Quantity: '|| v_total_quantity);



    -- VARRAY
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- VARRAY Output ---');
    l_varray := product_varray('Laptop','Mobile','Headphones','Keyboard','Mouse');

    FOR i IN 1..l_varray.COUNT 
    LOOP
        DBMS_OUTPUT.PUT_LINE('VARRAY(' || i || '): ' || l_varray(i));
    END LOOP;



    -- Collection Methods
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Collection Methods Demo ---');

    -- 1) Deleting the Elem
    DBMS_OUTPUT.PUT_LINE('Before DELETE, quantities count: ' || l_quantities.COUNT);

    l_quantities.DELETE(1);

    DBMS_OUTPUT.PUT_LINE('After DELETE(1), quantities count: ' || l_quantities.COUNT);


    -- 2) EXTEND
    l_quantities.EXTEND;
    l_quantities(l_quantities.COUNT) := 99;

    DBMS_OUTPUT.PUT_LINE('After EXTEND, quantities count: ' || l_quantities.COUNT);

END;
/
