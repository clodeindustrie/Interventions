# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '/spec_helper')

describe Fiche do
  it "Check for technician only on second step" do
    f = Fiche.new({:famille => "famille", :sujet => "Le sujet", :contenue => "lecontenue"})
    f.valid?.should be_true

    f.statut = Statut.where(:nom => "Approuvée").first
    f.valid?.should be_false

    f.technicien = Agent.create(:email => "test@test.fr", :nom => "testNom", :password => "test", :password_confirmation => "test")
    f.valid?.should be_true

    f.statut = Statut.where(:nom => "Exécutée").first
    f.valid?.should be_false

    f.done_at = Date.new
    f.valid?.should be_true
  end

  it "returns a date or nil when calling finie_le" do
  end

  it "should send an email to the responsable when it's created'" do
  end

  it "should send an email to a Technicien when going from Traitement to Approuve/rejete" do
  end

  it "should send an email to {someone} when it is executee" do
  end
end
