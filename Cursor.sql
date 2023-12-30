-- Cursor
-- It is used to navigate inside a table. 
-- Cursor always navigates in one direction precisely from top to bottom.
-- Cursor is always called inside a procedure.

DELIMITER $$
CREATE PROCEDURE getFullName ( INOUT fullNameList VARCHAR(4000) )

BEGIN

  DECLARE finished INTEGER DEFAULT 0;
  DECLARE fullName VARCHAR(100) DEFAULT "";
  
   # 1) Cursor declaration
	DECLARE curName CURSOR FOR SELECT CONCAT(contactFirstName ,',' , contactLastName) FROM customers LIMIT 10;
	
    # 2) Declare NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    # 3) Open cursor
	OPEN curName;
   
   # 4) Fetch the records
               GETNAME: LOOP
                              FETCH curName INTO fullName;
                              IF finished = 1 THEN LEAVE GETNAME;
                              END IF;
                              SET fullNameList = CONCAT(fullName,";",fullNameList);
               END LOOP GETNAME;
               
               # 5) Close the Cursor
               CLOSE curName;
END $$
DELIMITER ;


SET @fullNameList = "";

CALL getFullName(@fullNameList);
