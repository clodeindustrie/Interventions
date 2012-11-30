# -*- coding: utf-8 -*-
class Intervention < Sinatra::Application
  get '/agent/:id' do
    login_required
    auth_access_for("Admin")

    @agent = Agent[params[:id]]
    @roles = Role.all

    @pageTitle = "Agent numero " + params[:id]
    erb :newAgent
  end

  post '/agent/:id' do
    login_required
    auth_access_for("Admin")

    @agent = Agent[params[:id]]
    @agent.role = Role[params[:agent][:role_id]]
    @agent.set_fields(params[:agent], [:nom, :email])
    if @agent.valid?
      @agent.save
      flash[:message] = "L'agent a été modifiée"
      redirect '/agents'
    else
      @errors = @agent.errors
      @roles= Role.all
      @pageTitle = "Agent numero " + params[:id]
      erb :newAgent
    end
  end

  get '/agent' do
    login_required
    auth_access_for("Admin")

    @agent = Agent.new
    @roles = Role.all

    @pageTitle = "Créer un nouvel agent"
    erb :newAgent
  end

  post '/agent' do
    login_required
    auth_access_for("Admin")

    @agent = Agent.new(params[:agent])
    @agent.role = Role[params[:agent][:role_id]]
    if @agent.valid?
      @agent.save
      flash[:message] = "L'agent a été ajoutée"
      redirect '/agents'
    else
      @errors = @agent.errors
      @roles = Role.all
      @pageTitle = "Créer un nouvel agent"
      erb :newAgent
    end
  end

  get '/agents' do
    login_required
    auth_access_for("Admin")

    @agents = Agent.all
    @pageTitle = "Les agents"
    erb :indexAgents
  end
end
