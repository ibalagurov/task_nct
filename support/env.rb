module Options	
	def self.driver
		:selenium
	end

	def self.base_url
		'http://hh.ru'
	end

	def self.wait_time
		10 #сколько секунд ждем появления элемента
	end

	def self.browser
		:chrome
	end

	def self.width
		1280
	end

	def self.height
		768
	end
end