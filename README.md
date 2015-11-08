# GreenSync Coding Exercise

## Background

Greentastic Electricity Supply Concern is looking to expand into retail electricity price
trading.  As a start, they're looking to do some analysis on previous price data.  To begin with,
they were looking for the minimum, maximum and average retail price of electricity in Victoria.
They're now looking to expand that analysis, with more data, and more in-depth statistics.

This codebase represents the first version, and contains the 2014 data.  It works, but it's far
too slow; and the new features need to be built.

## The exercise

Most of the tasks focus on the daily-stats script, and its operation, except the first one.

For all of these tasks, give a short summary of the decisions taken and the changes made, and your
motivations for them.  Submit your solution as a git repo.

The task should take at most a few hours.

1. Get the 2013 data using script/fetch-data.

2. Improve the performance of the daily stats generator -- it should probably be an
   order-of-magnitude faster.  Currently it takes around three minutes to process 12 months
   worth of data on the machines that G.E.S.C. is using.

3. Add a column that describes the time period the statistic relates to ("day" for the current
   version).

4. Add a row at the start of every month that calculates the statistics for that month (time
   period = "month"), and a row at the start of every year which has the statistics for that
   year (time period = "year").  Just use the date of the first day as the date.

5. If you have the time, add the median, variance and standard deviation.  (median_rrp,
   rrp_variance, rrp_standard_deviation)

## Example output

```
period,date,min_rrp,max_rrp,average_rrp
year,2014-01-01,-14863,597227,4162
month,2014-01-01,-2570,597227,7243
day,2014-01-01,-267,4560,3695
day,2014-01-02,3658,4868,4392
day,2014-01-03,3904,4711,4408
day,2014-01-04,3820,4668,4279
day,2014-01-05,3676,4515,4046
day,2014-01-06,3406,4573,4272
```

## Getting it running.

- It uses Bundler and has a .ruby-version -- so RVM or rbenv or equivalent should get you going.
- To run the tests, just run "rake"
- To run the script that generates the output data, run "script/daily-stats".  The CSV is
  generated to stdout.
- There is another script, "script/fetch-data" that will re-fetch the data from the AEMO website.

## Notes

- The data are all in UTC+10 -- there is no daylight savings; the code treats them as UTC as a
  shortcut to dealing with them properly.
- As with most electricity metering data, the timestamps are the *end* of the time period they're
  covering -- i.e. 13:30 represents the time period from 13:00 to 13:30.  (Strictly speaking it
  doesn't actually include 13:30:00, but all the time leading up to it.)  So to get the price at a
  given time, you round up to the nearest half hour -- e.g. 15:11 rounds up to 15:30, so that's
  the row that corresponds.

## Results


/home/ubuntu/workspace/data/DATA201406_VIC1.csv
/home/ubuntu/workspace/data/DATA201408_VIC1.csv
/home/ubuntu/workspace/data/DATA201402_VIC1.csv
/home/ubuntu/workspace/data/DATA201401_VIC1.csv

/home/ubuntu/workspace/data/DATA201403_VIC1.csv
/home/ubuntu/workspace/data/DATA201410_VIC1.csv
/home/ubuntu/workspace/data/DATA201409_VIC1.csv
/home/ubuntu/workspace/data/DATA201404_VIC1.csv

/home/ubuntu/workspace/data/DATA201411_VIC1.csv
/home/ubuntu/workspace/data/DATA201405_VIC1.csv
/home/ubuntu/workspace/data/DATA201407_VIC1.csv
/home/ubuntu/workspace/data/DATA201412_VIC1.csv

Time taken in reading files: 
37.95 seconds
day,date,min_rrp,max_rrp,average_rrp,median_rrp,rrp_variance,rrp_std_deviation
Wed 01 Jan 2014,-267,4560,3695,4160,1276795,1130
Thu 02 Jan 2014,3658,4868,4392,4520,91382,302
Fri 03 Jan 2014,3904,4711,4408,4399,15296,124
Sat 04 Jan 2014,3820,4668,4279,4347,57882,241
Sun 05 Jan 2014,3676,4515,4046,3995,41467,204
Mon 06 Jan 2014,3406,4573,4272,4393,86567,294
Tue 07 Jan 2014,3581,4478,4194,4349,58858,243
Wed 08 Jan 2014,3539,4521,4279,4418,104819,324
Thu 09 Jan 2014,3791,5785,4736,4720,279450,529
......
Thu 18 Dec 2014,1524,4039,2661,2815,398705,631
Fri 19 Dec 2014,1420,3225,2374,2484,211577,460
Sat 20 Dec 2014,1464,3298,2317,2340,188864,435
Sun 21 Dec 2014,1420,3432,2319,2388,469145,685
Mon 22 Dec 2014,1425,4775,3129,3280,709700,842
Tue 23 Dec 2014,2224,4625,3365,3391,216392,465
Wed 24 Dec 2014,1420,2905,2420,2605,174150,417
Thu 25 Dec 2014,686,2042,1430,1436,88942,298
Fri 26 Dec 2014,1013,2021,1690,1808,94615,308
Sat 27 Dec 2014,1354,2030,1837,2020,72907,270
Sun 28 Dec 2014,1420,3289,2096,2020,356049,597
Mon 29 Dec 2014,1103,2795,1690,1665,129306,360
Tue 30 Dec 2014,957,2451,1843,1920,112943,336
Wed 31 Dec 2014,2020,3569,2425,2028,333904,578
Total Execution Time: 
70.651 seconds

## Copyright

Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

