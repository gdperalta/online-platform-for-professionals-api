# README

# **API**

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
