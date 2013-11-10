# rake item_sales\["files/RATES.xml","files/TRANS.csv","DM1182","USD"\]
desc "calculates the grand total of sales for item given the parameters"
task :item_sales, [:rates_file,
                   :transactions_file,
                   :sku,
                   :currency_code] => :environment do |t, args|

  report = ItemSalesReport.new(args[:rates_file],
                               args[:transactions_file],
                               args[:sku],
                               args[:currency_code])

  report.process

  puts report.answer
end
