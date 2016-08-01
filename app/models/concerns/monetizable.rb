require 'active_support/concern'

module Monetizable
  extend ActiveSupport::Concern

  included do
    def self.humanized_money_accessor(*fields)
      fields.each do |f|
        define_method("#{f}_humanized") do
          val = read_attribute(f)
          val ? ("%.2f" % val.to_f).gsub(',', '.') : nil
        end
        define_method("#{f}_humanized=") do |e|
          write_attribute(f, e.to_s.delete(","))
        end
      end
    end
  end
end