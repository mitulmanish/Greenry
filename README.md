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

## Copyright

Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

