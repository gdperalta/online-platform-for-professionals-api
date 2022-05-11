# README

## **API**

### **Professional**

#### Get /professionals

**Request**

Headers:
Authorization
_Get the authorization token from login response headers_

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

#### Get /professional/{:id}

**Request**

Headers:
Authorization
_Get the authorization token from login response headers_

Params:
:id
_id of professional_

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
