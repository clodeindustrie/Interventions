module LoginThings
  def hash_to_query_string(hash)
    hash.collect {|k,v| "#{k}=#{v}"}.join('&')
  end

  def login_required
    if session[:agent]
      return true
    else
      session[:return_to] = request.fullpath
      redirect '/login'
      return false
    end
  end

  def current_user
    if session[:agent]
      Agent[session[:agent]]
    else
      false
    end
  end

  def logged_in?
    !!session[:agent]
  end
end
