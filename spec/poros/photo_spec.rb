require 'rails_helper'

describe Photo, type: :poros do
  before :each do
    photo_info = {
    "total": 10000,
    "total_pages": 1000,
    "results": [
        {
            "id": "m49y6IOk784",
            "description": "Downtown Denver summer 2017",
            "urls": {
                "regular": "https://images.unsplash.com/photo-1603033156166-2ae22eb2b7e2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkxNDl8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY28sY2l0eXxlbnwwfHx8&ixlib=rb-1.2.1&q=80&w=1080"
            },
            "links": {
                "self": "https://api.unsplash.com/photos/m49y6IOk784",
                "html": "https://unsplash.com/photos/m49y6IOk784"
            },
            "user": {
                "id": "iReUjmhpLcw",
                "username": "andrewcoop",
                "name": "Andrew Coop",
                "first_name": "Andrew",
                "last_name": "Coop",
                "location": "Aurora, CO, USA",
                "links": {
                    "self": "https://api.unsplash.com/users/andrewcoop",
                    "html": "https://unsplash.com/@andrewcoop",
                    "photos": "https://api.unsplash.com/users/andrewcoop/photos"
                    }
                }
              }
            ]
        }
    params = {
      location: "denver,co"
    }

    @photo = Photo.new(photo_info, params)
  end

  it 'can create a Photo object' do
    expect(@photo).to be_an_instance_of(Photo)
    expect(@photo.image[:location]).to eq("denver,co")
    expect(@photo.image[:image_url]).to eq("https://images.unsplash.com/photo-1603033156166-2ae22eb2b7e2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkxNDl8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY28sY2l0eXxlbnwwfHx8&ixlib=rb-1.2.1&q=80&w=1080")

    expect(@photo.image[:credit]).to be_a(Hash)
    credit = @photo.image[:credit]
    expect(credit[:photographer_name]).to eq("Andrew Coop")
    expect(credit[:photographer_profile_link]).to eq("https://unsplash.com/@andrewcoop?utm_source=road_tripper&utm_medium=referral")
    expect(credit[:source_link]).to eq("https://unsplash.com/?utm_source=road_tripper&utm_medium=referral")
  end
end
