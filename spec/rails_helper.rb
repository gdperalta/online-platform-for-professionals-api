# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.before(:suite) do
    Rails.application.load_seed # loading seeds
  end
  config.before(:suite) do
    Rails.application.load_seed # loading seeds
  end

  # Disable net connection during tests
  WebMock.disable_net_connect!(allow_localhost: true)

  config.before(:each) do
    # Calendly::Client.user
    stub_request(:get, 'https://api.calendly.com/users/me')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer authorization-token',
          'Content-Type' => 'application/json',
          'Host' => 'api.calendly.com',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
        }
      )
      .to_return(status: 200, body: '{
      "resource": {
        "avatar_url": null,
        "created_at": "2020-04-21T08:28:39.545681Z",
        "current_organization": "https://api.calendly.com/organizations/ZZZZZZZZZZ",
        "email": "godfreydjperalta@gmail.com",
        "name": "Godfrey Peralta",
        "scheduling_url": "https://calendly.com/godfreyperalta",
        "slug": "godfreyperalta",
        "timezone": "Asia/Manila",
        "updated_at": "2022-05-05T15:12:20.880793Z",
        "uri": "https://api.calendly.com/users/HHHHHHHHHH"
      }
    }', headers: {})

    # Calendly::Client.user new token
    stub_request(:get, 'https://api.calendly.com/users/me')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer new-authorization-token',
          'Content-Type' => 'application/json',
          'Host' => 'api.calendly.com',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
        }
      )
      .to_return(status: 200, body: '{
      "resource": {
        "avatar_url": null,
        "created_at": "2020-04-21T08:28:39.545681Z",
        "current_organization": "https://api.calendly.com/organizations/BBBBBBBBBBBB",
        "email": "godfreydjperalta@gmail.com",
        "name": "Godfrey Peralta",
        "scheduling_url": "https://calendly.com/godfreyperalta",
        "slug": "godfreyperalta",
        "timezone": "Asia/Manila",
        "updated_at": "2022-05-05T15:12:20.880793Z",
        "uri": "https://api.calendly.com/users/ABABABABABA"
      }
    }', headers: {})

    # Calendly::Client.events
    stub_request(:get, 'https://api.calendly.com/scheduled_events?count=5&invitee_email=client@email.com&min_start_time=2022-05-19%2000:00:00%20%2B0800&status=active&user=https://api.calendly.com/users/HHHHHHHHHH')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer authorization-token',
          'Content-Length' => '0',
          'Content-Type' => 'application/json',
          'Host' => 'api.calendly.com',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
        }
      )
      .to_return(status: 200, body: '{
          "collection": [
            {
              "created_at": "2020-04-21T13:38:30.932933Z",
              "end_time": "2020-04-24T01:30:00.000000Z",
              "event_guests": [],
              "event_memberships": [
                {
                  "user": "https://api.calendly.com/users/AEAAILCDAFWMPYKG"
                }
              ],
              "event_type": "https://api.calendly.com/event_types/FAEJV45PEUSJMKUL",
              "invitees_counter": {
                "active": 1,
                "limit": 1,
                "total": 1
              },
              "location": {
                "location": null,
                "type": "custom"
              },
              "name": "30 Minute Meeting",
              "start_time": "2020-04-24T01:00:00.000000Z",
              "status": "active",
              "updated_at": "2020-04-21T13:38:32.219639Z",
              "uri": "https://api.calendly.com/scheduled_events/ZZZZZZZZZZ"
            },
            {
              "created_at": "2020-04-21T13:42:15.677662Z",
              "end_time": "2020-04-27T02:30:00.000000Z",
              "event_guests": [],
              "event_memberships": [
                {
                  "user": "https://api.calendly.com/users/AEAAILCDAFWMPYKG"
                }
              ],
              "event_type": "https://api.calendly.com/event_types/FAEJV45PEUSJMKUL",
              "invitees_counter": {
                "active": 1,
                "limit": 1,
                "total": 1
              },
              "location": {
                "location": null,
                "type": "custom"
              },
              "name": "30 Minute Meeting",
              "start_time": "2020-04-27T02:00:00.000000Z",
              "status": "active",
              "updated_at": "2020-04-21T13:42:17.132707Z",
              "uri": "https://api.calendly.com/scheduled_events/ZZZZZZZZZZ"
            }
          ],
          "pagination": {
            "count": 2,
            "next_page": "https://api.calendly.com/scheduled_events?count=2&page_token=ci0mpSTe7jAFlnJDDTiE_DGWavakPaUK&user=https%3A%2F%2Fapi.calendly.com%2Fusers%2FAEAAILCDAFWMPYKG",
            "next_page_token": "ci0mpSTe7jAFlnJDDTiE_DGWavakPaUK",
            "previous_page": null,
            "previous_page_token": null
          }
        }', headers: {})

    # Calendly::Client.event_invitee
    stub_request(:get, 'https://api.calendly.com/scheduled_events/ZZZZZZZZZZ/invitees')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer authorization-token',
          'Content-Type' => 'application/json',
          'Host' => 'api.calendly.com',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
        }
      )
      .to_return(status: 200, body: '{
        "collection": [
          {
            "cancel_url": "https://calendly.com/cancellations/CHOW3WDOZOOE3AG5",
            "created_at": "2020-04-21T13:42:15.703243Z",
            "email": "client@email.com",
            "event": "https://api.calendly.com/scheduled_events/ADNSLLJRPYESS47F",
            "first_name": null,
            "last_name": null,
            "name": "Odie",
            "new_invitee": null,
            "no_show": null,
            "old_invitee": null,
            "payment": null,
            "questions_and_answers": [],
            "reconfirmation": null,
            "reschedule_url": "https://calendly.com/reschedulings/CHOW3WDOZOOE3AG5",
            "rescheduled": false,
            "status": "active",
            "text_reminder_number": null,
            "timezone": "Asia/Manila",
            "tracking": {
              "utm_campaign": null,
              "utm_source": null,
              "utm_medium": null,
              "utm_content": null,
              "utm_term": null,
              "salesforce_uuid": null
            },
            "updated_at": "2020-04-21T13:42:15.713896Z",
            "uri": "https://api.calendly.com/scheduled_events/ADNSLLJRPYESS47F/invitees/CHOW3WDOZOOE3AG5"
          }
        ]
      }', headers: {})

    # Calendly::Client.create_invitee_no_show
    stub_request(:post, 'https://api.calendly.com/invitee_no_shows')
      .with(
        body: '{"invitee":"Invitee_link"}',
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer authorization-token',
          'Content-Length' => '26',
          'Content-Type' => 'application/json',
          'Host' => 'api.calendly.com',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
        }
      )
      .to_return(status: 200, body: '{
          "resource": {
            "uri": "https://api.calendly.com/invitee_no_shows/no_show_link",
            "invitee": "Invitee_link",
            "created_at": "2019-01-02T03:04:05.678123Z"
          }
        }', headers: {})

    # Calendly::Client.create_invitee_no_show invalid invitee_link
    stub_request(:post, 'https://api.calendly.com/invitee_no_shows')
      .with(
        body: '{"invitee":"incorrect link"}',
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer authorization-token',
          'Content-Length' => '28',
          'Content-Type' => 'application/json',
          'Host' => 'api.calendly.com',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
        }
      )
      .to_return(status: '404 Not Found', body: '{
      "title": "Resource Not Found",
      "message": "The server could not find the requested resource."
    }', headers: {})

    # Calendly::Client.delete_invitee_no_show
    stub_request(:delete, 'https://api.calendly.com/invitee_no_shows/no_show_link')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer authorization-token',
          'Content-Length' => '0',
          'Content-Type' => 'application/json',
          'Host' => 'api.calendly.com',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
        }
      )
      .to_return(status: 204, body: '', headers: {})

    # Calendly::Client.delete_invitee_no_show invalid no_show_link
    stub_request(:delete, 'https://api.calendly.com/invitee_no_shows/invalid_show_link')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer authorization-token',
          'Content-Length' => '0',
          'Content-Type' => 'application/json',
          'Host' => 'api.calendly.com',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
        }
      )
      .to_return(status: '404 Not Found', body: '{
        "title": "Resource Not Found",
        "message": "The server could not find the requested resource."
      }', headers: {})

      stub_request(:get, "https://ph-locations-api.buonzz.com/v1/cities").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'Host'=>'ph-locations-api.buonzz.com',
          'User-Agent'=>'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
           }).
         to_return(status: 200, body: '{"id":"175101","name":"ABRA DE ILOG","region_code":"17","province_code":"1751","href":"http://127.0.0.1:3344/v1/cities/175101"}', headers: {})

      stub_request(:get, "https://ph-locations-api.buonzz.com/v1/cities?page=2").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'Host'=>'ph-locations-api.buonzz.com',
          'User-Agent'=>'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
           }).
         to_return(status: 200, body: '{"id":"175101","name":"ABRA DE ILOG","region_code":"17","province_code":"1751","href":"http://127.0.0.1:3344/v1/cities/175101"}', headers: {})

      stub_request(:get, "https://ph-locations-api.buonzz.com/v1/regions").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'Host'=>'ph-locations-api.buonzz.com',
          'User-Agent'=>'rest-client/2.1.0 (linux x86_64) ruby/3.0.3p157'
           }).
         to_return(status: 200, body: '{"id":"15","name":"AUTONOMOUS REGION IN MUSLIM MINDANAO (ARMM)","href":"http://127.0.0.1:3344/v1/regions/15"}', headers: {})
  end
end
