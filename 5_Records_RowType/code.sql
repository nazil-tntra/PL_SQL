/* CREATE TABLE Suppliers(
    supplier_id INT PRIMARY KEY, 
    supplier_name VARCHAR2(50), 
    contact VARCHAR2(20)
); 



INSERT INTO Suppliers VALUES (201, 'TechSource Pvt Ltd', '9876543210');
INSERT INTO Suppliers VALUES (202, 'Global Traders', '9123456780');
INSERT INTO Suppliers VALUES (203, 'Prime Electronics', '9812345678');
INSERT INTO Suppliers VALUES (204, 'Metro Wholesale', '9001234567');
INSERT INTO Suppliers VALUES (205, 'Infinity Supplies', '8899776655');
INSERT INTO Suppliers VALUES (206, 'Skyline Distributors', '9090909090');
INSERT INTO Suppliers VALUES (207, 'Digital World Suppliers', '9877001122');
INSERT INTO Suppliers VALUES (208, 'Elite Components', '9822334455');
INSERT INTO Suppliers VALUES (209, 'GreenTech Imports', '9543217890');
INSERT INTO Suppliers VALUES (210, 'SmartChoice Traders', '9988221100');
INSERT INTO Suppliers VALUES (211, 'Universal Supply Hub', '9776655443');
INSERT INTO Suppliers VALUES (212, 'NextGen Wholesale', '9665544332');
INSERT INTO Suppliers VALUES (213, 'Citywide Dealers', '9456123789');
INSERT INTO Suppliers VALUES (214, 'BrightStar Enterprises', '9345678123');
INSERT INTO Suppliers VALUES (215, 'MegaMart Suppliers', '9234567891');

SELECT * FROM PRODUCTS;
SELECT * FROM SUPPLIERS;
*/





DECLARE

    rec_product PRODUCTS%ROWTYPE;

    rec_supplier SUPPLIERS%ROWTYPE;

BEGIN

    SELECT * 
    INTO rec_product
    FROM PRODUCTS
    WHERE PRODUCT_ID = 1; 

    DBMS_OUTPUT.PUT_LINE('-- Product Details --');
    DBMS_OUTPUT.PUT_LINE(
        'Name : ' || rec_product.product_name || 
        ' | Quantity  : ' || rec_product.quantity || 
        ' | Price  : ' || rec_product.price
    );


    SELECT * 
    INTO rec_supplier
    FROM SUPPLIERS
    WHERE SUPPLIER_ID = 201;

    DBMS_OUTPUT.PUT_LINE('-- Supplier Details --');
    DBMS_OUTPUT.PUT_LINE(
        'Supplier : ' || rec_supplier.supplier_name || 
        ' | Contact : ' || rec_supplier.contact
    );


    DBMS_OUTPUT.PUT_LINE(CHR(10) || '-- All Products --');
    
    FOR product_row IN (SELECT * FROM PRODUCTS)
    LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Product : ' || product_row.product_name ||
            ' | Quantity : ' || product_row.quantity ||             
            ' | Price : ' || product_row.price
        );

    END LOOP;


    DBMS_OUTPUT.PUT_LINE(CHR(10) || '-- Combined Info --');

    DBMS_OUTPUT.PUT_LINE(
        'Product ' || rec_product.product_name ||
        ' supplied by ' || rec_supplier.supplier_name ||
        ', Quantity : ' || rec_product.quantity ||
        ' | Price : ' || rec_product.price 
    );          

END;
/


