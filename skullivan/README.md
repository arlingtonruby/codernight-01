ruby-coder-night-ex1
====================

Per Chris's request, my stated objective of this assignment was to simply flex my Ruby muscles and also work in a bit of recursion as well.

Ruby coder night coding assignment. Developed using:

* ruby 1.9.3p451 (2013-07-10 revision 41878) [x86_64-linux]
* Due to use of XmlSimple and certain CSV class methods, Ruby 1.9+ is required.

To run the program, do 'ruby SalesReporter'.

SalesReporter accepts 4 command line parameters as listed below; at this time the program does not type checking or error handling in this area:

* product_code = ARGV[0] # i.e. 'DM1182'
* target_country_code = ARGV[1] # i.e. 'USD'
* transaction_file = ARGV[2] # i.e. 'TRANS.csv'
* conversions_file = ARGV[3] #i.e. 'RATES.xml'

but running the program with no command line input will use the default values of: 

* (product_code = 'DM1182', target_country_code = 'USD')

Some todos-

* I noted an interesting (and not understood) problem when I overloaded "get_rate" - it appeared Ruby was calling the wrong method regardless of 
the number of input parameters. Need to investigate this.

* Another 'oog' - I'm not a huge fan of the 'return 0 to indicate program error' - if I had more time, I would have thrown an exception up the stack 
and I intend on re-factoring this to make it so.

General architecture description:

* ConversionData.rb - singleton used to stash and do basic returns of requested currency conversion data.
* SalesData.rb - same as previous, but for sales transactions.
* SalesReporter.rb - essentially the 'main' method; grabs command line input (not required) and runs the business.
* CurrencyConverter.rb - The business class. Does a bit of recursion to 'hop' when direct conversions from country 'a' to country 'b' are not possible. Much potential for clean-up and re-factor here.


