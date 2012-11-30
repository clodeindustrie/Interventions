# -*- coding: utf-8 -*-
#
## addresse
#

get '/addresses' do
  login_required
  auth_access_for("Admin")

  @adds = Addresse.all
  @pageTitle = "Les addresses d'intervention"
  erb :indexAddresses
end

get '/addresse' do
  login_required
  auth_access_for("Admin")

  @addr = Addresse.new
  @pageTitle = "Ajouter une nouvelle addresse"
  erb :newAddresse
end

get '/addresse/:id' do
  login_required
  auth_access_for("Admin")

  @addr = Addresse[params[:id]]
  @pageTitle = "Addresse: " + @addr.addresse
  erb :newAddresse
end

post '/addresse/:id' do
  login_required
  auth_access_for("Admin")

  @addr = Addresse[params[:id]]
  @addr.set_fields(params[:add], [:addresse])
  if @addr.valid?
    @addr.save
    flash[:message] = "L'addresse a été modifiée"
    redirect '/addresses'
  else
    @errors = @addr.errors
    @pageTitle = "Addresse: " + @addr.addresse
    erb :newAddresse
  end
end

post '/addresse' do
  login_required
  auth_access_for("Admin")

  @addr = Addresse.new(params[:add])
  if @addr.valid?
    @addr.save
    flash[:message] = "L'addresse a été ajoutée"
    redirect '/addresses'
  else
    @errors = @addr.errors
    @pageTitle = "Ajouter une nouvelle addresse"
    erb :newAddresse
  end
end
