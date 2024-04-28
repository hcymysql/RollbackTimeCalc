use mysql; 

DELIMITER $$

CREATE FUNCTION RollbackTimeCalc(processID INT, timeInterval INT)

RETURNS VARCHAR(225)

DETERMINISTIC

BEGIN  
  DECLARE RollbackModifiedBeforeInterval INT;  
  DECLARE RollbackModifiedAfterInterval INT;

  DECLARE RollbackPendingRows INT;  
  DECLARE Result varchar(20);

      SELECT trx_rows_modified INTO RollbackModifiedBeforeInterval from information_schema.innodb_trx where trx_mysql_thread_id = processID and trx_state = 'ROLLING BACK';

      do sleep(timeInterval);

      SELECT trx_rows_modified INTO RollbackModifiedAfterInterval from information_schema.innodb_trx where trx_mysql_thread_id = processID and trx_state = 'ROLLING BACK';

      set Result=SEC_TO_TIME(round((RollbackModifiedAfterInterval*timeInterval)/(RollbackModifiedBeforeInterval-RollbackModifiedAfterInterval)));

      SELECT trx_rows_modified INTO RollbackPendingRows from information_schema.innodb_trx where trx_mysql_thread_id = processID and trx_state = 'ROLLING BACK';

      RETURN(CONCAT('Estimation Time of Rollback : ', Result, ' Pending rows to rollback ', RollbackPendingRows));

END$$

DELIMITER ;
