# Tamnoon Chat

This is an example app using Phoenix for the backend and Tamnoon v1.0.0-a.5 for the frontend.

## Setup

The app will not have any data in the DB initially, so to use it you must first create users and rooms.

To do so, send a POST request to /api/users with the following JSON body: (the password is 'abc' hashed in sha256)

```
{
	"user": {
		"username": "...",
		"password_hash": "ungWv48Bz+pBQUDeXa4iI7ADYaOWF3qctBD/YfIAFa0="
	}
}
```

And create a room with a POST request to /api/rooms with the following body:

```
{
	"room": {
		"name": "..."
	}
}
```

Then run the backend with `mix phx.server` and the frontend with `mix run --no-halt`.
