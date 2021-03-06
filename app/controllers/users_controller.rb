class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		if(@user.contribution.nil?)
			@user.contribution = 0
			@user.save
		end
	end

	def manage
		if (current_user.nil? )
			redirect_to  '/signin'
		elsif (current_user.authority  != 1)
			redirect_to current_user, :notice => 'You do not have the authority to edit it' 
		else 
			@places_ac = TempPlace.where(:state => 1)
			@places_pending = TempPlace.where(:state => 0)
			@temp_places = TempPlace.all
		end
	end

	def auditapply	
		@temp_place = TempPlace.find(params[:id])
		@temp_placeclassifyname = getplaceclassifyname(@temp_place.classes)
	end

	def accepted
		@temp_place = TempPlace.find(params[:id])
		@temp_place.state = 1
		
		@temp_place.user.contribution += 5		# add the contribution
		if @temp_place.user.authority != 1 and @temp_place.user.contribution >= 20		# become an admin
			@temp_place.user.authority = 1
			
			@notice = Notice.new(:infotype => 4, :user_id => @temp_place.user.id)
			@notice.save
		end
		@temp_place.user.save

		if(@temp_place.applytype == 0)
			# update apply
			@temp_place.save
			@place = Place.find(@temp_place.place_id)
			@place.update_attributes(name: @temp_place.name, intro: @temp_place.intro, placeclassify_id: @temp_place.classes,
				locationx: @temp_place.locationx, locationy: @temp_place.locationy, avatar: @temp_place.avatar, avatar_cache: @temp_place.avatar_cache)
		
			@notice = Notice.new(:infotype => 3, :admin_id => current_user.id, 
				:user_id => @temp_place.user_id, :place_id => @place.id,  :temp_place_id => @temp_place.id)
			@notice.save
		else
			# new apply
			@place = Place.new(name: @temp_place.name, intro: @temp_place.intro, placeclassify_id: @temp_place.classes,
				locationx: @temp_place.locationx, locationy: @temp_place.locationy, avatar: @temp_place.avatar, avatar_cache: @temp_place.avatar_cache)
			@place.hot = 0
			@temp_place.place = @place
			@temp_place.place_id = @place.id
			@temp_place.save

			@place.user_id = @temp_place.user_id
			@place.user = @temp_place.user
			@place.save

			@notice = Notice.new(:infotype => 2, :admin_id => current_user.id, 
				:user_id => @temp_place.user_id, :place_id => @place.id,  :temp_place_id => @temp_place.id)
			@notice.save
		end
		redirect_to manage_path
	end

	def rejected
		@temp_place = TempPlace.find(params[:id])
		@temp_place.state = -2 			# Rejected It
		@temp_place.save
		redirect_to manage_path
	end

	def destroy
		@temp_place = TempPlace.find(params[:id])
		@temp_place.destroy
		redirect_to manage_path
	end

private
	def getplaceclassifyname(id) # return name1 of specific ID, and "Unclassified" of 0
		return I18n.t(:unclassifiedplaces) if id == 0 or id == '0'
		Placeclassify.find(id).name1
	end
end
