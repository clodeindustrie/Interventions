# -*- coding: utf-8 -*-
require 'tilt'

class NotifyAgent

  @@current_base_url = ""

  def self.notifyAbout(fiche, base_url)
    @@current_base_url = base_url
    case fiche.statut.nom
    when 'Traitement'
      self.notifyTraitement(fiche)
    when 'Approuvée'
      self.notifyApprouvée(fiche)
    when 'Rejetée'
      self.notifyRejetée(fiche)
    when 'Exécutée'
      self.notifyExécutée(fiche)
    end
  end

  private

  def self.render_template(template, locals)
    rendered = Tilt.new(File.join(settings.views, "emails", "#{template}.erb")).render(self, locals)
    rendered.force_encoding 'UTF-8'
    return rendered
  end

  def self.notifyTraitement(fiche)
    locals = {
      :fiche    => fiche,
      :to       => Agent.where(:role => Role.where(:nom => "Responsable")).first,
      :base_url => @@current_base_url,
    }
    self.notify( {
                   :to        => locals[:to].email,
                   :html_body => self.render_template("traitement_html", locals),
                   :body      => self.render_template("traitement_text", locals),
                 })
  end

  def self.notifyApprouvée(fiche)
    locals = {
      :fiche    => fiche,
      :to       => fiche.technicien,
      :base_url => @@current_base_url,
    }
    self.notify( {
                   :to        => locals[:to].email,
                   :html_body => self.render_template("acceptee_tech_html", locals),
                   :body      => self.render_template("acceptee_tech_text", locals),
                 })

    locals = {
      :fiche    => fiche,
      :to       => fiche.demandeur,
      :base_url => @@current_base_url,
    }
    self.notify( {
                   :to        => locals[:to].email,
                   :html_body => self.render_template("acceptee_dem_html", locals),
                   :body      => self.render_template("acceptee_dem_text", locals),
                 })
  end

  def self.notifyRejetée(fiche)
    locals = {
      :fiche    => fiche,
      :to       => fiche.demandeur,
      :base_url => @@current_base_url,
    }
    self.notify( {
                   :to        => locals[:to].email,
                   :html_body => self.render_template("rejetee_html", locals),
                   :body      => self.render_template("rejetee_text", locals),
                 })
  end

  def self.notifyExécutée(fiche)
    locals = {
      :fiche    => fiche,
      :to       => fiche.demandeur,
      :base_url => @@current_base_url,
    }
    self.notify( {
                   :to        => locals[:to].email,
                   :html_body => self.render_template("executee_dem_html", locals),
                   :body      => self.render_template("executee_dem_text", locals),
                 })
    locals = {
      :fiche    => fiche,
      :to       => Agent.where(:role => Role.where(:nom => "Responsable")).first,
      :base_url => @@current_base_url,
    }
    self.notify( {
                   :to        => locals[:to].email,
                   :html_body => self.render_template("executee_resp_html", locals),
                   :body      => self.render_template("executee_resp_text", locals),
                 })
  end

  def self.notify(details)
    Pony.mail ({
                 :subject   => "Une Intervention requière votre attention"
               }.merge!(details))
  end

  private

  def self.view_path
    File.join(settings.views, "emails")
  end
end
