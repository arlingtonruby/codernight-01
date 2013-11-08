### International Trade Exercise

This is my attempt at working on this exercise praciticing TDD

Given a RATES.xml of:

```
<?xml version="1.0"?>
<rates>
  <rate>
    <from>AUD</from>
    <to>CAD</to>
    <conversion>1.0079</conversion>
  </rate>
  <rate>
    <from>CAD</from>
    <to>USD</to>
    <conversion>1.0090</conversion>
  </rate>
  <rate>
    <from>USD</from>
    <to>CAD</to>
    <conversion>0.9911</conversion>
  </rate>
</rates>
```

and a TRANSACTIONS.csv of:

```
store,sku,amount
Yonkers,DM1210,70.00 USD
Yonkers,DM1182,19.68 AUD
Nashua,DM1182,58.58 AUD
Scranton,DM1210,68.76 USD
Camden,DM1182,54.64 USD
```

Your goal is to parse all the transactions and return the grand total of all sales for a given item.

For the example above, your program should return 134.22 as the total of sku DM1182 in USD. 
It should use bankers round, and it should round to 2 decimals after each conversion. 

This puzzle was contributed by Shane Emmons and published on March 15, 2011
http://www.puzzlenode.com/puzzles/1-international-trade

