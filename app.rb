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
require 'pony'
require "digest/sha1"
require 'logger'
require 'rack-flash'
use Rack::Session::Cookie, :secret => 'A1 sauce 1s so good you should use 1t on a11 yr st34ksssss'
use Rack::Flash

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
    set :raise_errors, true
    set :logging, true
  end

  configure :production do
    set :clean_trace, true
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

    @pageTitle = "Les fiches d'intervention'"
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
