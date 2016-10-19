class AddAttachmentGirlToImages < ActiveRecord::Migration
  def self.up
    change_table :images do |t|
      t.attachment :girl
    end
  end

  def self.down
    remove_attachment :images, :girl
  end
end
