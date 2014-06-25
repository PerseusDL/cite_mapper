require 'sinatra/base'
require 'sinatra/respond_with'
require 'cite_mapper'

class Api < Sinatra::Base
  register Sinatra::RespondWith

  @mapper = CiteMapper.new

  before do
    headers 'Access-Control-Allow-Origin' => '*',
      'Access-Control-Allow-Methods' => %w{ GET },
      'Access-Control-Allow-Headers' => %w{ Content-Type }
  end

  get '/find_cite' do
    cts_urn = params[:cite]
    res = @mapper.find_by_cite(cts_urn)

    respond_to do |f|
      f.json { res.to_json }
    end
  end
end
