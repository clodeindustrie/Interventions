# coding: UTF-8
#dodgy !!
unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require 'rubygems'
require 'sinatra'
require 'json'
require "digest/sha1"
require 'logger'
require 'rack-flash'
require 'sinatra/reloader'
require 'pony'
use Rack::Session::Cookie, :secret => 'A1 sauce 1s so good you should use 1t on a11 yr st34ksssss'
use Rack::Flash

Encoding.default_internal = "UTF-8"
Encoding.default_external = "UTF-8"

##
#trigger: creation de fiche
#statut: traitement - gris

#trigger: moderation
#statut: Approuve - orange ou rejete - rouge

#trigger: execution
#Statut: execute - green

##
# ROLES
# Admin
# Responsable
# Agent
# Technicien
##
#
## CONFIG
#
class Intervention < Sinatra::Application

  configure :development do
    register Sinatra::Reloader
    Pony.options = {
      :via => :smtp,
      :via_options => { :host => '127.0.0.1', :port => '1025' },
      :from      => "intervention@selogerpourvivre.org",
      :charset   => "UTF-8"
    }
    set :current_base_url, "http://0.0.0.0:5000"
    set :logging, true
    set :dump_errors, true
    set :show_exceptions, :after_handler
  end

  configure :production do
    Pony.options = {
      :via => :smtp,
      :via_options => {
        :address => 'smtp.sendgrid.net',
        :port => '587',
        :domain => 'heroku.com',
        :user_name => ENV['SENDGRID_USERNAME'],
        :password => ENV['SENDGRID_PASSWORD'],
        :authentication => :plain,
        :enable_starttls_auto => true
      },
      :from      => "intervention@selogerpourvivre.org",
      :charset   => "UTF-8"
    }
    set :current_base_url, "http://interventions.herokuapp.com"
    set :clean_trace, true
  end

  not_found do
    erb :not_found, :layout => false
  end

  error do
    Pony.mail({
                :to      => 'clodeindustrie@gmail.com',
                :from    => 'error@selogerpourvivre.org',
                :subject => 'Error in Intervention',
                :body    => env['sinatra.error'].message
              })
    erb :error_pascool, :layout => false
  end

  error 501 do
    erb :pascool, :layout => false
  end

  get '/' do
    login_required
    # filtered if agent or executant:
    if current_user.role.nom == 'Agent'
      @fiches = Fiche.filter(:demandeur_id => current_user.id).order(:created_at.desc).all
    elsif current_user.role.nom == 'Technicien'
      @fiches = Fiche.filter(:executant_id => current_user.id).order(:created_at.desc).all
    else
      @fiches = Fiche.order(:created_at.desc).all
    end

    @pageTitle = "Les fiches d'intervention"
    erb :index, :layout => :layout
  end

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
end

require_relative 'models/init'
require_relative 'controllers/init'
require_relative 'helpers/init'
require_relative 'lib/init'
