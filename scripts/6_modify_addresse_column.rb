Sequel.migration do
  up do
    alter_table(:addresses) do
      rename_column :address, :addresse
    end
  end

  down do
    alter_table(:addresses) do
      rename_column :addresse, :address
    end
  end
end
