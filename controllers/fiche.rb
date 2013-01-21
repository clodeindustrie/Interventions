# -*- coding: utf-8 -*-
class Intervention < Sinatra::Application

  #Display Form for creating a fiche
  get '/creer_fiche' do
    login_required
    auth_access_for("Agent")

    @addresses  = Addresse.all
    @pageTitle  = "Faire une demande d'intervention"
    erb :creerFiche
  end

  # creer une fiche
  post '/creer_fiche' do
    login_required
    auth_access_for("Agent")

    @fiche = Fiche.new
    params[:fiche][:demandeur] = current_user
    @fiche = FicheProcess.setFiche(@fiche, params)

    if @fiche.errors.empty?
      flash[:message] = "La demande d'intervention a été envoyée au responsable pour traitment"
      NotifyAgent.notifyAbout(@fiche, settings.current_base_url)
      redirect '/'
    else
      @errors = @fiche.errors
      @addresses  = Addresse.all
      @pageTitle  = "Faire une demande d'intervention"
      erb :creerFiche
    end
  end

  #display form for moderer une fiche
  get '/moderer/:id' do
    login_required
    auth_access_for("Responsable")
    @fiche = Fiche[params[:id]]
    already_processed?

    @executants = Agent.filter(:role => Role.filter(:nom => 'Technicien')).all
    @pageTitle  = "Superviser la demande d'intervention"
    erb :modererFiche
  end

  # Moderer une fiche
  post '/moderer/:id' do
    login_required
    auth_access_for("Responsable")
    @fiche = Fiche[params[:id]]
    already_processed?

    params[:fiche][:technicien] = Agent[params[:fiche][:executant_id]]
    params[:fields] = [:priority, :observations, :technicien]

    @fiche = FicheProcess.setFiche(@fiche, params)

    if @fiche.errors.empty?
      NotifyAgent.notifyAbout(@fiche, settings.current_base_url)
      flash[:message] = "La demande d'intervention a été envoyée"
      redirect '/'
    else
      @fiche.statut = Statut.where(:nom => 'Traitement').first
      @errors = @fiche.errors
      @pageTitle  = "Superviser la demande d'intervention"
      @executants = Agent.filter(:role => Role.where(:nom => 'Technicien')).all
      erb :modererFiche
    end
  end

  #display form for rapporter une fiche
  get '/rapporter/:id' do
    login_required
    auth_access_for("Technicien")
    @fiche = Fiche[params[:id]]
    already_processed?

    @pageTitle  = "Rapporter l'intervention"
    erb :rapporterFiche
  end

  # update a fiche
  post '/rapporter/:id' do
    login_required
    auth_access_for("Technicien")
    @fiche = Fiche[params[:id]]
    already_processed?

    params[:fields] = [:travaux, :done_at]
    @fiche = FicheProcess.setFiche(@fiche, params)

    if @fiche.errors.empty?
      NotifyAgent.notifyAbout(@fiche, settings.current_base_url)

      flash[:message] = "La demande d'intervention a été cloturée"
      redirect '/'
    else
      @errors = @fiche.errors
      @pageTitle  = "Rapporter l'intervention"
      erb :rapporterFiche
    end
  end

  get '/fiche/:id' do
    login_required
    fiche = Fiche[params[:id]]
    @f = fiche.valeurs
    erb :print, :layout => false
  end

  get '/print/:id' do
    login_required
    @print = true
    fiche = Fiche[params[:id]]
    @f = fiche.valeurs
    @pageTitle  = "Intervention ##{fiche.id}"
    erb :print, :layout => false
  end
end
