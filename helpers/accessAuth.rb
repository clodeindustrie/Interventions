# -*- coding: utf-8 -*-
module AccessAuth
  def already_processed?
    if !@fiche.to_be_processed_by? current_user
      redirect "/#" + @fiche.id.to_s
    end
  end

  def auth_access_for(role)
    if current_user.role.nom != role
      halt 501
    end
  end
end
