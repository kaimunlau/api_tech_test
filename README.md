Backend test
Disclaimer before we begin - the idea of this tech test is to push your technical limits. It's purposefully putting you in front of a problem you've not learnt how to handle yet, so you can see how you do at figuring out how to solve problems using all the tools you've learnt up until now. If it seems like I'm throwing you in at the deep end, it's because I am... don't panic, start swimming, see how far you can get.

So, on to the task :

We are building a listing rentals management company

Create a new rails app.

3 main objects populate our app:

listings: apartments of our clients
bookings: periods of time during which our clients leave us their apartment
reservations: periods of time during which a guest rents one of our apartments
bookings and reservations BELONG to listing (they both have a listing_id) but are not otherwise directly related to one another.

Listings can be removed from the site, in which case their bookings and reservations should be removed too.

Bookings can be cancelled, in which case any reservations existing during that booking should be cancelled too.

Here is the content you should copy into your seed.rb file located in ./db/seeds.rb

Booking.delete_all
Reservation.delete_all
Listing.delete_all

Listing.create!(num_rooms: 2)
Listing.create!(num_rooms: 1)
Listing.create!(num_rooms: 3)

Booking.create!(listing_id: Listing.first.id, start_date: "2016-10-10".to_date, end_date: "2016-10-15".to_date)
Booking.create!(listing_id: Listing.first.id, start_date: "2016-10-16".to_date, end_date: "2016-10-20".to_date)
Booking.create!(listing_id: Listing.second.id, start_date: "2016-10-15".to_date, end_date: "2016-10-20".to_date)

Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-11".to_date, end_date: "2016-10-13".to_date)
Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-13".to_date, end_date: "2016-10-15".to_date)
Reservation.create!(listing_id: Listing.first.id, start_date: "2016-10-16".to_date, end_date: "2016-10-20".to_date)
Reservation.create!(listing_id: Listing.second.id, start_date: "2016-10-15".to_date, end_date: "2016-10-18".to_date)
Goal
You need to create a Rails Application using Active records which has:

JSON API:
CRUD (INDEX/ SH0W/ CREATE/ UPDATE / DELETE ) on listing
Note: no authentication is required

The output of the index endpoint (on your local development environment this will usually be localhost:3000/listings) to retrieve listings created should resemble this after launching the seed

{
    "listings": [
        {
            "id": 1,
            "num_rooms": 2
        },
        {
            "id": 2,
            "num_rooms": 1
        },
        {
            "id": 3,
            "num_rooms": 3
        }
    ]
}

Go slowly, and write code that could be easily extensible and clean.

To interact with your API you can use Postman

More info on how to get started using Postman here :

https://learning.postman.com/docs/getting-started/first-steps/sending-the-first-request/
https://learning.postman.com/docs/sending-requests/requests/
Tips to get you started :

Generate an API only rails app : $ rails new my_api --api

Copy the lines from the readme into seeds.rb

Map out the relationships between your models

Add the models

Add only the necessary CRUD actions for listing and test them with Postman

Remember the principal types of HTTP request and how they differ (you're going to need GET, POST, PUT/PATCH, DELETE)

Bonus - extend your API with a missions
This bit is for if you managed to finish the initial goal, and you're hungry for more, no pressure to get any of this done - if you've made it this far you already did an amazing job!

The bonus challenge is to add a mission model. A mission represents a session cleaning the appartment.

missions also BELONG_TO listing, but are not directly linked to any other model.
Here is our plan to clean the apartment, at any time:

We should have a cleaning mission called first_checkin at the beginning of the booking We should have a cleaning mission called last_checkout before the owner comes back We should have a cleaning mission called checkout_checkin at the end of each reservation UNLESS there is alrea dy a last_checkout at the same date

If a reservation or booking is cancelled, we also want to cancel any missions that were created in relation to them

Missions have a price which also needs to be calculated:

a first checkin costs 10€ per room
a checkout checkin costs 10€ per room
a last checkout costs 5€ per room
We want to be able to consult the existing missions via our API, so you need to add a missions index

Once you've added the logic for creating missions, run rails db:seed:replant and then run the request to retrieve your missions index. It should resemble this example: { "missions": [ {:listing_id=>1, :mission_type=>"first_checkin", :date=>"2016-10-10", :price=>20}, {:listing_id=>1, :mission_type=>"last_checkout", :date=>"2016-10-15", :price=>10}, {:listing_id=>1, :mission_type=>"first_checkin", :date=>"2016-10-16", :price=>20}, {:listing_id=>1, :mission_type=>"last_checkout", :date=>"2016-10-20", :price=>10}, {:listing_id=>1, :mission_type=>"checkout_checkin", :date=>"2016-10-13", :price=>20}, {:listing_id=>2, :mission_type=>"first_checkin", :date=>"2016-10-15", :price=>10}, {:listing_id=>2, :mission_type=>"last_checkout", :date=>"2016-10-20", :price=>5}, {:listing_id=>2, :mission_type=>"checkout_checkin", :date=>"2016-10-18", :price=>10} ] }
