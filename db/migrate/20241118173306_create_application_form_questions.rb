class CreateApplicationFormQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :application_form_questions do |t|
      t.references :application_form, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
