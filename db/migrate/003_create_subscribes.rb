class CreateSubscribes < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribes, force: true do |t|
      t.integer :cid, null: false, index: true
    end
  end
end
