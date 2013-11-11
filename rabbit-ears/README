This is my submission for Arlington Ruby's Hack Night #1.

My goal with this is to treat it as a real client project and show what I'd deliver as a maintainable, documented solution to the presented problem with a reasonable api for fitting into some back office automation scheme.

1) I used the open source project RASK as a rake-based application shell to get started.
2) I downloaded all the sample files for the project (including saving the initial web page with requirements) and put them in the 'files' directory.
3) I wrote the code and tests.

To get started:
1) Well, you've unzipped my submission and gotten this far, so congratulations.
2) You'll need JRuby installed.  I chose to use JRuby to entirely sidestep the rounding error bug present in MRI,
3) With your favorite ruby chooser, set it to JRuby 1.7.6
4) bundle install
5) type 'rake -T' and you'll see a few rake tasks.

bundler will complain if you don't set it to use JRuby.

You can choose to run the tests now with 'rake test'.  After running the tests you'll have a coverage report in coverage/index.html that shows 100% test coverage

or you can choose to see the output with their sample files with the following rake task:

rake item_sales["files/SAMPLE_RATES.xml","files/SAMPLE_TRANS.csv","DM1182","USD"]

depending on your shell, you may have to escape that.  For instance, on zsh, I have to escape the brackets as in:

rake item_sales\["files/SAMPLE_RATES.xml","files/SAMPLE_TRANS.csv","DM1182","USD"\]

With your favorite editor, browse the files.


Note that much of the directory structure, app, bootstrap, gemfile, etc all come from the RASK project:

https://github.com/bokmann/RASK

That gives us a consistent way to bootstrap, log, respect environment variables, organize our project, etc.

If you'd like a guided tour, start with the rake task in app/lib/tasks/reports.rb

and follow the path of execution with the ItemSalesReport class

The application is structured into three main areas:
models - which handle dealing with money, converting the currency, and representing the transactions

parsers - which read the files specified turning them into data structures the models understand.  This allows us to swamp the data source from a file to something else, like a currency conversation rate webservice or a database of transactions without impacting other pieces of the code.

reporters - for which we will often have several in real-world client work.


the rake tasks start off the whole process, but we generally structure those to simply create an object and kick off a process - a thin wrapper.

