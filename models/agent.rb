# -*- coding: utf-8 -*-
class Agent < Sequel::Model
  attr_writer :password_confirmation
  plugin :validation_helpers
  plugin :timestamps, :create => :created_at
  unrestrict_primary_key

  one_to_many :fiche_demandeur, :class => :Fiche, :key => :demandeur_id
  one_to_many :fiche_executant, :class => :Fiche, :key => :executant_id
  many_to_one :role

  def admin?
    role.nom == 'Admin'
  end

  def validate
    super
    email_regexp = /(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i
    validates_format email_regexp, :email, :message => "L'email est incorrecte"
    validates_presence :email,             :message => "Vous devez remplir l'email"
    validates_unique :email,               :message => "Cet email existe déja"
    validates_presence :nom,               :message => "Vous devez remplir le nom"
    if new?
      errors.add :password, 'Le mot de passe est obligatoire' if @password.blank?
    end
    errors.add :password, 'Les mots de passe ne correspondent pas' unless @password == @password_confirmation
  end

  def password=(pass)
    @password = pass
    self.salt = Agent.random_string(10) if !self.salt
    self.hashed_password = Agent.encrypt(@password, self.salt)
  end

  def get_next_action(fiche)
   case role.nom
    when 'Responsable' then return "moderer"
    when 'Technicien' then return "rapporter"
    when 'Agent'
      if fiche.nil?
        return "creer_fiche"
      else
        return "fiche"
      end
    end
  end

protected
  def method_missing(m, *args)
    return false
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.random_string(len)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  def self.authenticate(email, pass)
    current_user = first(:email => email)
    return nil if current_user.nil?
    return current_user if Agent.encrypt(pass, current_user.salt) == current_user.hashed_password
    nil
  end
end
