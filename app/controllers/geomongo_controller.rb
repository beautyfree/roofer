class GeomongoController < ApplicationController
  def index
    vk = VK::Client.new('6add8171bc51863e3fa620669c26403a3a2b7aa5e3454358f2da74c875a4e4037ee52e5fff4a2447e85f0')

    ### Парсим страны

    [:ru, :en].each do |lang|
      offset = 0
      start = true

      I18n.locale = lang
      while start
          response = vk.database.getCountries(need_all: 1, lang: lang.to_s, count: 1000, offset: offset, v: '5.5')
          break if response.items.size == 0 # Если пусто - выходим

          response.items.each do |country|
            c = Geo::Country.find_by(vk_id: country.id)
            unless c
              Geo::Country.create(vk_id: country.id, title: country.title)
            else
              c.update_attributes(vk_id: country.id, title: country.title)
            end
          end

          offset += 1000
          sleep 0.5
          break if response[:count] < offset
      end
    end
=begin

    ### Парсим регионы стран
    Geo::Country.all.each do |country|
      regions = Array.new
      offset = 0
      start = true

      while start
        response = vk.database.getRegions(country_id: country.vk_id, count: 1000, offset: offset, v: '5.5')
        # TODO: Будет потенциально лишний запрос
        break if response.items.size == 0 # Если пусто - выходим

        response.items.each do |region|
          regions << {
              vk_id: region.id,
              title: region.title,
              country_id: country.id
          }
        end

        offset += 1000
        sleep 1
      end
      Geo::Region.create(regions)
    end


    ### Парсим города стран
    Geo::Country.all.order_by(vk_id: :asc).each do |country|
      cities = Array.new
      offset = 0

      while true
        response = vk.database.getCities(country_id: country.vk_id, need_all: 1, count: 1000, offset: offset, v: '5.5')
        break if response.items.size == 0 # Если пусто - выходим

        response.items.each do |city|

          if city.region.present?
            region = Geo::Region.find_or_create_by(title: city.region, country_id: country.id)
          end

          if city.area.present?
            area = Geo::Area.find_or_create_by(title: city.area, country_id: country.id, region_id: (region.id if region.present?) )
          end

          cities << {
              vk_id: city.id,
              title: city.title,
              important: (city.important if city.important.present?),
              country_id: country.id,
              region_id: (region.id if region.present?),
              area_id: (area.id if city.area.present?)
          }

          # Если размер временного массива превысил 1000 - пора его вливать в бд и чистить
          if cities.size >= 1000
            Geo::City.create(cities)
            cities = Array.new
          end
        end

        offset += 1000
        sleep 0.5
        break if response[:count] < offset
      end

      Geo::City.create(cities)
    end
=end

  end
end
