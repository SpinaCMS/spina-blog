# frozen_string_literal: true

module Spina
  module Blog
    # Spina::ApplicationRecord
    class ApplicationRecord < ActiveRecord::Base
      extend Mobility

      self.abstract_class = true
    end
  end
end
