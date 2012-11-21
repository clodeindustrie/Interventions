# -*- coding: utf-8 -*-
class Addresse < Sequel::Model
  plugin :validation_helpers

  one_to_many :fiche

  def validate
    super
    validates_presence :addresse, :message => "Vous devez écrire quelque chose !"
  end
end
