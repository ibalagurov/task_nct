gem "minitest"     
require "minitest/autorun"
require_relative '../pages/base_page.rb'
require_relative '../pages/company_page.rb'

class HeadHunterTestsuite < Minitest::Test
	def setup
		@page = BasePage.new
	end

	# Тест проверяет, что при поиске по компаниям и словам "новые облачные",
	# находятся "Новые Облачные Технологии"
	def test_search
		# входные данные
		selector = "Компании"
		text = "новые облачные"
		result = "Новые Облачные Технологии"
		
		@page.visit '/'

		# поиск по заданному тексту
		@page.search(selector,text)

		# проверка поисковой выдачи
		assert @page.has_result?(result), "\"#{result}\" отсутствует в результате поиска"
	end


	# Тест проверяет, на странице компании "Новые облачные технологии"
	# на сайте hh.ru количество вакансий в текущем регионе
	def test_count_vacancies
		# входные данные
		company_path = '/employer/213397'
		count = 14
		region = "в текущем регионе"

		@page = CompanyPage.new (company_path)

		#получение массива вакансий в регионе
		names = @page.vac_in_region region

		# удаление дубликатов и подсчёт уникальных значений
		number = names.uniq.size 

		assert count == number, "Количество вакансий #{region} - \"#{number}\", вместо - \"#{count}\""
	end


	# Тест проверяет, что на странице компании "Новые облачные технологии"
	# на сайте hh.ru в текущем регионе есть вакансия "QA Automation Engineer"
	def test_search_vacancy
		# входные данные
		company_path = '/employer/213397'
		region = "в текущем регионе" 
		vacacy = "QA Automation Engineer"

		@page = CompanyPage.new (company_path)

		# получение массива вакансий в регионе
		names = @page.vac_in_region region

		assert names.include?(vacacy), "Вакансии \"#{vacacy}\" нет #{region}"
	end
end