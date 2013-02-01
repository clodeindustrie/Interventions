# -*- coding: utf-8 -*-
require_relative '../app'

if ARGV.size < 2
  puts "Tapez l'addresse email de l'admin"
  email = gets.chomp
  puts "Tapez un mot de passe:"
  password = gets.chomp
else
  email = ARGV[0]
  password = ARGV[1]
end
if Agent.where(:nom => 'Admin').all.empty?
  toto = {
    :role_id               => 1,
    :nom                   => 'Admin',
    :email                 => email,
    :password              => password,
    :password_confirmation => password
  }
  admin = Agent.new toto
  if admin.save
    puts "Admin créé avec succes !\n"
  else
    puts "problem YO: " + admin.errors.inspect
  end
else
  puts "Admin existe déja"
end
