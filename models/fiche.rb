# -*- coding: utf-8 -*-
class Fiche < Sequel::Model
  plugin :validation_helpers
  plugin :timestamps, :create => :created_at
  unrestrict_primary_key
  many_to_one :addresse
  many_to_one :statut
  many_to_one :demandeur,  :class => :Agent, :key => :demandeur_id
  many_to_one :technicien, :class => :Agent, :key => :executant_id

  def validate
    super
      validates_presence :famille,  :message => "Vous devez renseigner la famille concernée"
      validates_presence :sujet,    :message => "Vous devez spécifier un intitulé"
      validates_presence :contenue, :message => "Vous devez indiquer des travaux à effectuer"

    if !statut.nil? && !['Traitement', 'Rejetée'].include?(statut.nom)
      validates_presence :technicien, :message => "Vous devez designer un technicien"
    end

    if !statut.nil? && 'Exécutée' == statut.nom
      validates_presence :done_at, :message => "Vous devez indiquer une date de réalisation des travaux."
    end
  end

  def debute_le
    created_at.strftime('%d/%m/%Y')
  end

  def finie_le
    if !done_at.nil? && done_at != '0000-00-00 00:00:00'
      done_at.strftime('%d/%m/%Y')
    else
      nil
    end
  end

  # Shall we display the edit button or not?
  def to_be_processed_by?(agent)
    if !agent.nil? && !agent.role.nil?  && !statut.nil?
      case agent.role.nom
      when 'Responsable'
        'Traitement' == statut.nom
      when 'Technicien'
        'Approuvée' == statut.nom
      else
        false
      end
    else
      false
    end
  end
end
