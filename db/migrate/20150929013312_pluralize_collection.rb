class PluralizeCollection < ActiveRecord::Migration
  def change
    rename_table :trump_clinton_collection, :collections
  end
end
