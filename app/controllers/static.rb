require 'securerandom'

get '/' do
  @urls = Url.all.order("created_at DESC")
  erb :"static/index"
end

get '/:complete' do
  @complete_link = params[:complete]

    Url.all.each do |x|
    if x.short_url == @complete_link
      redirect x.long_url
    else
      @urls = Url.all.order("created_at DESC")

      erb :"static/index"
    end
  end
end



post '/shorten' do

  @url = Url.new(long_url: params["long_url"], short_url: SecureRandom.hex(4))
    if @url.save
      redirect '/'
     else
       @errors = @url.errors.full_messages.join(",")
       #this is the error message give from ActiveRecord because it does
       #not pass the validation stated on model erb

    #   i need my code to remember my error variaable when its not saved successfully, thats why
    #   i load the erb instead of redirecting to '/' because once i do redirecting to '/',
    #   my code will forget the defined local variable
    end
    @urls = Url.all.order("created_at DESC")
    erb :"static/index"
end

post '/:id/vote' do
  #whatever you see on the browser is the value, and
  #then the key i set to id by inserting :here

  #1) find out which url im upvoting
  @url = Url.find(params[:id])

  @url.click_count += 1
  @url.save
  redirect '/'

end


get '/:shortshort' do
#   1)look for this url now
#   2)increase the click count (bcz i just click on the shortlink)
#   3)i will redirect to the long url
  @url = Url.find_by(short_url: params[:shortshort])
  @url.click_count += 1
  @url.save

  redirect "#{@url.long_url}"
end
