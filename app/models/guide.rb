class Guide < ActiveRecord::Base


	def self.save_by_g g
		if not g.blank?
			@guide = Guide.find_by_name(g)
			begin
				Guide.create(:name => g)
			rescue
				p "save guider #{g} error"
			end	
		end
	end
	
end
