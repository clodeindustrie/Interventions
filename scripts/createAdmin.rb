# -*- coding: utf-8 -*-
require 'app'

if Agent[1].nil? || Agent[1].nom != 'admin'
  toto = {:role_id => 1, :nom => 'admin', :email => 'admin@toto.com', :password => 'toto', :password_confirmation => 'toto'}
  admin = Agent.new toto
  if admin.save
    puts "Admin creé avec succes!\n"
  else
    puts "problem YO"
  end
  else
  puts "Admin existe déja"
end
