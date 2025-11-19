/* 

    CREATE TABLE Products(
        product_id INT PRIMARY KEY, 
        product_name VARCHAR2(50), 
        quantity NUMBER, 
        price NUMBER
    );


    INSERT INTO PRODUCTS VALUES(1,  'Laptop',             15, 55000);
    INSERT INTO PRODUCTS VALUES(2,  'Smartphone',         30, 20000);
    INSERT INTO PRODUCTS VALUES(3,  'Wireless Mouse',     45, 500);
    INSERT INTO PRODUCTS VALUES(4,  'Mechanical Keyboard', 25, 3500);
    INSERT INTO PRODUCTS VALUES(5,  'Monitor 24-inch',    10, 12000);
    INSERT INTO PRODUCTS VALUES(6,  'USB-C Charger',      50, 800);
    INSERT INTO PRODUCTS VALUES(7,  'Bluetooth Speaker',  18, 2500);
    INSERT INTO PRODUCTS VALUES(8,  'Webcam HD',          22, 1500);
    INSERT INTO PRODUCTS VALUES(9,  'External HDD 1TB',   12, 4500);
    INSERT INTO PRODUCTS VALUES(10, 'Graphics Card GTX',   5, 32000);


    CREATE TABLE Products_Log (
        log_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        product_id INT,
        action VARCHAR2(20),
        action_date DATE
    );



 */


CREATE OR REPLACE TRIGGER check_product_quantity 
BEFORE INSERT ON PRODUCTS
FOR EACH ROW
BEGIN
 
  IF :NEW.quantity < 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Quantity cannot be negative!');
  END IF;

END;
/


CREATE OR REPLACE TRIGGER validate_price_update 
BEFORE UPDATE OF PRICE ON PRODUCTS
FOR EACH ROW
BEGIN

  IF :NEW.price < 1 THEN
      RAISE_APPLICATION_ERROR(-20002, 'Price must be at least 1!');
  END IF;

END;
/



CREATE OR REPLACE TRIGGER log_new_product
AFTER INSERT ON PRODUCTS
FOR EACH ROW
BEGIN

  INSERT INTO PRODUCTS_LOG (PRODUCT_ID, ACTION, ACTION_DATE)
  VALUES (:NEW.PRODUCT_ID, 'INSERT',SYSDATE);

END;
/


CREATE OR REPLACE TRIGGER prevent_delete_low_stock 
BEFORE DELETE ON PRODUCTS
FOR EACH ROW
BEGIN

  IF :OLD.Quantity > 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 
            'Cannot delete product with stock available! Quantity must be 0.');
  END IF;

END;
/


SELECT * FROM PRODUCTS;

UPDATE Products SET price = 0 WHERE product_id = 1;

SELECT * FROM PRODUCTS_LOG;

INSERT INTO Products VALUES (103, 'Monitor', 5, 6000);

SELECT * FROM PRODUCTS_LOG;

DELETE FROM Products WHERE product_id = 1;