class FicheProcess
  def self.setFiche(fiche, details)
    oldStatut = nil
    if fiche.new?
      fiche.set(details[:fiche])
      fiche.statut = Statut.nextState
    else
      oldStatut = fiche.statut
      fiche.set_fields(details[:fiche], details[:fields])

      fiche.statut = Statut.nextState(fiche.statut.nom, !details[:rejeter].nil?)
    end

    if (!fiche.save({:raise_on_failure => false}) && !oldStatut.nil?)
      fiche.statut = oldStatut
    end
    return fiche
  end
end
