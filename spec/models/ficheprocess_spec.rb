# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '/spec_helper')

describe FicheProcess do
  it "should return a complete saved fiche when provided with a new fiche" do
    FicheProcess.setFiche(Fiche.new, {
                            :address_id => 1,
                            :demandeur_id => 2,
                            :famille => 1,
                            :sujet => "test sujet",
                            :contenue => "test contenue"
                          })
  end

  it "should return a dirty fiche with errors when provided with a invalid fiche" do
  end

  it "should return a saved fiche when provided with an existing fiche and the fields to update" do
  end

  it "should return a dirty fiche with errors and initial statut when provided with an invalid existing fiche" do
  end
end
