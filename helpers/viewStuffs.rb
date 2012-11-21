# -*- coding: utf-8 -*-
module ViewStuffs
  def cssStatus(statut)
    case statut
        when 'Traitement' then return 'info'
        when 'Approuvée' then return 'warning'
        when 'Rejetée' then return 'important'
        when 'Exécutée' then return 'success'
    end
  end

  def newFicheButton(role)
    if role == 'Responsable'
      @buttonText = [{:text => "Autoriser l'intervention", :name => "autoriser"}, {:text => "Rejeter l'intervention", :name => "rejeter"}]
    elsif role == 'Technicien'
      @buttonText = [{:text => "Clore l'intervention", :name => "clore"}]
    elsif role == 'Agent'
      if @fiche.nil?
        @buttonText = [{:text => "Envoyer la demande d'intervention", :name => "envoyer"}]
      else
        @buttonText = [{:text => "Modifier l'intervention", :name => "modifier"}]
      end
    end
    output = ""
    @buttonText.each do |button|
	output << "<button class='btn btn-info' type='submit' name='#{button[:name]}'>#{button[:text]}</button>"
    end
    output
  end
end
