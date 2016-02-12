require_relative '../support/env.rb'
require 'capybara'

class BasePage
	include Capybara::DSL

	def initialize
		Capybara.run_server = false #отключаем автоматическую загрузку Rack-сервера
		Capybara.current_driver = Options.driver
		Capybara.app_host = Options.base_url
		Capybara.default_max_wait_time = Options.wait_time
		Capybara.register_driver Capybara.current_driver do |app|
			Capybara::Selenium::Driver.new(app, :browser => Options.browser)
		end
		Capybara.current_session.
			driver.browser.manage.window.resize_to(Options.width, Options.height)
	end

	# поиск по выбраному типу и тексту
	def search(selector, text)
		find('.HH-Navi-SearchSelector-Select').select(selector)
		find('.HH-EmployersSearchRedirect-Suggest').set(text)
		find('form[data-hh-tab-id=employersList]>div>div>button').click
	end

	# метод получает текст, который надо найти на странице 
	# в случае многостраничной поисковой выдачи - ищет на всех страницах
	def has_result? (result)
		if has_text?(result)
			return true
		# проверка на многостраничность
		elsif has_css?('ul>li[data-qa]>a')
			# подсчёт количества страниц
			n = all('ul>li[data-qa]>a').size
			
			(0...n).each do |n| 
				find('.HH-Pager-Controls-Next').click
				if has_text?(result) then 
					return true 
				end
			end
		end

		return false
	end
end
