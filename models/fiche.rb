# -*- coding: utf-8 -*-
class Fiche < Sequel::Model
  plugin :validation_helpers
  plugin :timestamps, :create => :created_at
  unrestrict_primary_key
  many_to_one :addresse
  many_to_one :statut
  many_to_one :demandeur, :class => :Agent, :key => :demandeur_id
  many_to_one :technicien, :class => :Agent, :key => :excutant_id

  def validate
    super
    validates_presence :famille,        :message => "Vous devez renseigner la famille concernée"
    validates_presence :sujet,          :message => "Vous devez spécifier un intitulé"
    if demandeur.role.nom == 'Responsable'
      validates_presence :executant_id, :message => "Vous devez designer un technicien"
    end
  end

  def debute_le
    created_at.strftime('%d/%m/%Y')
  end

  def finie_le
    if !done_at.nil? && done_at != '0000-00-00 00:00:00'
      done_at.strftime('%d/%m/%Y')
    else
      '-'
    end
  end
end
