# frozen_string_literal: true

class CreateFreindshipsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :friended_user
      t.index %i[user_id friended_user_id], unique: true
      t.timestamps
    end
  end
end
