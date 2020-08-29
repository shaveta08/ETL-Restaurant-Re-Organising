# Restaurant-Reorganising

## Project Proposal:

A Company owning multiple restaurants require a ETL expert to reorganise the data they have collected for the last year. 
The company have managed the data into multiple csv files so far. They want the ETL expert to transform the data into meaningful Tables and store the whole data in 
a single database. So I am going to help them manage their data and try making the whole process automated, which would ultimately help them to make analytical decisions using the transformed data stored in the database.

Basic Requirement of the company:
  1. Disintegrate the services and Resturant information into different tables.
  2. Droping null information from the datasets.
  3. Columns having some imormation needs to be preserved.
  4. Clear formatting of time and date columns.
  5. Database can be used to query the datasets using placeIDs as key.
  6. All the tables could be joined togather throught placeIDs.
  
  
## ETL Process:

### Data Source and Data Sets:
#### 1. Title of Database: Restaurant & consumer data, recommender systems domain

#### 2. Sources:
Kaggle (https://www.kaggle.com/uciml/restaurant-data-with-consumer-ratings?select=chefmozaccepts.csv)

 ### (a) Creators: 
Rafael Ponce Medellín and Juan Gabriel González Serna
rafaponce@cenidet.edu.mx, gabriel@cenidet.edu.mx
Department of Computer Science.
National Center for Research and Technological Development CENIDET, México
 ### (b) Donors of database:
Blanca Vargas-Govea and Juan Gabriel González Serna
blanca.vargas@cenidet.edu.mx/blanca.vg@gmail.com, gabriel@cenidet.edu.mx
Department of Computer Science.
National Center for Research and Technological Development CENIDET, México

Number of Files: 6

1 chefmozaccepts.csv
2 chefmozcuisine.csv
3 chefmozhours4.csv
4 chefmozparking.csv
5 geoplaces2.csv
6 rating_final.csv


## Extract:

Initally, I have loaded all the datasets in the Pandas Dataframe using read_csv function. Most of the process was smooth as data was already in the
table format.
But During the transformation process, I observed other files chefmozaccepts.csv, chefmozcuisine.csv, chefmozhours4.csv, chefmozparking.csv has some other resturants or placeIDs information also. Therefore I made sure to extract the placeIDs in the dataset which have same placeIds as in geoplaces2.csv.

Also, I made sure along the way, there should be no null values in the datasets.

I have loaded the main dataset and basic checks for null values and removing duplicates are done here.

## Transform:
Pandas and jupyter notebooks used for cleaning, joining, filtering, aggregating the datasets.

### 1. geoplaces2.csv : 
  * Above we checked the total number of non-null values is 130 in all the columns, but if we analyse the dataset further, we can see certain values are given as '?' rather than null.
  * Before dealing with '?' values we will discard all the columns which are not needed for analysation purposes or has bad data in them.

  * The columns not needed for analysis is:
    1. lat and lng and geo_meter: we already have destails of city and country.
    2. Address: Since all of its information is already in columns such as city, state, country
    3. Fax: Since all the values in this columns is "?"
    4. url : This columns has only data value for the one resturant.
    5. Also Area, OtherServices, Rambiance , accessibility are sone other columns not needed for the analysation purpose because they also dont have enough data or inconsistence data in them 
    
* We can see above they are so many in-consistence values in city, state and country. forexample: tamaulipas and Tamaulipas are considered as two different values.
* Therefore, making all the values consistence by putting them in lowercase.
* Similarly, we have inconsistence values in the city column because victoria is written as "cd victoria" or "cd .victoria".
* We have used the regex to fix up the inconsistency in the city column
* Lastly we will fill out the value as "none" in case it is mentioned as "?" in the dataset.
* We are keeping these values as none for two reasons:
    1. Rows having "?" as value in some columns cannot be dropped out because they have some curical information in other columns.
    2. Columns having "?" as values cannot be dropped out becuase they have correct information for other rows in the dataset.
    
* Now we can divide the resturant information into two meaningful dataset:
    1. resturant_info: It would contain the information regarding resturant.(plcaeID,city,state,country,name,price,franchise)
    2. resturant_services: It would contain the information regarding resturant service.(placeID,alchohol,smoking_area,dress_code,area)
    
### 2. chefmozaccepts.csv:

* Check for unique values in payment method and converting everything into small case.
* Grouping the number of payment methonds by placeIDs.

### 3. chefmozcuisine.csv:

* Few 'Rcuisine' values can be merged together for better understanding. such as:
    1. 'bar' and 'bar_pub_brewery
    2. 'burgers' and 'fast_food'
    3. 'contemporary' and 'mediterranean'
    4. 'family' and 'regional'
    
### 4. chefmozhours4.csv:

* columns like hours and days are not in the format for analysation, Also they dont serve any purpose in giving off any meaningful information about working hours.
* We will disintegrate the columns and convert them into meaningful information.
* We have certain hours giving working timings as  '00:00-00:00' which means those days resturant is closed.
* we will remove all such rows from the dataset.
* Current format of 'days' columns is given as Mon;Tue;Wed;Thu;Fri; , sat, sun and calculate the total number of days resturant is open.
* Therefore we will replace the values stored in the dataset to number of days by following the below rules:
    1. 'Mon;Tue;Wed;Thu;Fri;' --> 5
    2. 'Sat;' --> 1
    3. 'Sun;' --> 1
    
* Then Converting the column type to numeric.
* Working with column 'hours'
* In this column we have data given in following format:
    opentime-endtime for example: 08:00-21:00
* We will calculate the total time by doing calculation (endtime-opentime)
* To perform any calculation we will first split the string into opentime and endtime.
* After splitting the string, we have used datetime to convert string into datetime format for further calculations.

### 5. chefmozparking.csv:

* Unique values for parking facilites are : 'none', 'yes', 'public', 'valet parking'
* we replacing 'yes' values to 'private parking'

### 6. rating_final.csv:

* In this dataset we have data based on the multiple users giving ratings to each resturant.
* We will transform the dataset by droping the userID column and grouping the dataset based on placeID.
* We will calculate the average of ratings given by the users to each resturant and keep that one as final ratings.
* Grouping the dataset based on the placeID and finding average of the ratings 
* Joining the rating table with resturant_info tables, to make ratings part of the resturant_info table.


## Loading : 

In Postgresql:
We have created the tables in postgressql in the following displayed structured:
![alt text](https://github.com/shaveta08/Restaurant-Re-Organising/blob/master/struct.png?raw=true)



### Improvment not done due to time crunch.

1. Filling up the zip and country based on longitude and latitude using googlemapsApis.




