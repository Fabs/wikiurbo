class CreateCitizens < ActiveRecord::Migration
  def self.up
    create_table :citizens do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :citizens
  end
end
