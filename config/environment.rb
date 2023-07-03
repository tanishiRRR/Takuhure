# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

#Rails field_with_errorsを取り除く
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end