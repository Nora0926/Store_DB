create database StoreSys;
use storeSys;

create table store
	(storeID		varchar(6) not null, 
	 store_name		varchar(15) not null, 
	 address		varchar(50),
     store_PhoneNum	varchar(13),
	 primary key (storeID)
	);
    
create table employee
	(empID		varchar(6) not null, 
     emp_name	varchar(4) not null, 
     position	varchar(3), 
     salary		numeric(6, 0) check (salary > 100000),
     primary key (empID)
    );
    
create table distriCenter
	(centerID		 varchar(6) not null,
     center_name	 varchar(15) not null,
     address		 varchar(50),
     center_PhoneNum varchar(13),
     primary key (centerID)
    );
    
create table consumer
	(consumID		varchar(6) not null,
     consum_name	varchar(4) not null,
     address		varchar(50) not null,
     consum_PhonNum varchar(13),
     primary key (consumID)
    );
    
create table product
	(productID		varchar(6) not null,
     product_name	varchar(10) not null,
     setProductID		varchar(10) default null,
     foreign key (setProductID) references product(productID),
     primary key (productID)
    );
    
    
create table delivMan
	(delivID		 varchar(6) not null,
     deliv_name		 varchar(4) not null,
     deliv_PhoneNum	 varchar(13),
     primary key (delivID)
    );
    
    drop table takeBack;
    
create table takeBack
	(backID		varchar(6),
     productId	varchar(6),
     backDate	date,
     reason		varchar(50),
     foreign key (productID) references product(productID),
     primary key (backID)
    );
    
create table supply
	(productID	varchar(6),
	 storeID	varchar(6),
	 centID		varchar(6),
     foreign key (productID) references product(productID),
     foreign key (storeID) references store(storeID),
     foreign key (centID) references distriCenter(centerID),
     primary key (productID, storeID, centID)
    );
    
create table storeWork
	(storeID	varchar(6),
	 empID		varchar(6),
     managerID	varchar(6),
     foreign key (storeID) references store(storeID),
     foreign key (empID) references employee(empID),
     primary key (storeID, empID)
    );

create table centerWork
	(centID	varchar(6),
	 empID		varchar(6),
     managerID	varchar(6),
     foreign key (centID) references distriCenter(centerID),
     foreign key (empID) references employee(empID),
     primary key (centID, empID)
    );
    
    
create table reservation
	(consumID		varchar(6),
	 delivID		varchar(6),
     reservDate		date,
     delivDate date generated always as (date_add(reservDate, interval 3 day)),
     foreign key (consumID) references consumer(consumID),
     foreign key (delivID) references delivMan(delivID),
     primary key (consumId, delivID)
    );
