# encoding: utf-8
require 'mysql2'
require 'sequel'

Sequel::Model.plugin :force_encoding, 'UTF-8'

if settings.environment == :development
  mysql_details = {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :user     => 'root',
    :password => 'taeslin',
    :database => 'dev_ficheTechnique',
    :encoding => 'utf8'
  }
elsif settings.environment == :test
  mysql_details = {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :user     => 'root',
    :password => 'taeslin',
    :database => 'test_ficheTechnique',
    :encoding => 'utf8'
  }
elsif settings.environment == :live
  mysql_details = {
    :adapter  => 'mysql',
    :host     => 'localhost',
    :user     => 'root',
    :password => 'taeslin',
    :database => 'live_ficheTechnique',
    :encoding => 'utf8'
  }
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
  # @@states = ['Traitement', ['Acceptée', 'Rejetée'], 'Exécutée']

  # def self.nextState(statut = nil, rejectionflag = false)
  #   if statut.nil?
  #     return @@states.first
  #   end

  #   if statut == @@states.first
  #     if rejectionflag
  #       return @@states.value_at(@@states.first).last
  #     else
  #      return @@states.value_at(@@states.first).first
  #     end
  #   end

  #   if statut == @@states.value_at(@@states.first).first
  #     return @@states.last
  #   else
  #     return nil
  #   end
  # end
end
