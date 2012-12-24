require "stipulate/version"

module Stipulate
	def self.included(mod)
		mod.extend ClassMethods
	end
	
	module ClassMethods
		def stipulate(opts={})
			method = opts[:that].to_s
			enumeration = method.pluralize
		
			singleton_class.class_eval <<-"END"
				cattr_accessor :#{enumeration}
			END
			
			# If the method is customized, we want to retain changes through a wrapper
			if instance_methods.include? method.to_sym
				class_eval <<-"END"
					# Ensure fields are converted to string
					def #{method}_with_stipulation
						v = #{method}_without_stipulation
						v.nil? ? nil : v.to_s
					end
				END
	
				alias_method_chain method.to_sym, :stipulation
			else
				class_eval <<-"END"
					# Ensure fields are converted to string
					def #{method}
						v = attributes["#{method}"]
						v.nil? ? nil : v.to_s
					end
				END
			end
			
			singleton_class.send :"#{enumeration}=", opts[:can_be]
			
			for enum in opts[:can_be] do
				class_eval <<-"END"
				  def #{enum}?
						#{method}.to_s.to_sym == :#{enum}
				  end
				END
			end
		end
	end
end

class ActiveRecord::Base
	include Stipulate
end