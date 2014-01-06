module ApplicationHelper

  def cities_nav

    # Берем город из url
    if params[:city]
      city = City.where(alias: params[:city]).first
      session[:city] = params[:city]
    end

    unless city and session[:city]
      city = City.where(alias: session[:city]).first
    end

    # Если город так и не узнали берем первый попавшийся
    unless city
      city = City.first
    end

    cities = City.where(:alias.ne => city.alias)

    html = '
    <ul class="nav cities-nav">
      <li>
        <a href="' + root_url + '?city=' + city.alias + '">
          ' + city.name + '
        </a>
      </li>
      <li class="dropdown">
        <a class="dropdown-toggle" data-toggle="dropdown" href="' + url_for(params.merge(:city => city.alias)) + '">
          <b class="caret"></b>
        </a>
        <ul class="dropdown-menu">'

    cities.each do |c|
      html << '<li><a href="' + url_for(params.merge(:city => c.alias)) + '">' + c.name + '</a></li>'
    end

    html <<
        '</ul>
      </li>
    </ul>'

    html << hidden_field_tag(:address, city.name)

    html.html_safe
  end
end
