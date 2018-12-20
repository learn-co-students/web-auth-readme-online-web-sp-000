class SearchesController < ApplicationController
  def search
  end

  def foursquare

    client_id = ENV['DOHRFWJ4ADKXBXEPFGYU0VMZUWX0135GA3GG1EP0Z5JM0HVS']
    client_secret = ENV['UARMZQVBWT1EHSMRGR52U4TZLEYQISFC0SSBGHUYY3FQ0D1X']

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end
