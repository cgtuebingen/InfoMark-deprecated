class CleanSubmission < ActiveRecord::Migration
  def change


    drop_table :submissions
    drop_table :submission_infos

    create_table :submissions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :exercise_task, index: true, foreign_key: true
      t.string :file
      t.text :log              # in_schoen(public result)
      t.text :private_log      # private result
      t.text :raw_log          # public result
      t.timestamps null: false
    end

  end


  
end
