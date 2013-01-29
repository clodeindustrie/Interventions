Sequel.migration do
  up do
    create_table(:addresses) do
      primary_key :id
      String :addresse, :null => false, :size => 400
    end
  end

  down do
    drop_table(:addresses)
  end
end
