#
## addresse
#

get '/addresses' do
  login_required
  @adds = Addresse.all

  @pageTitle = "Les addresses d'intervention"
  erb :indexAddresses
end

get '/addresse' do
  login_required
  @addr = Addresse.new

  @pageTitle = "Ajouter une nouvelle addresse"
  erb :newAddresse
end

get '/addresse/:id' do
  login_required
  @addr = Addresse[params[:id]]

  pageTitle = "Addresse: " + @addr.addresse
  erb :newAddresse
end

post '/addresse/:id' do
  login_required
  @addr = Addresse[params[:id]]
  @addr.set_fields(params[:add], [:addresse])
  if @addr.valid?
    @addr.save
    redirect '/addresses'
  else
    @errors = @addr.errors
    erb :newAddresse
  end
end

post '/addresse' do
  login_required
  @addr = Addresse.new(params[:add])
  if @addr.valid?
    @addr.save
    redirect '/addresses'
  else
    @errors = @addr.errors
    erb :newAddresse
  end
end
