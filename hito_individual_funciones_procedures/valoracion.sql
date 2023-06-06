CREATE DEFINER=`root`@`localhost` FUNCTION `valoracion`(S INT, I INT, U INT) RETURNS varchar(50) CHARSET utf8mb4
    NO SQL
    DETERMINISTIC
BEGIN
	DECLARE resultado varchar(50);
		IF S >= I AND S >= U THEN 
			SET resultado= "Gana sonido";
		ELSEIF I >= S AND I >= U THEN 
			SET resultado= "Gana imagen";
		ELSE 
			SET resultado="Gana usabilidad";
		END IF;
	RETURN resultado;
END