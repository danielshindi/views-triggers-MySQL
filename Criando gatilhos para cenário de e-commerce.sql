/*
Parte 2 – Criando gatilhos para cenário de e-commerce 
*/

use ecommerce;
show tables;
select * from clients;
desc clients;

create table inactive_clients(
	idClient int,
    Fname varchar(45),
    Minit char(3),
    Lname varchar(20),
    CPF char(11),
    Address varchar(255),
    Bdate date,
    CNPJ char(14)
);

-- Criação da trigger de remoção: before delete

delimiter //
create trigger delete_user before delete on clients
for each row
begin
	insert into inactive_clients values (old.idClient,
										 old.Fname,
                                         old.Minit,
                                         old.Lname,
                                         old.CPF,
                                         old.Address,
                                         old.Bdate,
                                         old.CNPJ);
end //
delimiter ;										
                     
-- Cenário de company_constraints
use company_constraints;
show tables;
select * from employee;					
                    
-- Criação da trigger de atualização: before update
delimiter //
create trigger update_salary before update on employee
for each row
begin
	if new.Salary <= 25000 then
		set new.Salary = new.Salary * 1.2;
	elseif new.Salary > 25000 and new.Salary <= 40000 then
		set new.Salary = new.Salary * 1.1;
	elseif new.Salary > 40000 then
		set new.Salary = new.Salary * 1.05;
	end if;
end //
delimiter ;
