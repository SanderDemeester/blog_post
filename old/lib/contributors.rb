def contributors
	if @item[:contributors].nil?
		'(none)'
	else
		@item[:contributors].join(', ')
	end	
end
