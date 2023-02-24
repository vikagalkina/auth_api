# API Documentation

## Create user
### POST /users

```
{
    "username": "FirstUser",
    "password": "password"
}
```
**Success response:**
status 200
```
{
    "id": 1,
    "username": "FirsUser"
}
```
**Fail response:**
status 422
```
{
    "error": "Username can't be blank\nPassword can't be blank\nPassword is too short (minimum is 8 characters)"
}
```

## Authenticate user
### POST /users/authenticate

```
{
    "username": "FirstUser",
    "password": "password"
}
```
**Success response:**
status 200
```
{
    "id": "1",
    "username": "FirstUser
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTYiLCJleHAiOjE2Nzc4MzE3MTl9.Naza9eBuu2alJpMW1EK_M05NpFVoDleztPwBrxho3cM"
}
```
**Fail response:**
status 401
```
{
    "error": "Invalid username or password"
}
```
