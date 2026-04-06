/* import */ 
title "uber"; 
proc import datafile="C:\Users\LMEDIN20\Desktop\Final\Uber.csv" 
	out=uber replace; 
	delimiter=','; 
	getnames=yes; 
run;
/* dummy*/
data uber;
    set uber;
    /* Time_of_Day (ref = Morning) */
    tod_afternoon = (Time_of_Day = "Afternoon");
    tod_evening   = (Time_of_Day = "Evening");
    tod_night     = (Time_of_Day = "Night");

    /* Day_of_Week (ref = Weekday) */
    dow_weekend   = (Day_of_Week = "Weekend");

    /* Traffic_Conditions (ref = Low) */
    traffic_medium = (Traffic_Conditions = "Medium");
    traffic_high   = (Traffic_Conditions = "High");

    /* Weather (ref = Clear) */
    weather_rain = (Weather = "Rain");
    weather_snow = (Weather = "Snow");
	run;

/*descriptives include mean,median,mode, skewness, kurtosis,standard deviation, first quartile, and third quartile etc */
proc univariate data=uber normal;
    var Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow ;
    histogram/normal(mu=est sigma=est);
    title "Distribution check";
run;
proc freq data=uber;
    tables tod_afternoon tod_evening tod_night 
           dow_weekend traffic_medium traffic_high 
           weather_rain weather_snow;
run;
proc means data=uber mean std stderr clm p25 p50 p75;
    var Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	Trip_Price tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow ;
    title "Summary Statistics for Uber Trip Data";
run;
proc gplot;
plot Trip_Price*(Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow);
run;
proc corr;
var Trip_Price Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow;
run;

/* full model*/
proc reg data=uber;
model Trip_Price =  Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow;/ STB
run;
/*multicollinearity check at full and final*/
proc reg data=uber;
model Trip_Price =  Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow/vif tol;
run;


/* outliers/influential */
proc reg data=uber;
model Trip_Price =  Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow/influence r;
plot student.*(Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow predicted.);
plot npp.*student.;
run;

data uber;
set uber;
if _n_ in (23,28,65, 96, 109, 111, 135, 138,  142, 192, 197, 198, 226, 288, 289,
303, 339, 411, 447, 492, 533, 585, 617, 726, 775, 814, 836, 840, 846, 944, 971) then delete;
run;

proc reg data=uber;
model Trip_Price =  Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow/influence r;
plot student.*(Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow predicted.);
plot npp.*student.;
run;

data uber;
set uber;
if _n_ in (9, 82, 85, 106, 134, 158, 203, 216, 255, 256, 270, 350, 385, 400, 421, 463, 625, 805, 818, 864, 911) then delete;
run;
proc reg data=uber;
model Trip_Price =  Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow/influence r;
plot student.*(Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow predicted.);
plot npp.*student.;
run;
data uber;
set uber;
if _n_ in (89, 164, 190, 195, 241, 244, 247, 252, 301, 356, 375, 379, 594, 747, 780, 872, 911, 925) then delete;
run;
proc reg data=uber;
model Trip_Price =  Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow/influence r;
plot student.*(Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow predicted.);
plot npp.*student.;
run;
data uber;
set uber;
if _n_ in (8, 152, 254, 321, 367, 377, 395, 425, 546, 590, 606, 685, 810) then delete;
run;
proc reg data=uber;
model Trip_Price =  Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow/influence r;
plot student.*(Trip_Distance_km Passenger_Count 
	Base_Fare Per_Km_Rate Per_Minute_Rate Trip_Duration_Minutes 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow predicted.);
plot npp.*student.;
run;

/*Assumption transformation */
data uber;
set uber;
	log_distance = sqrt(Trip_Distance_km);
	log_PKR = log(Per_Km_Rate);
	log_price = sqrt(Trip_Price);
	log_duration = sqrt(Trip_Duration_Minutes);
	log_fare = log(Base_Fare);
	log_Rate = log(Per_Minute_Rate);
	log_Count = log(Passenger_Count);
run;
proc reg data=uber;
model log_price =  log_distance log_Count 
	log_fare log_PKR log_Rate log_duration 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow;
plot student.* (log_distance log_Count 
	log_fare log_PKR log_Rate log_duration 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow);
plot student.*predicted.;
plot npp.*student.;
run;
proc gplot data=uber;
    plot log_price * log_distance;
	plot log_price * log_PKR;
	plot log_price *log_duration;
	plot log_price * log_fare;
	plot log_price * log_Rate;
run;

/* split data between train and test */

proc surveyselect data = uber out = uber_TT seed = 5346901
	samprate = 0.75 outall;
run;

proc print data= uber_TT;
run;


data uber_TT;
set uber_TT;
if (Selected = 1) then train_y = log_price;
run;

proc print data= uber_TT;
run;

proc reg; model train_y =log_distance log_Count 
	log_fare log_PKR log_Rate log_duration 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow/ selection= forward;
run;

proc reg; model train_y = log_distance log_Count 
	log_fare log_PKR log_Rate log_duration 
	tod_afternoon tod_evening tod_night dow_weekend traffic_medium traffic_high 
	weather_rain weather_snow/ selection= backward;
run;
/*final model */
proc reg; model train_y =  log_distance 
	log_fare log_PKR log_Rate log_duration ;
run;

/*final model checks*/
proc reg data=uber_TT;
model train_y =  log_distance 
	log_fare log_PKR log_Rate log_duration /vif tol;
run;

/* outliers/influential point 43 */
proc reg data=uber_TT;
model train_y = log_distance 
	log_fare log_PKR log_Rate log_duration /influence r;
plot student.*(predicted.);
plot npp.*student.;
run;
data uber_TT;
set uber_TT;
if _n_ in (9, 18,111,160,250,305,379,423,523,531,534,605,615,727,735,765,767) then delete;
run;
proc reg data=uber_TT;
model train_y = log_distance 
	log_fare log_PKR log_Rate log_duration /influence r;
plot student.*(predicted.);
plot npp.*student.;
run;
data uber_TT;
set uber_TT;
if _n_ in (5, 57, 160,201,204,270,291,364,390,439,446,523,682,692,892) then delete;
run;
proc reg data=uber_TT;
model train_y = log_distance 
	log_fare log_PKR log_Rate log_duration /influence r;
plot student.*(predicted.);
plot npp.*student.;
run;
/*Assymption */
proc reg data=uber_TT;
model train_y =  log_distance 
	log_fare log_PKR log_Rate log_duration;
plot student.* ( log_distance 
	log_fare log_PKR log_Rate log_duration);
plot student.*predicted.;
plot npp.*student.;
run;
proc gplot data=uber_TT;
    plot train_y * log_distance;
	 plot train_y * log_fare;
	  plot train_y * log_PKR;
	   plot train_y * log_Rate;
	    plot train_y * log_duration;
run;
/*predict */
proc reg data=uber_TT; 
	model  train_y =  log_distance 
	log_fare log_PKR log_Rate log_duration;
	output out = test_prob(where=(train_y =.)) p = yhat;
run;

proc print;
run;

data test_prob_sum;
set test_prob;
d= log_price - yhat;
absd = abs(d);
run;

proc summary data=test_prob_sum;
var d absd;
output out = test_prob_stats std(d)=rmse mean(absd)=mae;
run;
proc print data =test_prob_stats;
run;

proc corr data =test_prob;
var log_price yhat;
run;

/* prediction */
data neww;
input log_distance 
	log_fare log_PKR log_Rate log_duration;
datalines;
3.5 1.2 0.3 0.5 8
;
run;
proc print data=neww;
run;

/*combine to old data; */
data predictionn;
set neww uber_TT;
run;
proc print;
run;

proc reg data=predictionn;
model train_y =
    log_distance log_fare log_PKR log_Rate log_duration;
output out=final_prediction
    p=phat
    lcl=lcl_pred
    ucl=ucl_pred;
run;
proc print data = final_prediction;
run;

/*done_*/
