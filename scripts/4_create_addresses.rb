Sequel.migration do
  up do
    create_table(:addresses) do
      primary_key :id
      String :address, :null => false, :size => 400
    end
  end

  down do
    drop_table(:addresses)
  end
end
