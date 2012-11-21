class Intervention < Sinatra::Application
  get '/agent/:id' do
    login_required
    @agent = Agent[params[:id]]
    @roles = Role.all

    pageTitle = "Addresse numero " + params[:id]
    erb :newAgent
  end

  post '/agent/:id' do
    login_required

    @agent = Agent[params[:id]]
    @agent.set_fields(params[:agent], [:nom, :email, :role])
    if @agent.valid?
      @agent.save
      redirect '/agents'
    else
      @errors = @agent.errors
      @roles= Role.all
      erb :newAgent
    end
  end

  get '/agent' do
    login_required
    @agent = Agent.new
    @roles = Role.all

    erb :newAgent
  end

  post '/agent' do
    login_required
    @agent = Agent.new(params[:agent])
    if @agent.valid?
      @agent.save
      redirect '/agents'
    else
      @errors = @agent.errors
      @roles = Role.all
      erb :newAgent
    end
  end

  get '/agents' do
    login_required
    @agents = Agent.all

    @pageTitle = "Les agents"
    erb :indexAgents
  end
end
