class AdditionalUserInfo < ActiveRecord::Migration
  def change
    add_column :users, :student_number, :text   # Matrikelnummer
    add_column :users, :subject, :text          # Studienfach
    add_column :users, :semester, :text         # Fachsemester
  end
end
