require 'sinatra'
require 'nokogiri'

post '/mockpws/:test_id' do
  #parse request and return corresponding response
  request.body.rewind
  data = request.body.read

  doc = Nokogiri::XML::Document.parse(data)
  request_name = doc.root.name
  test_id =  params[:test_id]
  response_for(request_name, test_id)
end


def response_for(request_name,test_id)

  resp_file = request_name.gsub('Request','Response')
  unless test_id.empty?
    resp_file = resp_file + '_' + test_id
  end
    
  IO.read("public/#{resp_file}.xml")
end

get '/' do
  File.read(File.join('public', 'index.html'))
end