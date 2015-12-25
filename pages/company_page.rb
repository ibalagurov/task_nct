require_relative 'base_page.rb'

class CompanyPage < BasePage
	def initialize (path)
		visit path
	end

	# метод получает название или частичное название региона 
	# возвращает массив названий вакансий в этом регионе или пустой массив, 
	# если нет вакансий в заданном регионе или самого региона 
	def vac_in_region (region)		
		begin
			node = find(:xpath, "//span[@class='link-switch']", :text => /(.*)#{region}(.*)/)
		rescue
			return []
		end

		#выборка вакансий по всем категориям в заданном регионе
		within (node.find(:xpath, "..").find(:xpath, "..")) do 
			
			# открытие всех категорий
			all('.b-emppage-vacancies-group-title>a.link-switch').each do |element|
				element.click
			end

			# ожидание отображения вакансий
			has_selector?('.search-result-item__name_standard') 

			# сбор названий вакансий
			return all('.search-result-item__name_standard').collect(&:text)
		end	
	end
end