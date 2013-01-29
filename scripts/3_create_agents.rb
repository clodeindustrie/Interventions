Sequel.migration do
  up do
    create_table(:agents) do
      primary_key :id
      foreign_key :role_id, :roles
      String :nom, :null => false, :size => 100
      String :email, :null => false, :size => 255
      String :hashed_password, :null => false, :size => 255
      String :salt, :null => false, :size => 255
      DateTime :created_at, :null => false, :default => Time.now
      index :email, :unique => true
    end
  end

  down do
    drop_table(:agents)
  end
end
