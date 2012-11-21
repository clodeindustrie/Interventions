class Intervention < Sinatra::Application
  get '/login/?' do
    if session[:agent]
      redirect '/'
    end
    erb :login, :layout => false
  end

  post '/login/?' do
    if agent = Agent.authenticate(params[:email], params[:password])
      session[:agent] = agent.id

      if session[:return_to]
        redirect_url = session[:return_to]
        session[:return_to] = false
        redirect redirect_url
      else
        redirect '/'
      end
    else
      @error = true
      erb :login, :layout => false
    end
  end

  get '/logout/?' do
    login_required
    session[:agent] = nil
    return_to = ( session[:return_to] ? session[:return_to] : '/' )
    redirect return_to
  end
end
