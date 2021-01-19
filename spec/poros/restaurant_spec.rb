require 'rails_helper'

describe Restaurant, type: :poros do
  it "creates a restaurant object" do
    data = {
      :id=>"kQxM1xlaZfQmXpKaqMTNnw",
      :alias=>"wonderful-bistro-pueblo",
      :name=>"Wonderful Bistro",
      :location=>
       {:address1=>"4602 N Elizabeth St",
        :address2=>"Ste 120",
        :address3=>"",
        :city=>"Pueblo",
        :zip_code=>"81008",
        :country=>"US",
        :state=>"CO",
        :display_address=>["4602 N Elizabeth St", "Ste 120", "Pueblo, CO 81008"]},
      :phone=>"+17195440233",
      :display_phone=>"(719) 544-0233",
      :distance=>6632.28027227077
    }

    restaurant = Restaurant.new(data)

    expect(restaurant.name).to eq("Wonderful Bistro")
    expect(restaurant.address).to eq("4602 N Elizabeth St,Ste 120,Pueblo, CO 81008")
  end
end
