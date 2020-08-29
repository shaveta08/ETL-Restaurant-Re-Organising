create table restaurant_info(
"placeID" INT PRIMARY KEY,
"name" VARCHAR(150),
"city" VARCHAR(50),
"state" VARCHAR(50),
"country" VARCHAR(50),
"price" VARCHAR(50),
"franchise" VARCHAR(50),
"rating" FLOAT,
"food_rating" FLOAT,
"service_rating" FLOAT
);

create table resturant_services(
	"placeID" INT PRIMARY KEY,
	"alcohol" VARCHAR(50),
	"smoking_area" VARCHAR(50),
	"dress_code" varchar(50),
	"area" VARCHAR(50),
	FOREIGN KEY ("placeID") REFERENCES restaurant_info("placeID")
);
select * from resturant_services;

create table restaurant_payment_method(
"placeID" INT,
	"Rpayment" VARCHAR(50),
	FOREIGN KEY ("placeID") REFERENCES restaurant_info("placeID")
);

select * from restaurant_payment_method;

create table workinghours(
"placeID" INT,
	"hours" VARCHAR(50),
	"days" INT,
	"Total_hours" VARCHAR(50),
	FOREIGN KEY ("placeID") REFERENCES restaurant_info("placeID")
);
select * from workinghours;

create table parking(
"placeID" INT,
	"parking_lot" VARCHAR(50),
	FOREIGN KEY ("placeID") REFERENCES restaurant_info("placeID")
);
select * from parking;

create table cuisine(
"placeID" INT,
	"Rcuisine" VARCHAR(50),
	FOREIGN KEY ("placeID") REFERENCES restaurant_info("placeID")
);

-- select * from cuisine;

-- select cuisine."placeID","Rcuisine" , name from cuisine,restaurant_info where restaurant_info."placeID" =cuisine."placeID"; 

