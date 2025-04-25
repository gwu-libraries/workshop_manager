class CreateFeedbackFormQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_form_questions do |t|
      t.references :feedback_form, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
