# Online Platform for Professionals

A simple application platform where clients can search and book appointments with professionals.

## Built with:
- Ruby 3.0
- Rails 6.1.5.1
- PostgreSQL 12.10


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

- Clone the repository and navigate to main app directory

	``` bash
	git clone https://github.com/gdperalta/online-platform-for-professionals-api.git
	cd online-platform-for-professionals-api
	```

- Install Rails API dependencies
	``` Ruby
		# For handling Cross-Origin Resource Sharing (CORS)
		gem 'rack-cors'
		# For user authentication
		gem 'devise', '~> 4.8.1'
		# For authorization token
		gem 'devise-jwt', '~> 0.9.0'
		# For json api format
		gem 'jsonapi-serializer', '~> 2.2.0'
		# For pagination
		gem 'pagy', '~> 5.10'
		# For user authorization
		gem 'pundit', '~> 2.2.0'
		# For searches
		gem 'ransack', '~> 3.0.1'
		# For request of external API
		gem 'rest-client', '~> 2.1.0'
		#For tests and development
		gem 'factory_bot_rails', '~> 6.2.0'
		gem 'rspec-rails', '~> 5.1.1'
		gem 'webmock', '~> 3.14.0'
	```

	Then run the command
	``` bash
		bundle install
	```
- Initialize the database
	``` bash
		rails db:create
		rails db:migrate
		rails db:seed
	```
- Run the server
	``` bash
		rails s
	```


## **API**

## **Session**

### _Post /login_

**Request**

Body:

- email
  - email of the user to be logged in
- password
  - password of the user to be logged in

**Sample Response**

```json
{
	"data": {
		"id": "2",
		"type": "personalDetails",
		"attributes": {
			"email": "test@email.com",
			"firstName": "John",
			"lastName": "Lloyd",
			"contactNumber": "9151234567",
			"city": "Manila",
			"region": "NCR",
			"role": "professional"
		},
		"relationships": {
			"professional": {
				"data": {
					"id": "1",
					"type": "professional"
				}
			}
		}
	},
	"included": [
		{
			"id": "1",
			"type": "professional",
			"attributes": {
				"field": "Programmer",
				"licenseNumber": "0012345",
				"officeAddress": null,
				"headline": null
			},
			"relationships": {
				"user": {
					"data": {
						"id": "2",
						"type": "personalDetails"
					}
				},
				"workPortfolios": {
					"data": [
						{
							"id": "1",
							"type": "workPortfolio"
						}
					]
				},
				"services": {
					"data": [
						{
							"id": "1",
							"type": "service"
						}
					]
				},
				"reviews": {
					"data": [
						{
							"id": "1",
							"type": "review"
						},
						{
							"id": "2",
							"type": "review"
						},
						{
							"id": "3",
							"type": "review"
						},
						{
							"id": "4",
							"type": "review"
						}
					]
				},
				"calendlyToken": {
					"data": {
						"id": "2",
						"type": "calendlyToken"
					}
				}
			}
		}
	]
}
```

## **Professional**

### _Get /professionals_

**Request**

Headers:

- Authorization
  - _Authorization token from login response headers_

**Sample Response**

```json
{
	"data": [
		{
			"id": "1",
			"type": "professional",
			"attributes": {
				"field": "Programmer",
				"licenseNumber": "0012345",
				"officeAddress": null,
				"headline": null
			},
			"relationships": {
				"user": {
					"data": {
						"id": "2",
						"type": "personalDetails"
					}
				},
				"workPortfolios": {
					"data": [
						{
							"id": "1",
							"type": "workPortfolio"
						}
					]
				},
				"services": {
					"data": [
						{
							"id": "1",
							"type": "service"
						}
					]
				},
				"reviews": {
					"data": [
						{
							"id": "1",
							"type": "review"
						},
						{
							"id": "2",
							"type": "review"
						},
						{
							"id": "3",
							"type": "review"
						}
					]
				}
			}
		}
	],
	"included": [
		{
			"id": "2",
			"type": "personalDetails",
			"attributes": {
				"email": "test@email.com",
				"firstName": "John",
				"lastName": "Lloyd",
				"contactNumber": "9151234567",
				"city": "Manila",
				"region": "NCR",
				"role": "professional"
			}
		},
		{
			"id": "1",
			"type": "workPortfolio",
			"attributes": {
				"professionalId": 1,
				"title": "Work Portfolio Title",
				"details": "Work Portfolio Details"
			}
		},
		{
			"id": "1",
			"type": "service",
			"attributes": {
				"professionalId": 1,
				"title": "Service Title",
				"details": "Srrvice Details",
				"minPrice": 1.0,
				"maxPrice": 10.0
			}
		},
		{
			"id": "1",
			"type": "review",
			"attributes": {
				"rating": 3,
				"body": "New text"
			},
			"relationships": {
				"professional": {
					"data": {
						"id": "1",
						"type": "professional"
					}
				},
				"client": {
					"data": {
						"id": "1",
						"type": "client"
					}
				}
			}
		},
		{
			"id": "2",
			"type": "review",
			"attributes": {
				"rating": 5,
				"body": "New review"
			},
			"relationships": {
				"professional": {
					"data": {
						"id": "1",
						"type": "professional"
					}
				},
				"client": {
					"data": {
						"id": "1",
						"type": "client"
					}
				}
			}
		},
		{
			"id": "3",
			"type": "review",
			"attributes": {
				"rating": 5,
				"body": "New review"
			},
			"relationships": {
				"professional": {
					"data": {
						"id": "1",
						"type": "professional"
					}
				},
				"client": {
					"data": {
						"id": "1",
						"type": "client"
					}
				}
			}
		}
	]
}
```

### _Get /professional/{:id}_

**Request**

Headers:

- Authorization
  - _Authorization token from login response headers_

Params:

- :id
  - _ID of professional_

**Sample Response**

```json
{
	"data": {
		"id": "1",
		"type": "professional",
		"attributes": {
			"field": "Programmer",
			"licenseNumber": "0012345",
			"officeAddress": null,
			"headline": null
		},
		"relationships": {
			"user": {
				"data": {
					"id": "2",
					"type": "personalDetails"
				}
			},
			"workPortfolios": {
				"data": [
					{
						"id": "1",
						"type": "workPortfolio"
					}
				]
			},
			"services": {
				"data": [
					{
						"id": "1",
						"type": "service"
					}
				]
			},
			"reviews": {
				"data": [
					{
						"id": "1",
						"type": "review"
					},
					{
						"id": "2",
						"type": "review"
					},
					{
						"id": "3",
						"type": "review"
					}
				]
			}
		}
	},
	"included": [
		{
			"id": "2",
			"type": "personalDetails",
			"attributes": {
				"email": "test@email.com",
				"firstName": "John",
				"lastName": "Lloyd",
				"contactNumber": "9151234567",
				"city": "Manila",
				"region": "NCR",
				"role": "professional"
			},
			"relationships": {
				"professional": {
					"data": {
						"id": "1",
						"type": "professional"
					}
				}
			}
		},
		{
			"id": "1",
			"type": "workPortfolio",
			"attributes": {
				"professionalId": 1,
				"title": "Work Portfolio Title",
				"details": "Work Portfolio Details"
			}
		},
		{
			"id": "1",
			"type": "service",
			"attributes": {
				"professionalId": 1,
				"title": "Service Title",
				"details": "Srrvice Details",
				"minPrice": 1.0,
				"maxPrice": 10.0
			}
		},
		{
			"id": "1",
			"type": "review",
			"attributes": {
				"rating": 3,
				"body": "New text"
			},
			"relationships": {
				"professional": {
					"data": {
						"id": "1",
						"type": "professional"
					}
				},
				"client": {
					"data": {
						"id": "1",
						"type": "client"
					}
				}
			}
		},
		{
			"id": "2",
			"type": "review",
			"attributes": {
				"rating": 5,
				"body": "New review"
			},
			"relationships": {
				"professional": {
					"data": {
						"id": "1",
						"type": "professional"
					}
				},
				"client": {
					"data": {
						"id": "1",
						"type": "client"
					}
				}
			}
		},
		{
			"id": "3",
			"type": "review",
			"attributes": {
				"rating": 5,
				"body": "New review"
			},
			"relationships": {
				"professional": {
					"data": {
						"id": "1",
						"type": "professional"
					}
				},
				"client": {
					"data": {
						"id": "1",
						"type": "client"
					}
				}
			}
		}
	]
}
```

### _Post /professionals_

Create professional field details for a user with role 'professional'

**Request**

Headers:

- Authorization
  - _Authorization token from login response headers_

Body:

- user_id
  - ID of user
