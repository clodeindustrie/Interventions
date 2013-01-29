Sequel.migration do
  up do
    create_table(:roles) do
      primary_key :id
      String :nom, :null => false, :size => 15
    end
  end

  down do
    drop_table(:roles)
  end
end
