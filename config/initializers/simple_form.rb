# frozen_string_literal: true

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Default class for buttons
  config.button_class =
    "bg-orange-50 hover:bg-black font-semibold text-black hover:text-orange-50 py-2 px-2 border border-black hover:border-black border-4 border-double rounded shadow-md"

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = ""

  # How the label text should be generated altogether with the required text.
  config.label_text =
    lambda do |label, required, _explicit_label|
      "#{label.humanize} #{required}"
    end

  # Define the way to render check boxes / radio buttons with labels.
  config.boolean_style = :inline

  # You can wrap each item in a collection of radio/check boxes with a tag
  config.item_wrapper_tag = :div

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  config.include_default_input_wrapper_class = false

  # CSS class to add for error notification helper.
  config.error_notification_class =
    "text-white px-6 py-4 border-0 rounded relative mb-4 bg-red-400"

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # :to_sentence to list all errors for each field.
  config.error_method = :to_sentence

  # add validation classes to `input_field`
  config.input_field_error_class = "border-red-500"
  config.input_field_valid_class = "border-emerald-800"
  config.label_class = "text-black-600"

  # vertical forms
  #
  # vertical default_wrapper
  config.wrappers :vertical_form, tag: "div", class: "mb-4" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: "block", error_class: "text-red-500"
    b.use :input,
          class:
            "flex w-full border border-black bg-stone-50 p-2 focus:outline-none focus:border-emerald-800 
            text-black-400 leading-4 transition-colors duration-200 ease-in-out",
          error_class: "border-red-500",
          valid_class: "border-emerald-800"
    b.use :full_error,
          wrap_with: {
            tag: "p",
            class: "mt-2 text-red-500 text-xs italic"
          }
    b.use :hint,
          wrap_with: {
            tag: "p",
            class: "mt-2 text-grey-700 text-xs italic"
          }
  end

  # vertical input for boolean (aka checkboxes)
  config.wrappers :vertical_boolean,
                  tag: "div",
                  class: "mb-4 flex items-start",
                  error_class: "" do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper tag: "div", class: "flex items-center h-5" do |ba|
      ba.use :input,
             class:
               "focus:ring-2 focus:ring-indigo-500 ring-offset-2 h-4 w-4 text-indigo-600 border-gray-300 rounded"
    end
    b.wrapper tag: "div", class: "ml-3 text-sm" do |bb|
      bb.use :label, class: "block", error_class: "text-red-500"
      bb.use :hint,
             wrap_with: {
               tag: "p",
               class: "block text-grey-700 text-xs italic"
             }
      bb.use :full_error,
             wrap_with: {
               tag: "p",
               class: "block text-red-500 text-xs italic"
             }
    end
  end

  # vertical input for radio buttons and check boxes
  config.wrappers :vertical_collection,
                  item_wrapper_class: "flex items-center",
                  item_label_class:
                    "my-1 ml-3 block text-sm font-medium text-gray-400",
                  tag: "div",
                  class: "my-4" do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag,
              tag: "legend",
              class: "text-sm font-medium text-gray-600",
              error_class: "text-red-500" do |ba|
      ba.use :label_text
    end
    b.use :input,
          class:
            "focus:ring-2 focus:ring-indigo-500 ring-offset-2 h-4 w-4 text-indigo-600 border-gray-300 rounded",
          error_class: "text-red-500",
          valid_class: "text-green-400"
    b.use :full_error,
          wrap_with: {
            tag: "p",
            class: "block text-red-500 text-xs italic"
          }
    b.use :hint, wrap_with: { tag: "p", class: "text-grey-700 text-xs italic" }
  end

  # vertical file input
  config.wrappers :vertical_file, tag: "div", class: "" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label,
          class: "text-sm font-medium text-gray-600 block",
          error_class: "text-red-500"
    b.use :input,
          class: "w-full text-gray-500 px-3 py-2 border rounded",
          error_class: "text-red-500 border-red-500",
          valid_class: "text-green-400"
    b.use :full_error,
          wrap_with: {
            tag: "p",
            class: "mt-2 text-red-500 text-xs italic"
          }
    b.use :hint,
          wrap_with: {
            tag: "p",
            class: "mt-2 text-grey-700 text-xs italic"
          }
  end

  # vertical multi select
  config.wrappers :vertical_multi_select,
                  tag: "div",
                  class: "my-4",
                  error_class: "f",
                  valid_class: "" do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag,
              tag: "legend",
              class: "text-sm font-medium text-black",
              error_class: "text-red-500" do |ba|
      ba.use :label_text
    end
    b.wrapper tag: "div", class: "inline-flex space-x-1" do |ba|
      # ba.use :input, class: 'flex w-auto w-auto text-gray-500 text-sm border-gray-300 rounded p-2', error_class: 'text-red-500', valid_class: 'text-green-400'
      ba.use :input,
             class:
               "flex border border-black bg-stone-50 p-2 focus:outline-none focus:border-emerald-800 
                          text-black-400 leading-4 transition-colors duration-200 ease-in-out"
    end
    b.use :full_error,
          wrap_with: {
            tag: "p",
            class: "mt-2 text-red-500 text-xs italic"
          }
    b.use :hint,
          wrap_with: {
            tag: "p",
            class: "mt-2 text-grey-700 text-xs italic"
          }
  end

  # vertical range input
  config.wrappers :vertical_range,
                  tag: "div",
                  class: "my-4",
                  error_class: "text-red-500",
                  valid_class: "text-green-400" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label,
          class: "text-sm font-medium text-gray-600 block",
          error_class: "text-red-500"
    b.wrapper tag: "div", class: "flex items-center h-5" do |ba|
      ba.use :input,
             class:
               "rounded-lg overflow-hidden appearance-none bg-gray-400 h-3 w-full text-gray-300",
             error_class: "text-red-500",
             valid_class: "text-green-400"
    end
    b.use :full_error,
          wrap_with: {
            tag: "p",
            class: "mt-2 text-red-500 text-xs italic"
          }
    b.use :hint,
          wrap_with: {
            tag: "p",
            class: "mt-2 text-grey-700 text-xs italic"
          }
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :vertical_form

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  config.wrapper_mappings = {
    boolean: :vertical_boolean,
    check_boxes: :vertical_collection,
    date: :vertical_multi_select,
    datetime: :vertical_multi_select,
    file: :vertical_file,
    radio_buttons: :vertical_collection,
    range: :vertical_range,
    time: :vertical_multi_select
  }
end
