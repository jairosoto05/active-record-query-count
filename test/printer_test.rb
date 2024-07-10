require 'test_helper'

class PrinterTest < Minitest::Test
  context 'printing methods' do
    setup do
      @data = { 'users' =>
        { count: 2,
          location: { nil => { count: 2,
                               sql: 'SELECT "users".* FROM "users" WHERE "users"."email" = $1 LIMIT $2' } } } }
    end

    should 'print html output without errors' do
      Launchy.expects(:open).with(anything).once
      ActiveRecordQueryTracker::Printer::Html.new(data: @data).print
    end

    should 'print html compare output without errors' do
      Launchy.expects(:open).with(anything).once
      ActiveRecordQueryTracker::Printer::HtmlCompare.new(data_1: { 'script1': @data }, data_2: { 'script2': @data }).print
    end

    should 'print console output without errors' do
      ActiveRecordQueryTracker::Printer::Console.new(data: @data).print
    end
  end
end
