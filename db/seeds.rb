puts 'Cleaning database...'
Booking.delete_all
Reservation.delete_all
Listing.delete_all

puts 'Creating listings...'
ap Listing.create!(num_rooms: 2)
ap Listing.create!(num_rooms: 1)
ap Listing.create!(num_rooms: 3)

puts 'Creating bookings...'
ap Booking.create!(listing_id: Listing.first.id, start_date: '2016-10-10'.to_date, end_date: '2016-10-15'.to_date)
ap Booking.create!(listing_id: Listing.first.id, start_date: '2016-10-16'.to_date, end_date: '2016-10-20'.to_date)
ap Booking.create!(listing_id: Listing.second.id, start_date: '2016-10-15'.to_date, end_date: '2016-10-20'.to_date)

puts 'Creating reservations...'
ap Reservation.create!(listing_id: Listing.first.id, start_date: '2016-10-11'.to_date, end_date: '2016-10-13'.to_date)
ap Reservation.create!(listing_id: Listing.first.id, start_date: '2016-10-13'.to_date, end_date: '2016-10-15'.to_date)
ap Reservation.create!(listing_id: Listing.first.id, start_date: '2016-10-16'.to_date, end_date: '2016-10-20'.to_date)
ap Reservation.create!(listing_id: Listing.second.id, start_date: '2016-10-15'.to_date, end_date: '2016-10-18'.to_date)

puts 'Finished!'
