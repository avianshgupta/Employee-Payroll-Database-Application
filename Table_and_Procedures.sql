CREATE TABLE Emp_Payroll(
eid varchar2(4) CONSTRAINT Empid_pk PRIMARY KEY,
ename varchar2(15),
dob date,
sex varchar2(1),
designation varchar2(20),
basic float(8),
da float(8),
hra float(8),
pf float(8),
mc float(8),
gross float(8),
tot_deduc float(8),
net_pay float(8));

CREATE OR REPLACE PROCEDURE calNet_Pay
(id IN Emp_Payroll.eid%TYPE,BP IN Emp_Payroll.basic%TYPE) IS
	DAt Emp_Payroll.da%TYPE;
	HRAt Emp_Payroll.hra%TYPE;	
	PFt Emp_Payroll.pf%TYPE;
	MCt Emp_Payroll.mc%TYPE;
	GROSSt Emp_Payroll.gross%TYPE;
	TOT_DED Emp_Payroll.tot_deduc%TYPE;
	NP Emp_Payroll.net_pay%TYPE;
BEGIN
	DAt:= 0.6*BP;
	HRAt:= 0.11*BP;
	PFt:= 0.04*BP;
	MCt:= 0.03*BP;
	GROSSt:= BP+DAt+HRAt;
	TOT_DED:= PFt+MCt;
	NP:= GROSSt-TOT_DED;
	update Emp_Payroll
	set da = DAt,
	hra = HRAt,
	pf = PFt,
	mc = MCt,
	gross = GROSSt,
	tot_deduc = TOT_DED,
	net_pay = NP
	where eid = id;
END;

CREATE OR REPLACE PROCEDURE insertEmp
(id IN Emp_Payroll.eid%TYPE,name IN Emp_Payroll.ename%TYPE,birthd IN date,gender IN Emp_Payroll.sex%TYPE,desig IN Emp_Payroll.designation%TYPE,bp IN Emp_Payroll.basic%TYPE) IS
BEGIN
	insert into Emp_Payroll values(id,name,birthd,gender,desig,bp,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
	calNet_Pay(id,bp);
END;

CREATE OR REPLACE PROCEDURE updateEmp
(id IN Emp_Payroll.eid%TYPE,name IN Emp_Payroll.ename%TYPE,birthd IN date,gender IN Emp_Payroll.sex%TYPE,desig IN Emp_Payroll.designation%TYPE,bp IN Emp_Payroll.basic%TYPE) IS
BEGIN
	update Emp_Payroll
	set ename = name,dob = birthd,sex = gender,designation = desig,basic = bp
	where eid = id;
	calNet_Pay(id,bp);
END;

CREATE OR REPLACE PROCEDURE deleteEmp
(id IN Emp_Payroll.eid%TYPE) IS
BEGIN
	delete from Emp_Payroll where eid = id;
	IF SQL%FOUND THEN
		dbms_output.put_line('Delete Successful '||id);
	ELSE
		dbms_output.put_line('EID Not Found '||id);
	END IF;
END;
		
CREATE OR REPLACE PROCEDURE searchEmp
(id IN Emp_Payroll.eid%TYPE) IS
	entry Emp_Payroll%ROWTYPE;
	CURSOR c1 IS select * from Emp_Payroll where eid = id;
BEGIN
	OPEN c1;
	FETCH c1 INTO entry;
	IF c1%FOUND THEN
		dbms_output.put_line('Eid: '||entry.eid);
		dbms_output.put_line('Name: '||entry.ename);
		dbms_output.put_line('DOB: '||entry.dob);
		dbms_output.put_line('Gender: '||entry.sex);
		dbms_output.put_line('Designation: '||entry.designation);
		dbms_output.put_line('Basic Pay: '||entry.basic);
		dbms_output.put_line('DA: '||entry.da);
		dbms_output.put_line('HRA: '||entry.hra);
		dbms_output.put_line('PF: '||entry.pf);
		dbms_output.put_line('MC: '||entry.mc);
		dbms_output.put_line('Gross Pay: '||entry.gross);
		dbms_output.put_line('Deductions: '||entry.tot_deduc);
		dbms_output.put_line('Net Pay: '||entry.net_pay);
	ELSE
		dbms_output.put_line('EID Not Found');
 	END IF;
END;


CREATE OR REPLACE FUNCTION search_Emp
(id IN Emp_Payroll.eid%TYPE) RETURN int IS
	entry Emp_Payroll%ROWTYPE;
	CURSOR c1 IS select * from Emp_Payroll where eid = id;
BEGIN
	OPEN c1;
	FETCH c1 INTO entry;
	IF c1%FOUND THEN
		RETURN 1;
	ELSE
		RETURN 0;
 	END IF;
END;

DECLARE
num varchar2(4);
BEGIN
num:='&eid';
dbms_output.put_line('Output: '||search_Emp(num));
END;
/


CREATE OR REPLACE PROCEDURE deleteEmp
(id IN Emp_Payroll.eid%TYPE) IS
BEGIN
	delete from Emp_Payroll where eid = id;
END;