select  

NOW() as CURRENT_DATE_TIME, # Get current Date and Time using now() function
CURDATE() as SYSTEM_DATE, # Get System Date
DATE(NOW()) as Today_DATE, # Get the current date from now() function using date() function

# Get DAY(), MONTH(), QUARTER(), YEAR() values from given date using below functions

DAY(NOW()) as day, # Get the current day using DAY() function ,
MONTH(NOW()) as current_month, # Get the current month using MONTH() function,
QUARTER(NOW()) as current_qurater, # Get the current quarter using QUARTER() function,
YEAR(NOW()) as current_year, # Get the current year using YEAR() function

# Get Week(), WeekDay(), Weekofyear() from below functions

WEEK(NOW()) as CURRENT_WEEK, # Get Current week number,
WEEKOFYEAR(NOW()) AS WEEK_OF_YEAR,
WEEKDAY(NOW()) as WEEK_DAY, # Get current day of week using WEEKDAY function, 

DATE_FORMAT(NOW(), '%m-%d-Y') as USA_DATE, # Convert givent date to mm-dd-yyyy format using DATE_FORMAT function,
DATEDIFF(NOW(), "2016-12-26") as DATES_DIFFERENCE, # Get the difference between two dates using DATEDIFF function,

# DATE ADD Function to increment dates
DATE_ADD(NOW(), INTERVAL 1 DAY) as 'One day Later', # add 1 day to current date using DATE_ADD function and INTERVAL 1 day
DATE_ADD(NOW(), INTERVAL 1 Week) as 'one week later', # Similarly Adding 1 week to current date using INTERVAL 1 week
DATE_ADD(NOW(), INTERVAL 1 MONTH) as 'One month later',

# Date subtract function to subtract dates
DATE_SUB(NOW(),  INTERVAL 1 year) as 'One year before', # Get one year before date,
DATE_SUB(NOW(), INTERVAL 1 month) as 'One month before' # Get one month before date

#output
CURRENT_DATE_TIME	SYSTEM_DATE	Today_DATE	day	current_month	current_qurater	current_year	CURRENT_WEEK	WEEK_OF_YEAR	WEEK_DAY	USA_DATE	DATES_DIFFERENCE	One day Later	one week later	One month later	One year before	One month before
26.12.2017 08:53:34	26.12.2017 00:00:00	26.12.2017 00:00:00	26	12	4	2017	52	52	1	12-26-Y	365	27.12.2017 08:53:34	02.01.2018 08:53:34	26.01.2018 08:53:34	26.12.2016 08:53:34	26.11.2017 08:53:34

