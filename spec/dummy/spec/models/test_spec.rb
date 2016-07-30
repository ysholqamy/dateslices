require 'rails_helper'
require 'tester'

databases = [{ :adapter => 'mysql', :database => 'dateslice_test', :user => 'root', :password => 'joejoe64'},
             { :adapter => 'sqlite3', :database => 'db/test.sqlite3'}]

formats = ['groupdate', 'dateslices']

databases.each do |database|
  formats.each do |format|
    RSpec.describe "#{database[:adapter].titleize} #{format}", :type => :model do
      include_examples format, database
    end
  end
end
