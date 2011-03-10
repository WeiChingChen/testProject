class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :name
      t.text :bio
      t.date :birthday

      #t.datetime created_at    自動會產生
      #t.datetime.update_at     自動會產生

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
