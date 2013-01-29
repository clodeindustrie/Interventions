Sequel.migration do
  up do
    create_table(:fiches) do
      primary_key :id
      foreign_key :addresse_id, :addresses
      foreign_key :demandeur_id, :agents
      foreign_key :executant_id, :agents
      foreign_key :statut_id, :statuts
      String :sujet, :null => false, :size => 255
      String :famille, :null => false, :size => 255
      String :contenue, :null => false, :size => 1000
      String :observations, :size => 1000
      String :travaux, :size => 1000
      DateTime :created_at, :null => false, :default => Time.now
      DateTime :done_at
      String :priority, :null => false, :default => 'U'
    end
  end

  down do
    drop_table(:fiches)
  end
end
