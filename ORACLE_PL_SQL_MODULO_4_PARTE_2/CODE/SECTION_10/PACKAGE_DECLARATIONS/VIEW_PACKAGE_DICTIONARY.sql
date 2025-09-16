SELECT text
	FROM user_source
	WHERE name = 'SALARY_PKG' AND type = 'PACKAGE BODY'
	ORDER BY line;
    
SELECT text
	FROM user_source
	WHERE name = 'SALARY_PKG' AND type = 'PACKAGE'
	ORDER BY line;