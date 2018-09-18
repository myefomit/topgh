class CreateContributors < ActiveRecord::Migration[5.1]
  def change
    create_table :contributors do |t|
      t.string :login, index: true
      t.string :avatar_url
      t.string :url
    end
  end
end
