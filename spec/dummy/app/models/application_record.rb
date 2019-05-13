# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  extend Mobility
  self.abstract_class = true
end
