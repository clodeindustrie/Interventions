class Intervention < Sinatra::Application
  # get one
  get '/fiche/:id' do
    login_required
    @fiche = Fiche[params[:id]]

    @executants = Agent.filter(:role => 'E').all
    @addresses  = Addresse.all
    @nextAction =  current_user.get_next_action + @fiche.id.to_s
    @pageTitle = "Intervention numero " + params[:id]
    erb :newFiche
  end

  get '/creer_fiche' do
    login_required

    @executants = Agent.filter(:role_id => Role.filter(:nom => 'Technicien').id).all
    @addresses  = Addresse.all
    @pageTitle  = "Faire une demande d'intervention"
    @partial    = creerFiche
    erb :creerFiche
  end

  # creer une fiche
  post '/creer_fiche' do
    login_required
    params[:fiche][:demandeur] = current_user
    @fiche = Fiche.new(params[:fiche])
    if @fiche.valid?
      @fiche.save
      redirect '/'
    else
      @errors = @fiche.errors
      @executants = Agent.filter(:role => 'E').all
      @addresses  = Addresse.all

      @nextAction = current_user.get_next_action
      @pageTitle  = "Faire une demande d'intervention"
      erb :newFiche
    end
  end

  # Moderer une fiche
  post '/moderer/:id' do
    login_required
    @fiche = Fiche[params[:id]]

    if params.has_key?('autoriser')
      statut = Statut.
    elsif params.has_key?('rejeter')
      statut = Statut[params[:fiche][:statut_id]]
    end

    @fiche.set_fields(params[:fiche], [:priority, :executant_id])
    @fiche.statut < statut

    if @fiche.valid?
      @fiche.save
      redirect '/fiche/' + @fiche.id.to_s
    else
      @errors = @fiche.errors
      @executants = Agent.filter(:role => 'E').all
      @addresses  = Addresse.all

      @nextAction = current_user.get_next_action
      erb :newFiche
    end
  end

  # update a fiche
  post '/rapporter/:id' do
    login_required
    @fiche = Fiche[params[:id]]
    params[:fiche][:statut] = "X"
    @fiche.set_fields(params[:fiche], [:travaux, :observations, :done_at, :statut])
    if @fiche.valid?
      @fiche.save
      redirect '/fiche/' + @fiche.id.to_s
    else
      @errors = @fiche.errors
      @executants = Agent.filter(:role => 'E').all
      @addresses  = Addresse.all

      @nextAction = current_user.get_next_action
      erb :newFiche
    end
  end

  # update a fiche
  post '/fiche/:id' do
    login_required
    @fiche = Fiche[params[:id]]
    @fiche.set_fields(params[:fiche], [:sujet, :famille, :addresse_id, :contenue, :priority, :executant_id, :travaux, :observations, :done_at])
    if @fiche.valid?
      redirect '/fiche/' + @fiche.id.to_s
    else
      @errors = @fiche.errors
      @executants = Agent.filter(:role => 'E').all
      @addresses  = Addresse.all

      @nextAction = current_user.get_next_action
      erb :newFiche
    end
  end

  # display fiche creation form
  get '/fiche' do
    login_required

    @executants = Agent.filter(:role_id => 4).all
    @addresses  = Addresse.all
    @nextAction = current_user.get_next_action
    @pageTitle  = "Faire une demande d'intervention"
    erb :newFiche
  end
end
