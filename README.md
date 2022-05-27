# Online Platform for Professionals API (OPPA)

![Ruby 3.0.3](https://img.shields.io/badge/Ruby-%3E%3D3.0.3-red) ![Rails 6.1.4.6](https://img.shields.io/badge/Rails-6.1.4.6-red) ![Yarn 1.22.10](https://img.shields.io/badge/Yarn-1.22.10-%232188b6%3B) ![PostgrSQL 12.9](https://img.shields.io/badge/PostgreSQL-12.9-%23336791)

## **About the project**

API used for the project in Avion schoool where clients can search and book appointments with professionals.

## **Key Features**

- Create an account as a professional so they can showcase their services and expertise.
- Integrate with calendy by adding the authorization token given by calendly (Booking and canceling schedules can be done on the Front End of the project)
- Mark a client as a no show in an appointment (integrated with Calendly API)
- Create an account as a client so they can search for the professional whose services they require.
- Search for a professional by name, field of specialization, or services.
- Subscribe to a professional to be able to book an appointment with them. (Subscription required in order to track the bookings from calendly related to the app)
- Add a review after a confirmed appointment with the professional

## **Other Features**

- Sends a confirmation email to confirm the email address of the user
- Allows an admin to approve a user before they can start using the app
- Sends an email to the trader when they are approved.

## **ERD**

![ERD][erd_pic]

## **Endpoints and Documentation**

Visit [OPPA Documentation](https://app.swaggerhub.com/apis-docs/gdperalta924/OPPA/1) to see all the endpoints of the application.

## **Live API**

The live API can be accessed using the following base URL

> https://professional-platform-api.herokuapp.com

## **Getting Started**

### **Prerequisites**

The setups steps expect the Builds listed above to be installed on the system.

### **Instructions**

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

- Clone the repository and navigate to main app directory

```bash
git clone https://github.com/gdperalta/online-platform-for-professionals-api.git
cd online-platform-for-professionals-api
```

- Install Rails API dependencies

```bash
bundle install
```

- Initialize the database

```bash
rails db:create
rails db:migrate
rails db:seed fields=yes
```

- Run the server

```bash
rails server
```

## **Tests**

Used [RSpec](https://rspec.info) to test the request and models of the app.
Run the following command to run the tests.

```bash
rspec --format documentation
```

## **Environments**

[Frontend Repository](https://github.com/dwghdev/online-platform-for-professionals-frontend)

[Deployed Frontend App](https://online-platform-for-professionals-frontend.vercel.app)

[Philippines Location API](https://ph-locations-api.buonzz.com/docs)

[Calendly API](https://developer.calendly.com/api-docs/ZG9jOjQ1Mg-calendly-developer)

## **System dependencies**

### **Gems**

- Rack-cors 1.1.1
- Devise 4.8.1
- Devise-jwt 0.9.0
- Jsonapi-serializer 2.2.0
- Pagy 5.10
- Pundit 2.2.0
- Ransack 3.0.1
- Rest-client 2.1.0
- Rspec-rails 5.1.1'
- Factory_bot_rails 6.2.0'
- Webmock 3.14.0'

## **Authors**

- Godfrey Peralta
- Dale Walter
- Jerick Borela

## **Roadmap**

- [ ] Add image storage for work portfolio and services
- [ ] Add api for messaging
- [ ] Refactor repeating codes
- [ ] Apply sentiment analysis to reviews

[erd_pic]: docs/img/opp_erd.png
