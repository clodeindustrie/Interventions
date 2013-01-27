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
require_relative 'ficheprocess'

class Role < Sequel::Model
  one_to_many :agent
end
class Statut < Sequel::Model
  one_to_many :fiche
  @@states = ['Traitement', ['Approuvée', 'Rejetée'], 'Exécutée']

  def self.nextState(statut = nil, rejectionflag = false)
    if statut.nil?
      return self.where(:nom => @@states.first).first
    end

    if statut == @@states.first
      if rejectionflag
        return self.where(:nom => @@states[1].last).first
      else
        return self.where(:nom => @@states[1].first).first
      end
    end

    if statut == @@states[1].first
      return self.where(:nom => @@states.last).first
    else
      return nil
    end
  end
end
