# encoding: utf-8
require 'mysql2'
require 'sequel'

if settings.environment == :development
  mysql_details = {:adapter => 'mysql', :host => 'localhost', :user => 'root', :password => 'taeslin', :database => 'ficheTechnique'}
else
  mysql_details = {:adapter => 'mysql', :host => 'localhost', :user => 'root', :password => 'taeslin', :database => 'ficheTechnique'}

end
DB = Sequel.connect(mysql_details)
DB.convert_invalid_date_time = :string

require_relative 'fiche'
require_relative 'agent'
require_relative 'addresse'

class Role < Sequel::Model
  one_to_many :agent
end
class Statut < Sequel::Model
  one_to_many :fiche
end
