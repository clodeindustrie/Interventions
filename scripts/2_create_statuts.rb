Sequel.migration do
  up do
    create_table(:statuts) do
      primary_key :id
      String :nom, :null => false, :size => 15
    end
  end

  down do
    drop_table(:statuts)
  end
end
